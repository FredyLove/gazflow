from ast import Dict
from typing import Any, Optional
from pydantic import BaseModel, EmailStr

class UserRegister(BaseModel):
    full_name: str
    email: EmailStr
    password: str
    role: str
    phone: str
    

class UserLogin(BaseModel):
    email: EmailStr
    password: str
