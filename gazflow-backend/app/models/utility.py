from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime
from bson import ObjectId
from app.models.customer import PyObjectId

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
