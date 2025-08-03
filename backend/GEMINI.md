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

## Code

- `app`: It's the module with the code:
  - `app.models`: Contains pydantic models representing data in the SQL table.
  - `app.settings`: All the settings go here.
  - `app.data`: Generic layer that works as a mapping between models and the DB tables.
  - `app.routers`: contains the endpoints for each subject.
- `database/schema.sql`: It contains the DB schema with SQL commands for creating the DB in Postgres.
