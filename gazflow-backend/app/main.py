from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.routes import auth, admin, driver, store_manager, customer, utility, tracking
from app.db.mongo import init_db, db 
from app.routes.store_manager import ensure_2dsphere_index

app = FastAPI(title="GazFlow API")

# Include API routers
app.include_router(auth.router)
app.include_router(admin.router)
app.include_router(customer.router)
app.include_router(driver.router)
app.include_router(store_manager.router)
app.include_router(utility.router)
app.include_router(tracking.router)

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
    ensure_2dsphere_index()

# Root endpoint
@app.get("/")
def read_root():
    return {"message": "Welcome to GazFlow API"}

# Debug endpoint to check DB connection
@app.get("/ping-db")
def ping_db():
    collections = db.list_collection_names()
    return {"connected": True, "collections": collections}
