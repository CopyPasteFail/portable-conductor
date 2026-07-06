# Status protocol

## Goal

Provide a concise, evidence-based overview of Conductor tracks without
modifying files.

## Steps

1. Read `conductor/tracks.md`.
2. For every listed active, blocked, or recently completed track, read its
   `metadata.json` and `plan.md`.
3. Reconcile obvious disagreement between the registry, metadata, and plan.
   Report disagreement instead of editing state in this mode.
4. Present a table with:

| Track | Status | Current task or phase | Blockers | Last validation | Next action |
| --- | --- | --- | --- | --- | --- |

5. Include:

- tracks whose plan is awaiting approval
- tasks marked in progress without recent validation evidence
- completed tracks awaiting review
- missing or corrupt artifacts
- the recommended next command

Do not infer progress solely from Git commits when the plan does not record it.
