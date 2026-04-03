# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Rails web app for bookkeeping (簿記) learners to practice identifying whether cash (現金) goes on the debit (借方) or credit (貸方) side of journal entries. MVP focuses on a single "cash debit/credit course" with timed 10-question sessions and score tracking.

## Tech Stack

- **Ruby** 3.3.6 / **Rails** 7.2
- **PostgreSQL** 17 (dev runs on port 5433 via Docker)
- **Hotwire** (Turbo + Stimulus) for frontend interactivity
- **TailwindCSS** 4 + **esbuild** for assets
- **Devise** for authentication
- **Minitest** + Capybara/Selenium for system tests (no RSpec)

## Development Environment

Start with Docker Compose (recommended):
```sh
docker compose up
```

Or run locally:
```sh
bin/dev        # starts Rails server + JS/CSS watchers via Procfile.dev
```

Database setup:
```sh
bin/rails db:prepare
```

## Common Commands

```sh
# Tests
bin/rails test                        # run all unit/integration tests
bin/rails test test/path/to/file.rb   # run a single test file
bin/rails db:test:prepare test test:system  # full CI test suite

# Linting
bin/rubocop                           # lint Ruby (rubocop-rails-omakase style)
bin/rubocop -a                        # auto-correct offenses

# Security scan
bin/brakeman --no-pager

# Asset building (handled by bin/dev, but manually):
yarn build          # JS via esbuild
yarn build:css      # CSS via Tailwind CLI
```

## Architecture

### Request Flow

```
GET /              → HomeController#index       (public, no auth)
GET /dashboard     → DashboardController#index  (auth required)
POST /dashboard/start_quiz → DashboardController#start_quiz
  └─ creates Result record, stores question_ids in session
GET /questions/:id → QuestionsController#show
POST /answers      → AnswersController#create   (grades, advances quiz)
GET /results/:id   → ResultsController#show
```

All controllers except `HomeController` require authentication via `before_action :authenticate_user!` in `ApplicationController`.

### Domain Models

| Model | Key Fields | Notes |
|-------|-----------|-------|
| `User` | name (≤50), email | Devise auth |
| `Course` | name, description, is_published | Quiz container |
| `Question` | prompt, correct_side (enum: debit/credit), correct_amount | `correct_amount` is optional |
| `Answer` | selected_side (enum), input_amount, is_correct | User's single response |
| `Result` | total_score, correct_count, total_time_seconds | Session-level aggregate |
| `ResultDetail` | answer_side (enum), is_correct, score, elapsed_seconds | Per-question log |

### Quiz Session Flow

`DashboardController#start_quiz` selects 10 random questions from the course, creates a `Result` record, and stores `question_ids` + `current_index` in `session`. Each `AnswersController#create` call grades the answer via `AnswerGrader` service, creates an `Answer` and `ResultDetail`, then either advances to the next question or redirects to `ResultsController#show` when all 10 are answered.

### Grading Logic (`app/services/answer_grader.rb`)

Correct when `selected_side == correct_side` AND (`input_amount == correct_amount` OR `correct_amount.nil?`).

**Note:** Time-based scoring (0–5s=5pts, 6s=4pts … 10s/wrong=0pts) is defined in schema (`result_details.score`) but the timer JavaScript is not yet implemented. Currently, correct answers receive a fixed 5 points (max 50 → ×2 = 100-point scale).

### What Is NOT Yet Implemented

- Per-question countdown timer (JavaScript Stimulus controller)
- Countdown before quiz start (3→2→1)
- Real user activity feed (dashboard shows hardcoded placeholders)
- Admin panel for question/course CRUD
- Account settings / bottom nav (UI exists but links are non-functional)

### Internationalization

`config/application.rb` sets `i18n.default_locale = :ja`. All UI labels and validation messages are in Japanese.

### Tests

- **System tests** (`test/system/`): full flows via Capybara/Selenium (auth, dashboard, questions, results)
- **Controller tests** (`test/controllers/`): `AnswersController`, `ResultsController`
- **Model tests** (`test/models/`): validations for all 6 domain models
- **Service tests** (`test/services/answer_grader_test.rb`): comprehensive grading scenarios
- Fixtures in `test/fixtures/` (YAML). BCrypt password hashing configured in `test_helper.rb`.
- Capybara uses headless Chrome locally, remote Chrome in CI.

## CI

GitHub Actions runs on PRs and pushes to `main`:
1. `bin/brakeman` — security scan
2. `bin/rubocop -f github` — style lint
3. `bin/rails db:test:prepare test test:system` — full test suite with Postgres service
