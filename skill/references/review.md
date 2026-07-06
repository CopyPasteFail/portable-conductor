# Review protocol

## Goal

Perform a read-first review of a track against its specification, plan,
project context, repository rules, and actual validation evidence.

## Preconditions

1. Read `AGENTS.md` or equivalent repository instructions.
2. Read the selected track's `spec.md`, `plan.md`, and `metadata.json`.
3. Read relevant `conductor/` context files, especially `workflow.md` and
   `product-guidelines.md`.
4. Inspect the working tree, task-linked commits, relevant diffs, tests, and
   validation evidence.

## Review checks

Assess:

- acceptance criteria and non-goals
- completed-task claims versus actual changes
- scope creep and undocumented deviations
- compatibility, migration, and rollback risks
- security, privacy, correctness, performance, and operational risks as
  relevant to the target repository
- test coverage and missing failure cases
- whether recorded validation is sufficient and truthful
- whether context artifacts need updates

## Output

Write findings to `conductor/tracks/<track-id>/review.md` only when the user
asks for a persistent review record. Otherwise present findings in the chat.

Use these severities:

- `blocker`: work should not be accepted until resolved
- `major`: material risk or missing requirement
- `minor`: worthwhile correction with limited risk
- `note`: observation, question, or improvement

Each finding must contain evidence, impact, and a specific recommended action.
Do not modify code, task status, or Git history during review unless the user
explicitly changes the request.
