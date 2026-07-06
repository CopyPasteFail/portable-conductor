#!/usr/bin/env python3
"""Minimal structural checks for the single-source skill design."""

from __future__ import annotations

from pathlib import Path
import json
import sys

ROOT = Path(__file__).resolve().parents[1]
SKILL = ROOT / "skill"

required = [
    SKILL / "SKILL.md",
    SKILL / "references" / "setup.md",
    SKILL / "references" / "new-track.md",
    SKILL / "references" / "implement.md",
    SKILL / "references" / "review.md",
    SKILL / "references" / "revert.md",
    SKILL / "references" / "status.md",
    SKILL / "templates" / "track-metadata.json",
    ROOT / "install.sh",
    ROOT / "install.ps1",
    ROOT / "LICENSE",
    ROOT / "NOTICE",
]

missing = [str(path.relative_to(ROOT)) for path in required if not path.exists()]
if missing:
    print("Missing required files:", *missing, sep="\n- ")
    sys.exit(1)

skill_files = list(ROOT.rglob("SKILL.md"))
if skill_files != [SKILL / "SKILL.md"]:
    print("Expected exactly one canonical SKILL.md, found:")
    for path in skill_files:
        print(f"- {path.relative_to(ROOT)}")
    sys.exit(1)

metadata_template = json.loads((SKILL / "templates" / "track-metadata.json").read_text())
if metadata_template.get("schema_version") != 1:
    print("track-metadata.json must define schema_version 1")
    sys.exit(1)

router = (SKILL / "SKILL.md").read_text()
for mode in ("setup", "new-track", "implement", "review", "revert", "status"):
    if f"`{mode}`" not in router:
        print(f"Router does not declare mode: {mode}")
        sys.exit(1)

print("Portable Conductor layout checks passed.")
