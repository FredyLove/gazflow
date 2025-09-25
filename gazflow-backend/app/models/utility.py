from pydantic import BaseModel, Field
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
        return {"type": "string", "title": "ObjectId"}


# -----------------------
# Notification Model
# -----------------------
class NotificationModel(BaseModel):
    id: Optional[PyObjectId] = Field(alias="_id")
    title: str
    message: str
    target_role: Optional[str] = None  # 'admin', 'store_manager', 'driver', 'customer', or None=all
    created_at: Optional[datetime] = None

    model_config = {
        "populate_by_name": True,       # replaces allow_population_by_field_name
        "arbitrary_types_allowed": True,
        "json_encoders": {ObjectId: str, datetime: lambda v: v.isoformat()},
    }
