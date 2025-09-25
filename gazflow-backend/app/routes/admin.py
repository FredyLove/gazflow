# app/admin/routes.py
from bson import ObjectId
from fastapi import APIRouter, Depends, HTTPException
from typing import List
from app.core.security import get_current_admin
from app.models.admin import UserModel, NotificationModel, AnalyticsModel
from app.schemas.admin import (
    UserCreateSchema, UserResponseSchema,
    NotificationCreateSchema, NotificationResponseSchema,
    AnalyticsResponseSchema
)
from app.db.mongo import db
from datetime import datetime

router = APIRouter(prefix="/admin", tags=["Admin"])

# -------------------------------
# Store Managers CRUD
# -------------------------------

@router.post("/store-managers", response_model=UserResponseSchema)
def add_store_manager(data: UserCreateSchema, current_admin: dict = Depends(get_current_admin)):
    users_collection = db["db"]["users"]
    user_data = data.dict()
    user_data["role"] = "store_manager"
    result = users_collection.insert_one(user_data)
    return UserResponseSchema(
        id=str(result.inserted_id),
        name=data.name,
        email=data.email,
        role="store_manager"
    )

@router.get("/store-managers", response_model=List[UserResponseSchema])
def list_store_managers(current_admin: dict = Depends(get_current_admin)):
    users_collection = db["db"]["users"]
    managers = list(users_collection.find({"role": "store_manager"}))
    return [UserResponseSchema(
        id=str(m["_id"]),
        name=m["name"],
        email=m["email"],
        role=m["role"]
    ) for m in managers]

@router.delete("/store-managers/{id}")
def remove_store_manager(id: str, current_admin: dict = Depends(get_current_admin)):
    users_collection = db["db"]["users"]
    result = users_collection.delete_one({"_id": ObjectId(id), "role": "store_manager"})
    if result.deleted_count == 0:
        raise HTTPException(status_code=404, detail="Store manager not found")
    return {"detail": "Store manager deleted successfully"}

# -------------------------------
# Notifications
# -------------------------------

@router.post("/notifications", response_model=NotificationResponseSchema)
def send_notification(data: NotificationCreateSchema, current_admin: dict = Depends(get_current_admin)):
    notifications_collection = db["db"]["notifications"]
    notif_data = data.dict()
    notif_data["created_at"] = datetime.utcnow()
    result = notifications_collection.insert_one(notif_data)
    return NotificationResponseSchema(
        id=str(result.inserted_id),
        title=data.title,
        message=data.message,
        target_role=data.target_role,
        created_at=notif_data["created_at"]
    )

# -------------------------------
# Analytics (example)
# -------------------------------

@router.get("/analytics/sales", response_model=AnalyticsResponseSchema)
def sales_analytics(current_admin: dict = Depends(get_current_admin)):
    orders_collection = db["db"]["orders"]
    # For simplicity: aggregate all delivered orders
    orders = list(orders_collection.find({"status": "delivered"}))
    sales_by_store = {}
    total_sales = 0
    for o in orders:
        store_id = str(o["store_id"])
        order_total = sum([b.get("price", 0) * b["quantity"] for b in o["bottles"]])
        sales_by_store[store_id] = sales_by_store.get(store_id, 0) + order_total
        total_sales += order_total
    period_start = min([o["created_at"] for o in orders]) if orders else datetime.utcnow()
    period_end = max([o["created_at"] for o in orders]) if orders else datetime.utcnow()
    return AnalyticsResponseSchema(
        total_sales=total_sales,
        sales_by_store=sales_by_store,
        period_start=period_start,
        period_end=period_end
    )
