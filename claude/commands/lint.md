---
description: Run linters and formatters for the current project
allow-tool-use: true
allowed-tools: Bash(pre-commit:*), Bash(black:*), Bash(isort:*), Bash(mypy:*), Bash(eslint:*), Bash(prettier:*), Bash(cargo:*)
argument-hint: [optional: file path]
---

Run linters and formatters for this project. If a path is provided, focus on that path: $1

Detect the project type and run appropriate tools:
- If .pre-commit-config.yaml exists: use `pre-commit run --files` or `pre-commit run --all-files`
- Python: black, isort, mypy
- TypeScript/JavaScript: eslint, prettier
- Rust: cargo fmt, cargo clippy

Report any issues found.
