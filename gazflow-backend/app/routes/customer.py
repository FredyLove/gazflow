# app/customer/routes.py
from fastapi import APIRouter, Depends, HTTPException, Query
from typing import List
from app.core.security import get_current_user
from app.models.customer import Store, GasBottle, Order
from app.schemas.customer import (
    StoreNearbyResponse, GasBottleResponse,
    OrderCreate, OrderResponse, BottleOrder
)

router = APIRouter(prefix="/customer", tags=["Customer"])

@router.get("/stores/nearby", response_model=List[StoreNearbyResponse])
def nearby_stores(lat: float = Query(...), lng: float = Query(...)):
    stores = Store.nearby(lat, lng)
    return [StoreNearbyResponse(
        id=s.id,
        name=s.name,
        address=s.address,
        latitude=s.latitude,
        longitude=s.longitude
    ) for s in stores]

@router.get("/stores/{store_id}/gas-bottles", response_model=List[GasBottleResponse])
def store_bottles(store_id: str):
    bottles = GasBottle.by_store(store_id)
    return [GasBottleResponse(
        id=b.id,
        name=b.name,
        price=b.price,
        quantity=b.quantity
    ) for b in bottles]

@router.post("/orders", response_model=OrderResponse)
def place_order(data: OrderCreate, current_user: dict = Depends(get_current_user)):
    bottles_data = [b.dict() for b in data.bottles]
    order = Order.create(current_user["_id"], data.store_id, bottles_data)
    return OrderResponse(
        id=order.id,
        store_id=order.store_id,
        bottles=data.bottles,
        status=order.status,
        driver_id=order.driver_id,
        created_at=order.created_at,
        delivered_at=order.delivered_at
    )

@router.get("/orders", response_model=List[OrderResponse])
def list_orders(current_user: dict = Depends(get_current_user)):
    orders = Order.list_by_customer(current_user["_id"])
    response = []
    for o in orders:
        response.append(OrderResponse(
            id=o.id,
            store_id=o.store_id,
            bottles=[BottleOrder(**b) for b in o.bottles],
            status=o.status,
            driver_id=o.driver_id,
            created_at=o.created_at,
            delivered_at=o.delivered_at
        ))
    return response

@router.get("/orders/{order_id}", response_model=OrderResponse)
def track_order(order_id: str, current_user: dict = Depends(get_current_user)):
    order = Order.get_by_id(order_id, current_user["_id"])
    if not order:
        raise HTTPException(status_code=404, detail="Order not found")
    return OrderResponse(
        id=order.id,
        store_id=order.store_id,
        bottles=[BottleOrder(**b) for b in order.bottles],
        status=order.status,
        driver_id=order.driver_id,
        created_at=order.created_at,
        delivered_at=order.delivered_at
    )
