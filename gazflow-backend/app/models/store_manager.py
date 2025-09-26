from pydantic import BaseModel, Field
from typing import List, Optional
from datetime import datetime
from bson import ObjectId
from app.models.customer import PyObjectId

# -----------------------
# Store Manager Models
# -----------------------

class StoreModel(BaseModel):
    id: Optional[PyObjectId] = Field(alias="_id")
    name: str
    address: str
    latitude: float
    longitude: float
    manager_id: PyObjectId
    created_at: Optional[datetime] = None

    model_config = {
        "populate_by_name": True,
        "arbitrary_types_allowed": True,
        "json_encoders": {ObjectId: str, datetime: lambda v: v.isoformat()},
    }

class GasBottleModel(BaseModel):
    id: Optional[PyObjectId] = Field(alias="_id")
    store_id: PyObjectId
    name: str
    price: float
    quantity: int
    created_at: Optional[datetime] = None

    model_config = {
        "populate_by_name": True,
        "arbitrary_types_allowed": True,
        "json_encoders": {ObjectId: str, datetime: lambda v: v.isoformat()},
    }

class BottleOrderModel(BaseModel):
    bottle_id: PyObjectId
    quantity: int

class OrderModel(BaseModel):
    id: Optional[PyObjectId] = Field(alias="_id")
    customer_id: PyObjectId
    store_id: PyObjectId
    bottles: List[BottleOrderModel]
    status: str = "pending"  # 'pending', 'assigned', 'picked', 'delivered'
    driver_id: Optional[PyObjectId] = None
    created_at: Optional[datetime] = None
    delivered_at: Optional[datetime] = None

    model_config = {
        "populate_by_name": True,
        "arbitrary_types_allowed": True,
        "json_encoders": {ObjectId: str, datetime: lambda v: v.isoformat()},
    }
