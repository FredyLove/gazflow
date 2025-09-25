# app/store_manager/schemas.py
from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime

class StoreCreateSchema(BaseModel):
    name: str
    address: str
    latitude: float
    longitude: float

class StoreResponseSchema(BaseModel):
    id: str
    name: str
    address: str
    latitude: float
    longitude: float
    manager_id: str
    created_at: datetime

class GasBottleCreateSchema(BaseModel):
    name: str
    price: float
    quantity: int

class GasBottleResponseSchema(BaseModel):
    id: str
    store_id: str
    name: str
    price: float
    quantity: int
    created_at: datetime

class AssignOrderSchema(BaseModel):
    driver_id: str

class OrderResponseSchema(BaseModel):
    id: str
    customer_id: str
    store_id: str
    bottles: List[dict]
    status: str
    driver_id: Optional[str]
    created_at: datetime
    delivered_at: Optional[datetime]
