# Portable Conductor

Portable Conductor is a single Agent Skill that ports the workflow of the Gemini CLI Conductor extension to Codex, GitHub Copilot CLI, and Claude Code.

It keeps one canonical skill source and creates no agent-specific copies of its instructions. The same `skill/` directory is linked into each agent's standard personal-skill location.

## What it provides

Use the `portable-conductor` skill with one of six modes:

- `setup`: create or refresh project context.
- `new-track`: create a scoped feature or bug-fix track with a specification and plan.
- `implement`: execute the next planned task, track progress, and record verification.
- `review`: compare completed work with the specification, plan, and project guidelines.
- `revert`: map a track, phase, or task to Git history and safely revert it after confirmation.
- `status`: summarize all tracks, current work, blockers, and recent verification.

The target repository retains Conductor's durable project structure:

```text
conductor/
  product.md
  product-guidelines.md
  tech-stack.md
  workflow.md
  code_styleguides/
  tracks.md
  tracks/
    <track-id>/
      spec.md
      plan.md
      metadata.json
      review.md
```

## Design

This repository is a skill, not a native marketplace plugin. It deliberately has:

- one `SKILL.md`
- one set of portable command protocols
- one set of templates
- no MCP server
- no background process
- no agent-specific command wrapper
- no generated copies of the skill content

The host agent supplies its own user interface, approval behavior, sandbox, and command execution environment.

## Install

Clone the repository once, then run the installer from its root.

### macOS and Linux

```bash
git clone https://github.com/CopyPasteFail/portable-conductor.git ~/.local/share/portable-conductor
bash ~/.local/share/portable-conductor/install.sh --all
```

### Windows PowerShell

```powershell
git clone https://github.com/CopyPasteFail/portable-conductor.git "$HOME\\.local\\share\\portable-conductor"
& "$HOME\\.local\\share\\portable-conductor\\install.ps1" -Target all
```

The installer creates only links or junctions:

```text
~/.agents/skills/portable-conductor -> <clone>/skill
~/.claude/skills/portable-conductor -> <clone>/skill
```

`~/.agents/skills` is shared by Codex and Copilot CLI. Claude Code reads the link in `~/.claude/skills`.

### Update

```bash
cd ~/.local/share/portable-conductor
git pull
```

Because every installed location points to the same `skill/` directory, no reinstallation or content synchronization is needed after updating. Restart an agent if it does not rediscover the changed skill during the current session.

## Usage

Use natural language or the host agent's skill invocation syntax. Keep the mode explicit.

```text
Use portable-conductor setup for this existing repository.
Use portable-conductor new-track: Add OAuth token rotation.
Use portable-conductor implement task 2 in track oauth-token-rotation.
Use portable-conductor review track oauth-token-rotation.
Use portable-conductor status.
Use portable-conductor revert task 2 in track oauth-token-rotation.
```

The exact slash-command syntax is host-specific. Portable Conductor does not attempt to imitate Gemini's `/conductor:*` command registration.

## Compatibility and migration

Portable Conductor uses the same default `conductor/` project directory and the same primary artifacts as the upstream extension. Existing Conductor projects can therefore be used after the agent reads the existing context and track files.

The following Gemini-specific mechanisms are intentionally not portable:

- Gemini extension registration and update handling
- Gemini Plan Mode enforcement
- Gemini `ask_user` interactive UI
- Gemini policy files and extension paths

The portable protocols replace those mechanisms with explicit confirmation and the host agent's normal approval model.

## Validation

```bash
python3 tests/test_layout.py
```

## License and attribution

This project is an independent, portable rewrite inspired by the workflow and project artifacts of [gemini-cli-extensions/conductor](https://github.com/gemini-cli-extensions/conductor), which is licensed under Apache License 2.0.

See `NOTICE` for attribution. This project is not affiliated with or endorsed by Google or the upstream Conductor maintainers.
