from pydantic import BaseModel, Field, EmailStr
from typing import Optional
from datetime import datetime
from bson import ObjectId
from app.models.customer import PyObjectId


# -----------------------
# Admin Models
# -----------------------

class UserModel(BaseModel):
    id: Optional[PyObjectId] = Field(alias="_id")
    name: str
    email: EmailStr
    password: str
    role: str = "user"  # can be 'admin', 'store_manager', 'driver', 'customer'

    model_config = {
        "populate_by_name": True,
        "arbitrary_types_allowed": True,
        "json_encoders": {ObjectId: str},
    }

class NotificationModel(BaseModel):
    id: Optional[PyObjectId] = Field(alias="_id")
    title: str
    message: str
    target_role: Optional[str] = None  # 'admin', 'store_manager', 'driver', 'customer', or None = all
    created_at: Optional[datetime] = None

    model_config = {
        "populate_by_name": True,
        "arbitrary_types_allowed": True,
        "json_encoders": {ObjectId: str, datetime: lambda v: v.isoformat()},
    }

class AnalyticsModel(BaseModel):
    # This is a placeholder; analytics are usually calculated dynamically
    total_sales: float
    sales_by_store: dict  # {store_id: total_sales}
    period_start: datetime
    period_end: datetime
