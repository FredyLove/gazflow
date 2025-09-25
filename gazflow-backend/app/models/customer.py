from pydantic import BaseModel, Field
from typing import List, Optional
from datetime import datetime
from bson import ObjectId

# -----------------------
# PyObjectId helper (Pydantic v2)
# -----------------------
class PyObjectId(ObjectId):
    @classmethod
    def __get_validators__(cls):
        yield cls.validate

    @classmethod
    def validate(cls, v):
        if not ObjectId.is_valid(v):
            raise ValueError("Invalid objectid")
        return ObjectId(v)

    @classmethod
    def __get_pydantic_json_schema__(cls, core_schema, handler):
        return {"type": "string", "title": "ObjectId"}

# -----------------------
# Customer Models
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

class BottleOrder(BaseModel):
    bottle_id: PyObjectId
    quantity: int

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
