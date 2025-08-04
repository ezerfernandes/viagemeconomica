# Gemini Project Conventions

This file outlines the conventions and technical stack for this project to guide Gemini's contributions.

## Framework

The server will be built using the **FastAPI** web framework.

## Requirements

- The user stories are located in the `specs/FEATURES.md` file.
- `specs/DESIGN.md` documents technical architecture, sequence diagrams, and implementation considerations.
- `specs/TASKS.md` contains an implementation plan with actionable tasks.
- After a task is implemented, add a letter in the check: I - Implemented; P - Partially Implemented; X - Unit tests implemented.
  - Example: "[ ] Do something." After it's implemented, "[I] Do something". After Unit tests, "[X] Do something".

## Tools

In addition to shell commands, you can use the make commands available in the `Makefile`:

- `make format`: Format code automatically
- `make check`: Check code style and quality
- `make format_check`: Check if code formatting is correct without changing files
- `make lint`: Run linting
- `make dev`: Run the development server
- `make test`: Run all tests
- `make docker`: Build and run the docker container locally
- `make help`: Show available targets

## Code

- `app`: It's the module with the code:
  - `app.models`: Contains pydantic models representing data in the SQL table.
  - `app.settings`: All the settings go here.
  - `app.data`: Generic layer that works as a mapping between models and the DB tables.
  - `app.routers`: contains the endpoints for each subject.
- `database/schema.sql`: It contains the DB schema with SQL commands for creating the DB in Postgres.

### Models

Here an example of how a model must be implemented in the `app/models/examples.py` file:

```python
"""Example models."""

from pydantic import BaseModel, Field
import uuid_utils as uuid

from app.utils.slugs import slugify


class ExampleCreate(BaseModel):
    """Example create model."""

    name: str = Field(..., description="The example field.")


class Example(ExampleCreate):
    """Example model."""

    id: str = Field(..., description="The ID of the example.")
    slug: str | None = Field(..., description="The slug of the example.")

    @classmethod
    def create(
        cls,
        name: str,
    ) -> "Example":
        """Create a new deal."""
        return cls(
            id=str(uuid.uuid7()),
            slug=slugify(name),
            name=name,
        )
```
