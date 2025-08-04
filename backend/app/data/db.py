"""Database connection handling."""

import psycopg
from contextlib import contextmanager

from app.settings import (
    DB_NAME,
    DB_USER,
    DB_PASSWORD,
    DB_HOST,
    DB_PORT,
)


@contextmanager
def get_connection():
    """Get a connection to the database."""
    conn = psycopg.connect(
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        host=DB_HOST,
        port=DB_PORT,
    )
    try:
        yield conn
    finally:
        conn.close()
