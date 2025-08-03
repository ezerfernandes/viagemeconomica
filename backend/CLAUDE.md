# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

- **Start development server**: `make dev` or `fastapi dev src/main.py`
- **Install dependencies**: `pip install -r requirements/base.txt`

## Project Architecture

This is a Python FastAPI backend application for "Viagem Econômica" (Economic Travel).

### Structure
- `src/main.py` - Main FastAPI application entry point with basic "Hello World" endpoint
- `requirements/base.txt` - Python dependencies including FastAPI, Pydantic, and related packages
- `Makefile` - Contains development commands

### Key Technologies
- **FastAPI** - Modern Python web framework for APIs
- **Pydantic** - Data validation and serialization
- **Uvicorn** - ASGI server for running the application
- **Sentry SDK** - Error tracking and monitoring

### Current State
The application is in early development with only a basic root endpoint implemented. The codebase follows a simple structure with the main application file in `src/main.py`.