from fastapi import APIRouter
from app.db.mongo import db

router = APIRouter()

@router.get("/gas/types")
def get_gas_types():
    if not db:
        raise RuntimeError("Database not initialized")
    gas_collection = db["gas_bottles"]
    gas_types = list(gas_collection.find({}, {"_id": 0}))  # Hide Mongo _id
    return gas_types
