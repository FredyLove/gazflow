from pydantic import BaseModel, Field
from typing import List, Optional
from datetime import datetime
from bson import ObjectId
from app.models.customer import PyObjectId


# -----------------------
# Driver Models
# -----------------------

class BottleOrderModel(BaseModel):
    bottle_id: PyObjectId
    quantity: int

class OrderModel(BaseModel):
    id: Optional[PyObjectId] = Field(alias="_id")
    customer_id: PyObjectId
    store_id: PyObjectId
    bottles: List[BottleOrderModel]
    status: str  # 'assigned', 'accepted', 'picked', 'delivered'
    driver_id: Optional[PyObjectId] = None
    created_at: Optional[datetime] = None
    delivered_at: Optional[datetime] = None

    model_config = {
        "populate_by_name": True,
        "arbitrary_types_allowed": True,
        "json_encoders": {ObjectId: str, datetime: lambda v: v.isoformat()},
    }

class DriverLocationModel(BaseModel):
    driver_id: PyObjectId
    latitude: float
    longitude: float
    updated_at: Optional[datetime] = None

    model_config = {
        "arbitrary_types_allowed": True,
        "json_encoders": {ObjectId: str, datetime: lambda v: v.isoformat()},
    }
