"""Data layer."""

import re
from typing import TYPE_CHECKING

from psycopg import sql

from app.data import db

if TYPE_CHECKING:
    from pydantic import BaseModel


def save_object(
    model_instance: "BaseModel",
    table_name: str,
) -> None:
    """Saves a BaseModel object to the database."""
    _validate_table_name(table_name)

    data: str = model_instance.model_dump_json()

    with db.get_connection() as conn:
        with conn.cursor() as cursor:
            query = sql.SQL("INSERT INTO {table} (data) VALUES (%s)").format(
                table=sql.Identifier(table_name),
            )
            cursor.execute(
                query,
                (data,),
            )
            conn.commit()


def _validate_table_name(table_name: str) -> None:
    """Validates a table name."""
    if not re.match(r"[a-zA-Z_]+$", table_name):
        msg = "Table name must have only letters or underscore"
        raise ValueError(msg)
