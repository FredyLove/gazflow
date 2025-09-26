from pydantic import BaseModel, EmailStr, Field
from typing import Optional
from bson import ObjectId
from app.models.customer import PyObjectId




# -----------------------
# User Model
# -----------------------
class UserModel(BaseModel):
    id: Optional[PyObjectId] = Field(alias="_id")
    name: str
    email: EmailStr
    password: str
    role: str = "user"

    model_config = {
        "populate_by_name": True,       # replaces allow_population_by_field_name
        "arbitrary_types_allowed": True,
        "json_encoders": {ObjectId: str},
    }
