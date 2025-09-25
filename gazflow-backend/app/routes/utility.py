# app/utils/routes.py
from fastapi import APIRouter, Depends
from typing import List
from datetime import datetime
import time
from app.db.mongo import db
from app.models.utility import NotificationModel
from app.schemas.utility import NotificationResponseSchema, HealthResponseSchema
from app.core.security import get_current_user

router = APIRouter(tags=["Utility"])

START_TIME = time.time()

# -------------------------------
# Notifications
# -------------------------------

@router.get("/notifications", response_model=List[NotificationResponseSchema])
def get_notifications(current_user: dict = Depends(get_current_user)):
    notifications_collection = db["db"]["notifications"]
    user_role = current_user.get("role")
    notifications = list(notifications_collection.find({"$or":[{"target_role": user_role}, {"target_role": None}]}).sort("created_at",-1))
    return [NotificationResponseSchema(
        id=str(n["_id"]),
        title=n["title"],
        message=n["message"],
        target_role=n.get("target_role"),
        created_at=n["created_at"]
    ) for n in notifications]

# -------------------------------
# Health Check
# -------------------------------

@router.get("/health", response_model=HealthResponseSchema)
def health_check():
    uptime = time.time() - START_TIME
    return HealthResponseSchema(status="ok", uptime=uptime)
