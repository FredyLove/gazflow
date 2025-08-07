from app.db.mongo import db
from app.core.security import hash_password, verify_password, create_access_token

def get_user_by_email(email: str):
    if not db or "db" not in db:
        raise RuntimeError("Database not initialized")
    user_collection = db["db"]["users"]
    return user_collection.find_one({"email": email})

def create_user(user_data):
    if not db or "db" not in db:
        raise RuntimeError("Database not initialized")
    user_collection = db["db"]["users"]
    user_data["password"] = hash_password(user_data["password"])
    user_data["role"] = user_data.get("role", "user")
    result = user_collection.insert_one(user_data)
    return str(result.inserted_id)

def authenticate_user(email: str, password: str):
    user = get_user_by_email(email)
    if user and verify_password(password, user["password"]):
        return user
    return None
