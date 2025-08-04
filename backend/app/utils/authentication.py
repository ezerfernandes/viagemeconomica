"""Password utilities."""

import bcrypt


__all__ = [
    "hash_password",
    "verify_password",
]


def hash_password(password: str, rounds: int = 12) -> str:
    """Hash a password."""
    return bcrypt.hashpw(
        password.encode("utf-8"),
        bcrypt.gensalt(rounds=rounds),
    ).decode("utf-8")


def verify_password(password: str, hashed_password: bytes) -> bool:
    """Verify a password."""
    return bcrypt.checkpw(password.encode("utf-8"), hashed_password)
