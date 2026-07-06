# Repository instructions

This repository contains one canonical cross-agent skill under `skill/`.

- Do not duplicate `SKILL.md`, reference protocols, or templates into
  agent-specific folders.
- Keep `skill/SKILL.md` as the sole command router.
- Keep each mode protocol in `skill/references/`.
- Keep generated target-project artifacts only in `skill/templates/`.
- Preserve Apache-2.0 licensing and upstream attribution in `NOTICE`.
- Validate structural changes with `python3 tests/test_layout.py`.
