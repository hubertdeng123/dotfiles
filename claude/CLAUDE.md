# Development Standards

## Coding Philosophy
- Make minimal, targeted changes - avoid over-engineering or unnecessary refactoring
- Test-first: always write/update tests, run test suite before suggesting commits
- Only change what's directly requested - don't add "improvements" beyond scope

## Code Style
- Python: black, isort, mypy for type checking
- TypeScript/JavaScript: eslint, prettier
- Rust: cargo fmt, clippy

## Testing Requirements
- Run relevant tests before committing changes
- Add tests for new functionality
- Update existing tests when modifying behavior
- For Python: `pytest -xvs path/to/test_file.py`
- For TypeScript: `npm test` or `yarn test`

## Important Context
- I work at Sentry on developer infrastructure and tooling
- Primary projects: sentry, getsentry, devservices, sentry-options
- Prefer uv over pip for Python package management when available

## Linear
- Project details in `~/.claude/linear-projects.md` - read when working on Linear tickets

## Don't Do
- Don't add docstrings/comments to code you didn't change
- Don't refactor surrounding code unless asked
- Don't add error handling for scenarios that can't happen
- Don't create abstractions for one-time operations
