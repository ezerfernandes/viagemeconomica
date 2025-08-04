# Implementation Plan: Viagem Econômica

This document outlines the actionable tasks for building the platform, based on `FEATURES.md` and `DESIGN.md`.

**Task Status Legend:**

- `[ ]` - To Do
- `[P]` - Partially Implemented
- `[I]` - Implemented
- `[X]` - Unit Tests Implemented

## Phase 1: Foundation & Core Features (MVP)

### 1.1. Project Setup & DevOps

- `[ ]` Initialize FastAPI project with a clean directory structure.
- `[I]` Create `Dockerfile` for the backend application.
- `[ ]` Create `docker-compose.yml` for a local development environment (FastAPI, PostgreSQL).
- `[ ]` Set up GitHub Actions for automated testing (CI).
- `[ ]` Configure dependency management (e.g., `poetry` or `pip-tools`).

### 1.2. Database and Data Models

- `[ ]` Set up PostgreSQL and integrate it with FastAPI.
- `[ ]` Set up Alembic for database migrations.
- `[I]` Create initial migration for the `users` table (`id`, `email`, `password_hash`, `name`, `data`).
- `[I]` Create initial migration for the `user_preferences` table (`user_id`, `data`).
- `[I]` Create initial migration for the `subscriptions` table (`id`, `user_id`, `plan_type`, `status`, `stripe_subscription_id`).
- `[I]` Create initial migration for the `deals` table (`id`, `title`, `price`, `destination`, `deal_type`, `data`).

### 1.3. User & Auth Service

- `[ ]` Implement user registration with email and hashed password (Argon2/bcrypt).
- `[ ]` Implement JWT generation and validation for session management.
- `[ ]` Create login endpoint that returns a JWT.
- `[ ]` Implement protected endpoints that require a valid JWT.
- `[ ]` Implement social login via OAuth2 for Google.
- `[ ]` On first social login, create a new user in the database.
- `[ ]` Implement API endpoints for users to manage their profile data.
- `[ ]` Implement API endpoints for users to manage their travel preferences (`user_preferences`).

### 1.4. Deals Service (Core)

- `[ ]` Implement a background task system (e.g., Celery, ARQ, or FastAPI's built-in).
- `[ ]` Develop a background task to periodically fetch data from external travel APIs.
- `[ ]` Implement the logic to save and update deals in the `deals` table.
- `[ ]` Create a public API endpoint to list and filter deals (e.g., by price, destination, type).
- `[ ]` Implement Redis caching for the main deals feed to reduce database load.

### 1.5. Notification Service (Core)

- `[ ]` Integrate an email sending service (e.g., SendGrid).
- `[ ]` Develop a background task that checks for new deals matching user preferences.
- `[ ]` For each match, queue an email notification to be sent to the user.
- `[ ]` Implement an API endpoint for users to manage their notification settings within `user_preferences`.

## Phase 2: Advanced Features & Monetization

### 2.1. Mystery Trip Service

- `[ ]` Create the database model and migration for `mystery_trips` (`id`, `user_id`, `budget`, `status`, `data`).
- `[ ]` Implement the "Mystery Trip" generation algorithm to select compatible deals within a budget.
- `[ ]` Create an API endpoint to generate a mystery trip proposal based on user input (budget, preferences).
- `[ ]` Create an API endpoint to confirm and book a mystery trip.
- `[ ]` Integrate with the Notification Service to send the final itinerary to the user upon confirmation.

### 2.2. Monetization

- `[ ]` Integrate Stripe for processing subscription payments.
- `[ ]` Create API endpoints to handle Stripe webhooks for events like successful payments or cancellations.
- `[ ]` Implement API endpoints for users to manage their subscription (upgrade, cancel, view billing history).
- `[ ]` Implement middleware or decorators to restrict access to premium features based on subscription status.

## Phase 3: Community & User Engagement

### 3.1. Community Service

- `[ ]` Create the database model and migration for `forum_posts` (`id`, `user_id`, `title`, `content`, `parent_post_id`).
- `[ ]` Implement API endpoints for full CRUD operations on forum posts and replies.
- `[ ]` Enhance the `users` data model/profile to include bio, travel history, and photos.
- `[ ]` Implement API endpoints for users to view and edit these enhanced profiles.
- `[ ]` Add logic to link trips to users so they can see who else is going to a destination.

### 3.2. Knowledge Base & Support

- `[ ]` Create a model for knowledge base articles.
- `[ ]` Implement API endpoints for managing and searching articles.
- `[ ]` Develop a basic FAQ section managed via a simple CMS or markdown files.

## Phase 4: Frontend Implementation (High-Level)

*This section outlines the corresponding frontend tasks that will consume the backend APIs.*

### 4.1. Onboarding and Core UI

- `[ ]` Create Signup and Login pages.
- `[ ]` Implement social login flow for Google.
- `[ ]` Build the main user dashboard.
- `[ ]` Build the user profile page for managing preferences and personal information.
- `[ ]` Build the subscription and billing management page.

### 4.2. Feature Implementation

- `[ ]` Build the UI for displaying and filtering travel deals.
- `[ ]` Build the UI for the "Mystery Trip" generator tool.
- `[ ]` Build the booking and payment flow for Mystery Trips.
- `[ ]` Build the UI for the community forums (viewing posts, replying, creating posts).
