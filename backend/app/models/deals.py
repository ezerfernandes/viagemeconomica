"""Deals models."""

from decimal import Decimal

from pydantic import BaseModel, Field
import uuid_utils as uuid

from app.utils.slugs import slugify


class DealCreate(BaseModel):
    """Deal create model."""

    title: str = Field(..., description="The title of the deal.")
    price: Decimal = Field(
        ...,
        description="The price of the deal.",
        gt=0,
    )
    destination: str = Field(..., description="The destination of the deal.")
    deal_type: str = Field(..., description="The type of deal.")


class Deal(DealCreate):
    """Deal model."""

    id: str = Field(..., description="The ID of the deal.")
    slug: str | None = Field(..., description="The slug of the deal.")

    @classmethod
    def new(
        cls,
        title: str,
        price: Decimal,
        destination: str,
        deal_type: str,
    ) -> "Deal":
        """Create a new deal."""
        return cls(
            id=str(uuid.uuid7()),
            slug=slugify(title),
            title=title,
            price=price,
            destination=destination,
            deal_type=deal_type,
        )
