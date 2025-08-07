from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.routes import auth, gas, storage_locations
from app.db.mongo import init_db, db 

app = FastAPI(title="GazFlow API")

# Include API routers
app.include_router(auth.router)
app.include_router(gas.router)
app.include_router(storage_locations.router)

# Enable CORS (allow frontend access)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 🔒 Replace with specific domain in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize DB on server startup
@app.on_event("startup")
def startup():
    print("🚀 Starting GazFlow backend")
    init_db()

# Root endpoint
@app.get("/")
def read_root():
    return {"message": "Welcome to GazFlow API"}

# Debug endpoint to check DB connection
@app.get("/ping-db")
def ping_db():
    collections = db.list_collection_names()
    return {"connected": True, "collections": collections}
