---
description: Review code changes with logic and quality analysis
allow-tool-use: true
argument-hint: [optional: file path or PR number]
---

Review the code changes using a chained analysis approach. Target: $1

## Step 1: Get the diff
First, fetch the code changes:
- If a PR number/URL is given, use `gh pr diff <number>`
- If a file path is given, use `git diff` on that file
- If nothing specified, use `git diff` for unstaged changes

## Step 2: Load implementation context

Check if `docs/architecture.md` exists in the project root. If it does, read it to understand:
- The overall architecture and design decisions
- Repository structure and component responsibilities
- Key patterns and conventions
- Implementation phases and what's been completed

This document is the source of truth for how the codebase should work.

## Step 3: Gather additional codebase context (Explore agent)

Use the Task tool with subagent_type="Explore" to find specific context related to the changed files:

Prompt: "Find context for reviewing this code change:
- What files/functions are directly related to the changed code?
- Are there similar implementations to compare against?
- What tests exist for this area?

Changed files/areas:
[summarize what the diff touches]

Return file paths and key patterns found."

## Step 4: Deep review with context (parallel general-purpose agents)

After getting context, launch TWO general-purpose agents IN PARALLEL:

### Agent 1: Logic Review (subagent_type="general-purpose")
Prompt: "Review this code change for logic correctness.

Implementation context from .claude/implementation.md:
[include relevant sections - architecture, design decisions, patterns]

Additional codebase context:
[include Explore agent's findings]

Evaluate:
- Does this change align with the documented architecture?
- Does it follow the patterns described in implementation.md?
- Are there logic errors or incorrect assumptions?
- Does it handle the right edge cases per the design decisions?

Diff to review:
[include the diff]"

### Agent 2: Quality Review (subagent_type="general-purpose")
Prompt: "Review this code change for quality issues:
- Unnecessary complexity or over-engineering
- Bugs and edge cases
- Security issues
- Test coverage gaps

Implementation context:
[include relevant sections from implementation.md]

IMPORTANT - Be precise about severity:
- **Bug**: Code doesn't work correctly, will crash, or produces wrong results
- **UX/Polish**: Code works but error messages are unclear, naming could be better, etc.
- **Missing feature**: Functionality that could exist but doesn't (not a bug)

For error handling specifically:
- If error propagates via ? or is caught: NOT a bug, maybe UX issue if message is unclear
- If error causes panic/crash: IS a bug
- If error is silently swallowed: IS a bug

Be concise. Only flag real issues, not style preferences handled by formatters.

Diff to review:
[include the diff]"

## Step 5: Synthesize
Combine both agent responses into a unified review with sections:
- **Logic Issues** (alignment with architecture, design decisions)
- **Quality Issues** (complexity, bugs, security, tests)
- **Summary** (overall recommendation: approve, request changes, or needs discussion)
