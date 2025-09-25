# app/driver/routes.py
from fastapi import APIRouter, Depends, HTTPException
from typing import List
from bson import ObjectId
from datetime import datetime
from app.models.driver import OrderModel, DriverLocationModel
from app.schemas.driver import OrderResponseSchema, UpdateOrderStatusSchema, DriverLocationUpdateSchema, BottleOrderSchema
from app.core.security import get_current_driver
from app.db.mongo import db

router = APIRouter(prefix="/driver", tags=["Driver"])

# -------------------------------
# Orders
# -------------------------------

@router.get("/orders", response_model=List[OrderResponseSchema])
def driver_orders(current_user: dict = Depends(get_current_driver)):
    orders_collection = db["db"]["orders"]
    orders = list(orders_collection.find({"driver_id": ObjectId(current_user["_id"])}))
    return [OrderResponseSchema(
        id=str(o["_id"]),
        customer_id=str(o["customer_id"]),
        store_id=str(o["store_id"]),
        bottles=[BottleOrderSchema(**b) for b in o["bottles"]],
        status=o["status"],
        driver_id=str(o["driver_id"]),
        created_at=o["created_at"],
        delivered_at=o.get("delivered_at")
    ) for o in orders]

@router.patch("/orders/{order_id}/status", response_model=OrderResponseSchema)
def update_order_status(order_id: str, data: UpdateOrderStatusSchema, current_user: dict = Depends(get_current_driver)):
    orders_collection = db["db"]["orders"]
    valid_status = ["accepted", "picked", "delivered"]
    if data.status not in valid_status:
        raise HTTPException(status_code=400, detail="Invalid status")
    update_data = {"status": data.status}
    if data.status == "delivered":
        update_data["delivered_at"] = datetime.utcnow()
    result = orders_collection.update_one(
        {"_id": ObjectId(order_id), "driver_id": ObjectId(current_user["_id"])},
        {"$set": update_data}
    )
    if result.matched_count == 0:
        raise HTTPException(status_code=404, detail="Order not found")
    order = orders_collection.find_one({"_id": ObjectId(order_id)})
    return OrderResponseSchema(
        id=str(order["_id"]),
        customer_id=str(order["customer_id"]),
        store_id=str(order["store_id"]),
        bottles=[BottleOrderSchema(**b) for b in order["bottles"]],
        status=order["status"],
        driver_id=str(order["driver_id"]),
        created_at=order["created_at"],
        delivered_at=order.get("delivered_at")
    )

# -------------------------------
# Driver Location
# -------------------------------

@router.patch("/location")
def update_location(data: DriverLocationUpdateSchema, current_user: dict = Depends(get_current_driver)):
    locations_collection = db["db"]["driver_locations"]
    update_data = {
        "driver_id": ObjectId(current_user["_id"]),
        "latitude": data.latitude,
        "longitude": data.longitude,
        "updated_at": datetime.utcnow()
    }
    locations_collection.update_one(
        {"driver_id": ObjectId(current_user["_id"])},
        {"$set": update_data},
        upsert=True
    )
    return {"detail": "Location updated successfully"}

@router.get("/history", response_model=List[OrderResponseSchema])
def driver_history(current_user: dict = Depends(get_current_driver)):
    orders_collection = db["db"]["orders"]
    orders = list(orders_collection.find({"driver_id": ObjectId(current_user["_id"]), "status": "delivered"}))
    return [OrderResponseSchema(
        id=str(o["_id"]),
        customer_id=str(o["customer_id"]),
        store_id=str(o["store_id"]),
        bottles=[BottleOrderSchema(**b) for b in o["bottles"]],
        status=o["status"],
        driver_id=str(o["driver_id"]),
        created_at=o["created_at"],
        delivered_at=o.get("delivered_at")
    ) for o in orders]
