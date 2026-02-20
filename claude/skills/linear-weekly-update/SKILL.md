---
name: linear-weekly-update
description: Write a weekly Linear project update. Use when you need to compose a status update for a Linear project, summarizing progress, blockers, and upcoming work.
---

# Linear Weekly Update

Write a structured weekly project update for Linear.

## Arguments

- `project`: Project name or ID (optional - will prompt if not provided)

## Process

### Phase 1: Gather Context

1. **Read project config**: Check `~/.claude/linear-projects.md` for project details and context
2. **Fetch project info**: Use `mcp__linear__get_project` to get current project state including:
   - Project name and description
   - Current status and health
   - Target dates and milestones
3. **Fetch recent issues**: Use `mcp__linear__list_issues` with the project filter and `updatedAt: -P7D` to get issues updated in the last 7 days
4. **Fetch previous updates**: Use `mcp__linear__list_project_updates` to review the last 1-2 updates for continuity

### Phase 2: Analyze Progress

Categorize the week's activity:

| Category | What to Look For |
|----------|------------------|
| **Completed** | Issues moved to Done/Closed state |
| **In Progress** | Issues actively being worked on |
| **Blocked** | Issues with blockers or dependencies |
| **Planned** | New issues added, upcoming priorities |

### Phase 3: Compose Update

Write the update following this structure:

```markdown
## Weekly Update - [Date]

## Summary
[1-2 sentences on overall progress and project health]

## Completed This Week
- [Completed item with issue reference]
- [Another completed item]

## In Progress
- [Active work item and current status]
- [Another active item]

## Blockers / Risks
- [Any blockers or concerns - omit section if none]

## Next Week
- [Planned priorities]
- [Upcoming milestones or deadlines]
```

### Phase 4: Set Health Status

Determine the appropriate health indicator:
- **onTrack**: Progress as expected, no significant blockers
- **atRisk**: Some concerns but recoverable
- **offTrack**: Significant delays or blockers affecting timeline

### Phase 5: Create Update

Use `mcp__linear__create_project_update` with:
- `project`: The project name or ID
- `body`: The composed markdown update
- `health`: The determined health status

## Guidelines

- Keep updates concise - aim for skimmable bullet points
- Reference specific Linear issue IDs (e.g., "ISSUE-123") for traceability
- Be honest about blockers - they help stakeholders understand reality
- Compare against previous update to show progression
- If there's no meaningful progress, say so briefly rather than padding
- Focus on outcomes and impact, not just activity

## Example Output

```markdown
## Weekly Update - Feb 2, 2026

## Summary
Good progress on schema validation. Core functionality complete, now in testing phase.

## Completed This Week
- DEVINFRA-456: Implemented JSON schema validation for config files
- DEVINFRA-457: Added Python client library with type hints

## In Progress
- DEVINFRA-460: Integration tests with sentry repo (70% complete)
- DEVINFRA-461: Documentation for schema authors

## Blockers / Risks
- Waiting on platform team review for the Rust client PR

## Next Week
- Complete integration testing
- Begin rollout to first internal service
```
