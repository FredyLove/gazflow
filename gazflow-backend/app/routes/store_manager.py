# app/store_manager/routes.py
from fastapi import APIRouter, Depends, HTTPException
from typing import List
from bson import ObjectId
from datetime import datetime
from app.models.store_manager import StoreModel, GasBottleModel, OrderModel
from app.schemas.store_manager import (
    StoreCreateSchema, StoreResponseSchema,
    GasBottleCreateSchema, GasBottleResponseSchema,
    AssignOrderSchema, OrderResponseSchema
)
from app.core.security import get_current_manager
from app.db.mongo import db

router = APIRouter(prefix="/stores", tags=["Store Manager"])

# -------------------------------
# Store CRUD
# -------------------------------

# -------------------------------
# Startup: Ensure 2dsphere index
# -------------------------------
def ensure_2dsphere_index():
    db["db"]["stores"].create_index([("location", "2dsphere")])
    print("✅ 2dsphere index ensured on stores.location")

# Call this in your FastAPI startup event
# @app.on_event("startup")
# def startup_event():
#     ensure_2dsphere_index()

# -------------------------------
# Store CRUD
# -------------------------------

@router.post("/", response_model=StoreResponseSchema)
def create_store(data: StoreCreateSchema, current_user: dict = Depends(get_current_manager)):
    stores_collection = db["db"]["stores"]
    store_data = data.dict()
    store_data["manager_id"] = ObjectId(current_user["_id"])
    store_data["created_at"] = datetime.utcnow()

    # Automatically create 'location' field
    store_data["location"] = {
        "type": "Point",
        "coordinates": [store_data["longitude"], store_data["latitude"]]
    }

    result = stores_collection.insert_one(store_data)
    return StoreResponseSchema(
        id=str(result.inserted_id),
        manager_id=str(current_user["_id"]),
        **data.dict(),
        created_at=store_data["created_at"]
    )

@router.get("/", response_model=List[StoreResponseSchema])
def list_stores(current_user: dict = Depends(get_current_manager)):
    stores_collection = db["db"]["stores"]
    stores = list(stores_collection.find({"manager_id": ObjectId(current_user["_id"])}))
    return [StoreResponseSchema(
        id=str(s["_id"]),
        name=s["name"],
        address=s["address"],
        latitude=s["latitude"],
        longitude=s["longitude"],
        manager_id=str(s["manager_id"]),
        created_at=s["created_at"]
    ) for s in stores]

@router.get("/{store_id}", response_model=StoreResponseSchema)
def get_store(store_id: str, current_user: dict = Depends(get_current_manager)):
    stores_collection = db["db"]["stores"]
    store = stores_collection.find_one({"_id": ObjectId(store_id), "manager_id": ObjectId(current_user["_id"])})
    if not store:
        raise HTTPException(status_code=404, detail="Store not found")
    return StoreResponseSchema(
        id=str(store["_id"]),
        name=store["name"],
        address=store["address"],
        latitude=store["latitude"],
        longitude=store["longitude"],
        manager_id=str(store["manager_id"]),
        created_at=store["created_at"]
    )

@router.patch("/{store_id}", response_model=StoreResponseSchema)
def update_store(store_id: str, data: StoreCreateSchema, current_user: dict = Depends(get_current_manager)):
    stores_collection = db["db"]["stores"]
    update_data = data.dict()

    # Update location automatically
    update_data["location"] = {
        "type": "Point",
        "coordinates": [update_data["longitude"], update_data["latitude"]]
    }

    result = stores_collection.update_one(
        {"_id": ObjectId(store_id), "manager_id": ObjectId(current_user["_id"])},
        {"$set": update_data}
    )
    if result.matched_count == 0:
        raise HTTPException(status_code=404, detail="Store not found")

    store = stores_collection.find_one({"_id": ObjectId(store_id)})
    return StoreResponseSchema(
        id=str(store["_id"]),
        manager_id=str(store["manager_id"]),
        name=store["name"],
        address=store["address"],
        latitude=store["latitude"],
        longitude=store["longitude"],
        created_at=store["created_at"]
    )

