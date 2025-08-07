from fastapi import APIRouter, Query
from app.db.mongo import db
from math import radians, sin, cos, sqrt, atan2

router = APIRouter()

def haversine(lat1, lon1, lat2, lon2):
    R = 6371
    d_lat = radians(lat2 - lat1)
    d_lon = radians(lon2 - lon1)
    a = sin(d_lat/2)**2 + cos(radians(lat1)) * cos(radians(lat2)) * sin(d_lon/2)**2
    return R * (2 * atan2(sqrt(a), sqrt(1-a)))

@router.get("/storage/nearby")
def get_nearby_storages(lat: float = Query(...), lng: float = Query(...)):
    if not db:
        raise RuntimeError("Database not initialized")
    storage_collection = db["storage_locations"]
    storages = list(storage_collection.find())
    for s in storages:
        s["distance_km"] = round(haversine(lat, lng, s["lat"], s["lng"]), 2)
    storages.sort(key=lambda x: x["distance_km"])
    return storages
