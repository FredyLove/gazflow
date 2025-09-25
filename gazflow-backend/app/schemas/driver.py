# app/driver/schemas.py
from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime

class BottleOrderSchema(BaseModel):
    bottle_id: str
    quantity: int

class OrderResponseSchema(BaseModel):
    id: str
    customer_id: str
    store_id: str
    bottles: List[BottleOrderSchema]
    status: str
    driver_id: Optional[str]
    created_at: datetime
    delivered_at: Optional[datetime]

class UpdateOrderStatusSchema(BaseModel):
    status: str  # 'accepted', 'picked', 'delivered'

class DriverLocationUpdateSchema(BaseModel):
    latitude: float
    longitude: float
