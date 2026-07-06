# Setup protocol

## Goal

Create or refresh durable Conductor context for a repository without changing
application code or inventing facts.

## Inputs and precedence

1. Read the target repository's `AGENTS.md` or equivalent agent instructions.
2. Inspect existing project documentation, build configuration, test commands,
   deployment configuration, source layout, and recent Git history as needed.
3. If `conductor/` already exists, read its context files first and preserve
   user-authored content unless it is demonstrably stale or contradictory.
4. Treat evidence in the repository as stronger than assumptions. Label
   uncertainty rather than filling gaps with guesses.

## Required artifacts

Ensure this layout exists:

```text
conductor/
  product.md
  product-guidelines.md
  tech-stack.md
  workflow.md
  code_styleguides/
  tracks.md
  tracks/
```

Use the matching files in `templates/` as starting points. Adapt them to the
repository. Do not overwrite non-empty context files without showing the
proposed changes and receiving explicit approval.

## Brownfield setup

For an existing repository:

1. Identify its purpose, primary users or operators, core components, major
   dependencies, build and test commands, operational boundaries, style tools,
   and release constraints.
2. Link to authoritative existing docs instead of duplicating large material.
3. Capture observed constraints in `workflow.md`, including validation and
   safety boundaries. Do not impose generic rules such as TDD or a coverage
   threshold unless the repository already requires them.
4. Keep `code_styleguides/` minimal. Add a guide only when it documents a
   repeated repository convention that is not already enforced by tooling or
   documented elsewhere.

## Greenfield setup

For a new or mostly empty repository:

1. Ask only for the missing product purpose, target users, intended stack, and
   non-negotiable workflow or safety constraints.
2. Record answers in the context artifacts without creating production code.
3. State which decisions remain open.

## Completion

Summarize created or updated context files, evidence used, unresolved choices,
and the recommended next command: `new-track`.
