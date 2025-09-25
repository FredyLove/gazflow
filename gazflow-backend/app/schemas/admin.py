# app/admin/schemas.py
from pydantic import BaseModel, EmailStr
from typing import Optional, Dict
from datetime import datetime

class UserCreateSchema(BaseModel):
    name: str
    email: EmailStr
    password: str
    role: str  # 'store_manager', 'driver'

class UserResponseSchema(BaseModel):
    id: str
    name: str
    email: EmailStr
    role: str

class NotificationCreateSchema(BaseModel):
    title: str
    message: str
    target_role: Optional[str] = None

class NotificationResponseSchema(BaseModel):
    id: str
    title: str
    message: str
    target_role: Optional[str]
    created_at: datetime

class AnalyticsResponseSchema(BaseModel):
    total_sales: float
    sales_by_store: Dict[str, float]
    period_start: datetime
    period_end: datetime