@router.delete("/{store_id}")
def delete_store(store_id: str, current_user: dict = Depends(get_current_manager)):
    stores_collection = db["db"]["stores"]
    result = stores_collection.delete_one({"_id": ObjectId(store_id), "manager_id": ObjectId(current_user["_id"])})
    if result.deleted_count == 0:
        raise HTTPException(status_code=404, detail="Store not found")
    return {"detail": "Store deleted successfully"}
# -------------------------------
# Gas Bottles CRUD
# -------------------------------

@router.post("/{store_id}/gas-bottles", response_model=GasBottleResponseSchema)
def add_bottle(store_id: str, data: GasBottleCreateSchema, current_user: dict = Depends(get_current_manager)):
    bottles_collection = db["db"]["gas_bottles"]
    bottle_data = data.dict()
    bottle_data["store_id"] = ObjectId(store_id)
    bottle_data["created_at"] = datetime.utcnow()
    result = bottles_collection.insert_one(bottle_data)
    return GasBottleResponseSchema(id=str(result.inserted_id), store_id=store_id, **data.dict(), created_at=bottle_data["created_at"])

@router.get("/{store_id}/gas-bottles", response_model=List[GasBottleResponseSchema])
def list_bottles(store_id: str, current_user: dict = Depends(get_current_manager)):
    bottles_collection = db["db"]["gas_bottles"]
    bottles = list(bottles_collection.find({"store_id": ObjectId(store_id)}))
    return [GasBottleResponseSchema(
        id=str(b["_id"]),
        store_id=str(b["store_id"]),
        name=b["name"],
        price=b["price"],
        quantity=b["quantity"],
        created_at=b["created_at"]
    ) for b in bottles]

@router.patch("/{store_id}/gas-bottles/{bottle_id}", response_model=GasBottleResponseSchema)
def update_bottle(store_id: str, bottle_id: str, data: GasBottleCreateSchema, current_user: dict = Depends(get_current_manager)):
    bottles_collection = db["db"]["gas_bottles"]
    result = bottles_collection.update_one(
        {"_id": ObjectId(bottle_id), "store_id": ObjectId(store_id)},
        {"$set": data.dict()}
    )
    if result.matched_count == 0:
        raise HTTPException(status_code=404, detail="Bottle not found")
    bottle = bottles_collection.find_one({"_id": ObjectId(bottle_id)})
    return GasBottleResponseSchema(
        id=str(bottle["_id"]),
        store_id=str(bottle["store_id"]),
        name=bottle["name"],
        price=bottle["price"],
        quantity=bottle["quantity"],
        created_at=bottle["created_at"]
    )

@router.delete("/{store_id}/gas-bottles/{bottle_id}")
def delete_bottle(store_id: str, bottle_id: str, current_user: dict = Depends(get_current_manager)):
    bottles_collection = db["db"]["gas_bottles"]
    result = bottles_collection.delete_one({"_id": ObjectId(bottle_id), "store_id": ObjectId(store_id)})
    if result.deleted_count == 0:
        raise HTTPException(status_code=404, detail="Bottle not found")
    return {"detail": "Bottle deleted successfully"}

# -------------------------------
# Orders (assign driver)
# -------------------------------

@router.post("/orders/{order_id}/assign")
def assign_order(order_id: str, data: AssignOrderSchema, current_user: dict = Depends(get_current_manager)):
    orders_collection = db["db"]["orders"]
    result = orders_collection.update_one(
        {"_id": ObjectId(order_id)},
        {"$set": {"driver_id": ObjectId(data.driver_id), "status": "assigned"}}
    )
    if result.matched_count == 0:
        raise HTTPException(status_code=404, detail="Order not found")
    order = orders_collection.find_one({"_id": ObjectId(order_id)})
    return {"detail": f"Order {order_id} assigned to driver {data.driver_id}"}

@router.get("/orders/pending", response_model=List[OrderResponseSchema])
def pending_orders(current_user: dict = Depends(get_current_manager)):
    orders_collection = db["db"]["orders"]
    orders = list(orders_collection.find({"status": "pending"}))
    return [OrderResponseSchema(
        id=str(o["_id"]),
        customer_id=str(o["customer_id"]),
        store_id=str(o["store_id"]),
        bottles=o["bottles"],
        status=o["status"],
        driver_id=str(o["driver_id"]) if o.get("driver_id") else None,
        created_at=o["created_at"],
        delivered_at=o.get("delivered_at")
    ) for o in orders]
