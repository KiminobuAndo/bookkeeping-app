# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Rails web app for bookkeeping (簿記) learners to practice identifying whether cash (現金) goes on the debit (借方) or credit (貸方) side of journal entries. MVP focuses on a single "cash debit/credit course" with timed 10-question sessions and score tracking.

## Tech Stack

- **Ruby** 3.3.6 / **Rails** 7.2
- **PostgreSQL** 17 (dev runs on port 5433 via Docker)
- **Hotwire** (Turbo + Stimulus) for frontend interactivity
- **TailwindCSS** 4 + **esbuild** for assets
- **Devise** (planned) for authentication
- **Minitest** + Capybara/Selenium for system tests (no RSpec yet)

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

The app is early-stage. Current structure:

- **`HomeController#index`** serves the root (`/`)
- **`PostsController`** (scaffold stub, not yet domain-relevant)
- Models, controllers, and views for the core domain (courses, questions, results, users) are not yet implemented

### Planned Domain Models (from README)
- `User` — authentication via Devise
- `Course` — groups of questions (MVP: one course)
- `Question` — individual journal entry problems with a correct debit/credit answer
- `Result` — session-level score (10 questions, 100-point scale)
- `ResultDetail` — per-question log (answer, correctness, elapsed seconds, score)

### Scoring Logic
Each question has a 10-second timer. Points per question:
- 0–5 sec correct: 5pts | 6s: 4pts | 7s: 3pts | 8s: 2pts | 9s: 1pt | 10s or wrong: 0pts
- Total (max 50) × 2 = 100-point score

## CI

GitHub Actions runs on PRs and pushes to `main`:
1. `bin/brakeman` — security scan
2. `bin/rubocop -f github` — style lint
3. `bin/rails db:test:prepare test test:system` — full test suite with Postgres service
