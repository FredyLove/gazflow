from pydantic import BaseModel, Field, EmailStr
from typing import Optional
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
        # Serialize ObjectId as string in JSON schema
        return {"type": "string", "title": "ObjectId"}

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
