# Implement protocol

## Goal

Implement one approved Conductor task at a time while keeping plans, track
status, validation evidence, and project context truthful.

## Preconditions

1. Read `AGENTS.md` or equivalent repository instructions.
2. Read `conductor/workflow.md`, `conductor/tracks.md`, and the selected
   track's `spec.md`, `plan.md`, and `metadata.json`.
3. Confirm that the track is approved or in progress. If the plan has not been
   approved, stop and request approval.
4. Check the working tree. Do not overwrite unrelated user changes. If they
   conflict with the selected task, explain the conflict and stop.
5. Select the explicitly requested task. If no task is named, select the first
   pending task whose dependencies are complete. Never silently skip a blocked
   task.

## Task lifecycle

1. Mark the selected task `[~]` in progress in `plan.md` and set the track
   status to `in-progress` in `tracks.md` and `metadata.json`.
2. Re-read the task's acceptance criteria and constraints immediately before
   editing.
3. Make only changes needed for the selected task. Do not begin later tasks.
4. Write or update tests when the task or repository workflow requires them.
5. Run the required targeted validation and any repository-wide checks required
   by `conductor/workflow.md` or higher-priority instructions.
6. Record exact commands and results under the task's validation evidence.
7. If validation passes, mark the task complete `[x]` and record relevant Git
   commit identifiers if commits are created.
8. If validation fails or cannot run, leave the task in progress or blocked,
   record the cause and output, and do not claim completion.

## Phase verification

At the end of a completed phase, summarize observable behavior for manual
verification. Ask the user to confirm the phase only when manual verification
is necessary or the plan explicitly requires it. Do not start the next phase
until a required manual check is accepted or explicitly deferred in the plan.

## Context synchronization

When implementation reveals a durable architectural, operational, or workflow
change, update the relevant Conductor context file in the same task or record
why that update should be a separate track. Do not rewrite unrelated context.

## Completion

After all tasks are complete:

1. Mark the track `completed` in `tracks.md` and `metadata.json`.
2. Summarize changed files, validation evidence, manual checks, deviations,
   risks, and follow-up work.
3. Recommend `review` before treating the work as accepted.
