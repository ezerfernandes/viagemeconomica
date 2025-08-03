# Onboarding Flow Specification

This document outlines the user onboarding experience for The Wanderer's Club, focusing on a streamlined, low-friction process that encourages quick conversion and immediate engagement.

## Guiding Principles

- **Frictionless Sign-Up:** The initial registration process should be as simple as possible, requiring minimal user input.
- **Immediate Value:** New members should be able to access the platform's core features immediately after signing up.
- **Progressive Profiling:** User profile information and preferences should be gathered over time, not as a barrier to entry.

## Phase 1: Core Implementation

### 1. Registration via Social Logins

The primary method for new user registration will be through one-click social logins. This approach significantly reduces the friction typically associated with creating a new account.

- **Supported Providers:**
  - Google
  - Facebook
- **Process Flow:**
  1. The user clicks "Sign up with Google" or "Sign up with Facebook" on the registration page.
  2. The user is redirected to the respective provider's OAuth authentication screen.
  3. Upon successful authentication, the user is redirected back to the platform.
  4. A new user account is automatically created in the system using the basic information provided by the social provider (e.g., name, email).
  5. The user is immediately logged in and directed to their new dashboard.

### 2. Deferred Profile Completion

To avoid front-loading the onboarding process with forms, profile completion will be deferred and encouraged *after* the user has joined.

- **Implementation:**
  - Upon first login, the user's dashboard will display a prominent, but dismissible, banner or widget prompting them to complete their profile (e.g., "Tell us your travel style to get personalized deals!").
  - This call-to-action will lead them to their profile settings page, where they can add their travel preferences, interests, and budget.
  - A progress bar can be used to gamify the completion of their profile, visually encouraging them to provide more information.

### 3. The "Freemium" Experience (Future Implementation)

To further lower the barrier to entry, a "freemium" tier will be introduced.

- **Free Tier Access:**
  - Access to community forums.
  - Ability to create a member profile.
  - Access to the general knowledge base.
- **Paid Tier Exclusives:**
  - Access to automated last-minute deals.
  - Access to the "Mystery Trip" generator.
  - Advanced personalization and notifications.

This model allows prospective members to experience the community firsthand, creating a natural and compelling upsell path to the full-featured subscription.
