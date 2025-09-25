# app/routes/tracking.py
from bson import ObjectId
from fastapi import APIRouter, WebSocket, WebSocketDisconnect
import asyncio
from app.db.mongo import db
from app.routes.customer import get_driver_location

router = APIRouter()
connections = {}

@router.websocket("/ws/track/{order_id}")
async def track_order_ws(websocket: WebSocket, order_id: str):
    await websocket.accept()
    
    if order_id not in connections:
        connections[order_id] = []
    connections[order_id].append(websocket)
    
    try:
        while True:
            driver_location = await get_driver_location(order_id)
            # send to all websockets for this order
            for ws in connections[order_id]:
                await ws.send_json(driver_location)
            await asyncio.sleep(2)
    except WebSocketDisconnect:
        connections[order_id].remove(websocket)
        if not connections[order_id]:
            del connections[order_id]