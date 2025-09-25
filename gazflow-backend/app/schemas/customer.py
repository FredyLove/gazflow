# app/customer/schemas.py
from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime

class StoreNearbyResponse(BaseModel):
    id: str
    name: str
    address: str
    latitude: float
    longitude: float

class GasBottleResponse(BaseModel):
    id: str
    name: str
    price: float
    quantity: int

class BottleOrder(BaseModel):
    bottle_id: str
    quantity: int

class OrderCreate(BaseModel):
    store_id: str
    bottles: List[BottleOrder]

class OrderResponse(BaseModel):
    id: str
    store_id: str
    bottles: List[BottleOrder]
    status: str
    driver_id: Optional[str]
    created_at: datetime
    delivered_at: Optional[datetime]
