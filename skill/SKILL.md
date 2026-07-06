---
name: portable-conductor
description: >
  Use when the user asks to set up project context, plan a feature or bug fix,
  implement a planned track, review work against a plan, inspect track status,
  resume a track, or safely revert a track, phase, or task.
---

# Portable Conductor

Portable Conductor is a context-driven development workflow for repositories.
It preserves durable project context, specifications, plans, progress, review
findings, and Git-aware rollback information in the target repository.

## Commands

Interpret the user's request as exactly one mode. If the user does not name a
mode, infer the most specific mode from the request. When ambiguity would cause
writes or a Git revert, ask the user to choose a mode before proceeding.

| Mode | Read this protocol |
| --- | --- |
| `setup` | `references/setup.md` |
| `new-track` | `references/new-track.md` |
| `implement` | `references/implement.md` |
| `review` | `references/review.md` |
| `revert` | `references/revert.md` |
| `status` | `references/status.md` |

## Non-negotiable rules

1. Treat the target repository's `AGENTS.md`, `CLAUDE.md`, repository policy,
   and user instructions as higher priority than this skill.
2. Use `conductor/` as the default project-state location. Respect an existing
   Conductor layout rather than moving or renaming it.
3. Read only the command protocol needed for the active mode, plus files that
   protocol explicitly requires.
4. Do not implement code during `setup`, `new-track`, `status`, or `review`.
5. `new-track` stops after the specification and plan are ready for approval.
6. `revert` never changes Git history until the user has explicitly confirmed
   the exact target and the proposed revert plan.
7. Do not claim a task is complete without recording actual verification or a
   clear explanation of why verification could not run.
8. Preserve unresolved risks and failed checks in the plan. Do not hide them by
   marking work complete.

## Reference and template resolution

Resolve references relative to this `SKILL.md`. Templates live in `templates/`.
Do not copy templates into the skill. Copy or adapt them only into the target
repository when the active protocol says to create an artifact.

## Host-agent adaptation

This skill intentionally does not require a particular command UI. Use the
host agent's normal file, shell, Git, confirmation, and approval mechanisms.
When a protocol says "ask for confirmation", use the host agent's ordinary
interaction method and stop until the user answers.
