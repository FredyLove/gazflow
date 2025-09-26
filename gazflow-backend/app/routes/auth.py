from fastapi import APIRouter, HTTPException, status, Depends
from app.schemas.user_schema import UserLogin, UserRegister
from app.crud.user import create_user, authenticate_user
from app.core.security import create_access_token

router = APIRouter(prefix="/auth", tags=["auth"])

@router.post("/register")
def register(user: UserRegister):
    from app.crud.user import get_user_by_email
    if get_user_by_email(user.email):
        raise HTTPException(status_code=400, detail="Email already registered")
    user_dict = user.dict()
    user_id = create_user(user_dict)
    return {"msg": "User created", "user_id": user_id}

@router.post("/login")
def login(user: UserLogin):
    db_user = authenticate_user(user.email, user.password)
    if not db_user:
        raise HTTPException(status_code=401, detail="Invalid credentials")
    
    # Use MongoDB ObjectId string for user_id
    token = create_access_token(data={"user_id": str(db_user['_id']), "role": db_user["role"]})
    return {"access_token": token, "token_type": "bearer", "role": db_user["role"]}