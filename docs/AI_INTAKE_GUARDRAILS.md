# AI Intake Guardrails

This document shows a public version of the safety procedure used before
accepting AI-generated tool changes from an isolated copy.

The implementation is not included. The goal is to show the review contract an
AI supervisor can follow before any base-project change is accepted.

## Boundary

AI-generated output from an isolated copy is treated as evidence only.

The base project does not automatically connect to the copy, compare the copy,
merge the copy, or apply files from the copy. A reviewer must classify each
candidate change first.

## Classification Schema

Each candidate is classified with these fields:

| Field | Expected value |
| --- | --- |
| `file` | Relative path reported by the isolated-copy evidence. |
| `classification` | `ai_candidate`, `blocked_surface`, `non_ai_ignored`, or `needs_more_evidence`. |
| `acceptance_state` | `accept_ai_only`, `defer_needs_more_evidence`, `reject_non_ai_scope`, `reject_blocked_surface`, or `promotion_room_only`. |
| `risk` | `low`, `medium`, or `high`. |
| `required_note` | Why this file is or is not allowed for base-project review. |
| `verification_hint` | One allowed lightweight verification command. |

## Minimum Acceptance Gate

A change is eligible for manual acceptance only when:

- Classification is `ai_candidate`.
- Acceptance state is `accept_ai_only`.
- Risk is `low`, or `medium` with a clear justification.
- The file matches the allowed AI surfaces.
- The file does not match any blocked surface.
- Required evidence is complete.
- Verification uses only lightweight checks.

## Blocked Surfaces

These surfaces stay outside normal AI intake:

- Distribution outputs, zip files, packaged builds, and executable outputs.
- Original Godot projects and copied game project content.
- Blind copy, automatic merge, or bulk overwrite from an isolated copy.
- Build or packaging behavior unless separately authorized.

## Lightweight Verification

Allowed worker-mode checks are intentionally small:

- Evidence search with `rg`.
- PowerShell parse checks for changed `.ps1` files.
- Temporary C# compilation for C# source edits.
- Quick verification with packaging and full self-test skipped.

## Supervisor Signal

The local supervisor view should expose the intake boundary directly:

```text
read-only
copy=not-connected
apply=disabled
```

This makes it visible that the intake procedure is a review contract, not a
background merge pipeline.
