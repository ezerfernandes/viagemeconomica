"""User models."""

from pydantic import BaseModel, Field
import uuid_utils as uuid

from app.utils.authentication import hash_password


__all__ = [
    "User",
    "UserCreate",
]


class UserBase(BaseModel):
    """User base model."""

    email: str = Field(..., description="The user's email address.")
    name: str | None = Field(None, description="The user's name.")


class UserCreate(UserBase):
    """User create model."""

    password: str = Field(..., description="The user's password.")


class User(UserBase):
    """User model."""

    id: str = Field(..., description="The ID of the user.")
    password_hash: str = Field(..., description="The hashed password.")

    @classmethod
    def create(
        cls,
        email: str,
        password: str,
        name: str | None = None,
    ) -> "User":
        """Create a new user."""
        return cls(
            id=str(uuid.uuid7()),
            email=email,
            password_hash=hash_password(password),
            name=name,
        )
