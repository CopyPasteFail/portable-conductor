# New-track protocol

## Goal

Turn one bounded feature, defect, refactor, migration, or investigation into a
track with an approved specification and implementation plan.

## Preconditions

1. Read `AGENTS.md` or equivalent repository instructions.
2. Verify `conductor/` exists. If it does not, stop and recommend `setup`.
3. Read `conductor/product.md`, `product-guidelines.md`, `tech-stack.md`,
   `workflow.md`, and `tracks.md`.
4. Inspect only the code and documentation needed to understand the requested
   change.

## Create a track

Create a stable, lowercase, hyphenated ID. Prefer:

```text
<YYYY-MM-DD>-<short-description>
```

Create:

```text
conductor/tracks/<track-id>/
  spec.md
  plan.md
  metadata.json
```

Start from the corresponding templates. Add the track to `conductor/tracks.md`
with status `planned`.

## Specification requirements

`spec.md` must state:

- problem and intended outcome
- in-scope work
- explicit non-goals
- affected systems and interfaces
- acceptance criteria that can be verified
- constraints, compatibility concerns, and risks
- validation strategy
- open questions, if any

Separate facts from assumptions. Do not imply approval merely because a plan
exists.

## Plan requirements

`plan.md` must contain phases, tasks, and sub-tasks that are small enough to
verify independently. Each task should identify:

- purpose and expected change
- likely files or components
- dependencies
- expected tests or validation
- completion evidence

Use the status markers defined by the template. Record planned work only. Do
not mark a task in progress or complete before implementation begins.

## Metadata requirements

`metadata.json` must include a schema version, track ID, title, lifecycle
status, creation date, and compatibility fields. Keep it machine-readable.

## Approval gate

Present the specification, plan, known risks, and unresolved questions. Stop
before code changes. Tell the user that `implement` begins only after approval.
