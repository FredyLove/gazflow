# app/db/mongo.py

import pymongo
import os
from dotenv import load_dotenv
from pymongo.errors import ConfigurationError

load_dotenv()

MONGO_URI = os.getenv("MONGO_URI")
DB_NAME = os.getenv("DB_NAME")

# Shared mutable object used across your app
db = {}

def init_db():
    if not MONGO_URI or not DB_NAME:
        print("❌ Missing environment variables. Check your .env file.")
        return

    try:
        client = pymongo.MongoClient(MONGO_URI)
        db["client"] = client
        db["db"] = client[DB_NAME]
        print(f"✅ Connected to MongoDB at {MONGO_URI}, using database: '{DB_NAME}'")
    except ConfigurationError:
        print("❌ Invalid MongoDB URI.")
        return
