---
description: Run tests for the current project or specified path
allow-tool-use: true
allowed-tools: Bash(pytest:*), Bash(npm:*), Bash(cargo:*), Bash(make:*)
argument-hint: [optional: test path or pattern]
---

Run the tests for this project. If a path is provided, run tests for that specific path: $1

Detect the project type and use the appropriate test runner:
- Python: pytest
- TypeScript/JavaScript: npm test or yarn test
- Rust: cargo test

Show test output and summarize results.
