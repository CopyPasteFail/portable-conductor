# Revert protocol

## Goal

Safely revert a Conductor track, phase, or task by mapping the logical target
to real Git commits, including plan updates, then using reversible Git actions.

## Safety rules

- Never use `git reset --hard`, force-push, history rewriting, or destructive
  cleanup for this protocol.
- Never run `git revert` until the user has confirmed both the target and the
  exact proposed commit list.
- Stop immediately on command failure, merge conflict, missing evidence, or
  uncertain commit mapping.
- Preserve unrelated working-tree changes. Require a clean or safely stashed
  working tree before reverting.

## Phase 1: identify and confirm the logical target

1. Read `conductor/tracks.md` and the applicable track plan.
2. If a target is named, locate it and summarize the exact track, phase, or
   task. Ask the user to confirm it.
3. If no target is named, offer the most relevant in-progress items, then the
   most recently completed items. Ask the user to select one.
4. Stop if the target cannot be identified unambiguously.

## Phase 2: reconcile Git history

1. Extract recorded commit IDs from the target task or phase in `plan.md`.
2. Verify each commit exists. If a recorded commit no longer exists, search Git
   history for a highly similar replacement and ask the user to confirm it.
3. Find associated plan-update commits that modified the relevant `plan.md`
   after implementation commits.
4. For whole-track reverts, locate the commit that introduced the track entry
   and track directory when possible.
5. Inspect every candidate for merge commits, duplicate cherry-picks, and
   commits that include unrelated changes.
6. Build the smallest safe revert list, ordered newest to oldest.

## Phase 3: confirm execution plan

Present:

- logical target
- exact commit IDs and messages
- commits intentionally excluded and why
- planned `git revert --no-edit` order
- predicted conflicts or limitations
- post-revert artifact updates, if required

Ask for an explicit final approval. Do not treat a previous approval as this
final approval.

## Phase 4: execute and verify

1. Run `git revert --no-edit` for each approved commit from newest to oldest.
2. On conflict, stop. Explain the conflict and provide the current repository
   state. Do not guess a resolution.
3. Verify the target changes are absent or restored as intended.
4. Update `plan.md`, `tracks.md`, and `metadata.json` only to reflect the
   factual post-revert state. Commit those updates separately if they were not
   included in the revert commits.
5. Report the resulting commit IDs, verification performed, and any remaining
   manual cleanup.
