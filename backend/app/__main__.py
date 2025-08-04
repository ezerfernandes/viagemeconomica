import uvicorn
from fastapi import FastAPI

from app.routers import main
from app.routers import deals
from app.settings import PORT


app = FastAPI()

app.include_router(main.router)
app.include_router(deals.router)

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=PORT)
