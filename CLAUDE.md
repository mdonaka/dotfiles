# CLAUDE.md (Global)

This file provides global guidance to Claude Code (claude.ai/code).

## Language

**Always respond in Japanese (日本語).**

## Development Practice

**Test-Driven Development (TDD)** - when building application code with testable logic:

1. **Red**: Write a failing test first
2. **Green**: Write minimum code to pass
3. **Refactor**: Clean up while keeping tests green

*Skip for: scripts, config files, prototypes, exploratory coding*

**Object-Oriented Principles** - when using OOP languages for structured applications:

- Apply SOLID principles
- Favor composition over inheritance
- Program to interfaces

*Skip for: shell scripts, functional code, simple utilities*

**Domain-Driven Design (DDD)** - when dealing with complex business domains:

- Use ubiquitous language
- Model with Entities, Value Objects, Aggregates
- Separate domain from infrastructure

*Skip for: simple CRUD, CLI tools, small scripts*