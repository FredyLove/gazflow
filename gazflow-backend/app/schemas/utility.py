# app/utils/schemas.py
from pydantic import BaseModel
from datetime import datetime
from typing import Optional

class NotificationResponseSchema(BaseModel):
    id: str
    title: str
    message: str
    target_role: Optional[str]
    created_at: datetime

class HealthResponseSchema(BaseModel):
    status: str
    uptime: float
