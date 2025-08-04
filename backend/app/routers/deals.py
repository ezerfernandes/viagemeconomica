from fastapi import APIRouter

from app.models.deals import Deal, DealCreate
from app import data

router = APIRouter(prefix="/deals", tags=["deals"])


@router.post("/", status_code=201)
def create_deal(request: DealCreate) -> Deal:
    new_deal = Deal.new(**request.model_dump())
    data.save_object(new_deal, "deals")
    return new_deal
