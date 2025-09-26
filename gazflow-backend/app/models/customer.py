from pydantic import BaseModel, Field
from pydantic import GetCoreSchemaHandler
from pydantic_core import core_schema
from typing import List, Optional
from datetime import datetime
from bson import ObjectId
from typing import Any

from app.db.mongo import db  # db is a dict, database stored in db["db"]

# -----------------------
# PyObjectId helper (Pydantic v2 compatible)
# -----------------------
class PyObjectId(ObjectId):
    @classmethod
    def __get_pydantic_core_schema__(cls, _source_type, _handler: GetCoreSchemaHandler):
        return core_schema.no_info_wrap_validator_function(
            cls.validate,  # validation logic
            core_schema.str_schema()  # expect input as str
        )

    @classmethod
    def validate(cls, v, _info=None):
        if not ObjectId.is_valid(v):
            raise ValueError("Invalid ObjectId")
        return ObjectId(v)

    @classmethod
    def __get_pydantic_json_schema__(cls, _core_schema, _handler):
        # when generating OpenAPI docs
        return {"type": "string", "example": "60d5f4842f8fb814c89d1234"}
    
# -----------------------
# Store Model
# -----------------------
class Store(BaseModel):
    id: Optional[PyObjectId] = Field(alias="_id")
    name: str
    address: str
    latitude: float
    longitude: float
    manager_id: PyObjectId
    created_at: Optional[datetime] = None

    model_config = {
        "populate_by_name": True,
        "arbitrary_types_allowed": True,
        "json_encoders": {ObjectId: str, datetime: lambda v: v.isoformat()},
    }

    @staticmethod
    def nearby(lat: float, lng: float, max_distance_m: int = 10000) -> List["Store"]:
        results = db["db"]["stores"].find({
            "location": {
                "$near": {
                    "$geometry": {"type": "Point", "coordinates": [lng, lat]},
                    "$maxDistance": max_distance_m
                }
            }
        })
        stores = []
        for s in results:
            stores.append(Store(
                id=s["_id"],
                name=s.get("name"),
                address=s.get("address"),
                latitude=s["location"]["coordinates"][1],
                longitude=s["location"]["coordinates"][0],
                manager_id=s.get("manager_id"),
                created_at=s.get("created_at")
            ))
        return stores

# -----------------------
# GasBottle Model
# -----------------------
class GasBottle(BaseModel):
    id: Optional[PyObjectId] = Field(alias="_id")
    store_id: PyObjectId
    name: str
    price: float
    quantity: int
    created_at: Optional[datetime] = None

    model_config = {
        "populate_by_name": True,
        "arbitrary_types_allowed": True,
        "json_encoders": {ObjectId: str, datetime: lambda v: v.isoformat()},
    }

    @staticmethod
    def by_store(store_id: str) -> List["GasBottle"]:
        results = db["db"]["gas_bottles"].find({"store_id": ObjectId(store_id)})
        bottles = []
        for b in results:
            bottles.append(GasBottle(
                id=b["_id"],
                store_id=b["store_id"],
                name=b["name"],
                price=b["price"],
                quantity=b["quantity"],
                created_at=b.get("created_at")
            ))
        return bottles

# -----------------------
# BottleOrder
# -----------------------
class BottleOrder(BaseModel):
    bottle_id: PyObjectId
    quantity: int

# -----------------------
# Order Model
# -----------------------
class Order(BaseModel):
    id: Optional[PyObjectId] = Field(alias="_id")
    customer_id: PyObjectId
    store_id: PyObjectId
    bottles: List[BottleOrder]
    status: str = "pending"
    driver_id: Optional[PyObjectId] = None
    created_at: Optional[datetime] = None
    delivered_at: Optional[datetime] = None

    model_config = {
        "populate_by_name": True,
        "arbitrary_types_allowed": True,
        "json_encoders": {ObjectId: str, datetime: lambda v: v.isoformat()},
    }

    @staticmethod
    def create(customer_id: str, store_id: str, bottles_data: List[dict]) -> "Order":
        order_data = {
            "customer_id": ObjectId(customer_id),
            "store_id": ObjectId(store_id),
            "bottles": bottles_data,
            "status": "pending",
            "created_at": datetime.utcnow(),
            "driver_id": None,
            "delivered_at": None
        }
        result = db["db"]["orders"].insert_one(order_data)
        return Order(
            id=result.inserted_id,
            customer_id=order_data["customer_id"],
            store_id=order_data["store_id"],
            bottles=[BottleOrder(**b) for b in bottles_data],
            status=order_data["status"],
            driver_id=order_data["driver_id"],
            created_at=order_data["created_at"],
            delivered_at=order_data["delivered_at"]
        )

    @staticmethod
    def list_by_customer(customer_id: str) -> List["Order"]:
        results = db["db"]["orders"].find({"customer_id": ObjectId(customer_id)})
        orders = []
        for o in results:
            orders.append(Order(
                id=o["_id"],
                customer_id=o["customer_id"],
                store_id=o["store_id"],
                bottles=[BottleOrder(**b) for b in o["bottles"]],
                status=o.get("status", "pending"),
                driver_id=o.get("driver_id"),
                created_at=o.get("created_at"),
                delivered_at=o.get("delivered_at")
            ))
        return orders

    @staticmethod
    def get_by_id(order_id: str, customer_id: str) -> Optional["Order"]:
        o = db["db"]["orders"].find_one({
            "_id": ObjectId(order_id),
            "customer_id": ObjectId(customer_id)
        })
        if not o:
            return None
        return Order(
            id=o["_id"],
            customer_id=o["customer_id"],
            store_id=o["store_id"],
            bottles=[BottleOrder(**b) for b in o["bottles"]],
            status=o.get("status", "pending"),
            driver_id=o.get("driver_id"),
            created_at=o.get("created_at"),
            delivered_at=o.get("delivered_at")
        )
