# Sample Scan Summary

This is a public-facing summary format. It is intentionally smaller than the
private JSON reports.

## Catalog Result

| Group | Package | Status |
| --- | --- | --- |
| Syntax / Load Checks | basic | configured |
| Control Tower | pro | configured |
| Role / Risk Scan | pro | configured |
| Knowledge Graph | pro | configured |
| Visual / Scene Evidence | pro | configured |
| Artifacts / Autofix Workflow | pro | configured |
| Balance Simulator | adapter | configured |
| Map / Dungeon Tools | adapter | configured |
| Game Contract Tests | template_only | configured |

## Runtime Evidence Preview

| Check | Result |
| --- | --- |
| first-person bow attached to hand | pass |
| camera culls local head mesh | pass |
| visible first-person arm meshes | pass |
| full-power projectile speed recorded | pass |
| low-power projectile speed reduced | pass |
| debug combat labels hidden | pass |

## Why This Matters

The report gives an AI worker concrete evidence before editing. Instead of
guessing, the worker can see which systems passed, which files are relevant,
and which checks should be rerun after the change.
