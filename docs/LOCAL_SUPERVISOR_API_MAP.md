# Local Supervisor API Map

The local supervisor server is a read-only dashboard for AI-assisted Godot work.
It is designed for `127.0.0.1` use and exposes state, not write actions.

This document shows the public API map. It does not include implementation code.

## Review Order

A supervisor starts from a combined snapshot, then drills into the feed that
explains the current blocker or next action.

| API | Purpose |
| --- | --- |
| `/api/supervisor.json` | Combined health, guard, action, artifact, event, and intake snapshot. |
| `/api/queues.json` | Goal queue, training queue, and local AI recovery status. |
| `/api/training.json` | Self-training result, self rules, do-not-repeat rules, and memory counts. |
| `/api/loops.json` | Agent, autopilot, and self-train loop heartbeat state. |
| `/api/runtime.json` | Tool locks, process-scope guard, busy self-test skips, and runtime guards. |
| `/api/guards.json` | Flattened blocking and non-blocking guard reasons. |
| `/api/self-patch.json` | Self-patch plan, diff, apply result, promotion target, and memory status. |
| `/api/promotion.json` | Promotion handoff, quick-verify decision, package/hash drift, and gate status. |
| `/api/workers.json` | Worker board, role schedule, assignment counts, and latest assignment. |
| `/api/local-ai.json` | Provider availability, response-contract state, and recovery direction. |
| `/api/ai-intake.json` | Read-only intake procedure for isolated AI results. |
| `/api/decisions.json` | Agent brain, candidate filter, current decision, and recent evidence. |
| `/api/candidate-filter.json` | Cooldown, do-not-repeat, failure-memory, and local AI blocker counts. |
| `/api/generated.json` | Generated request, checker, apply sandbox, custom tool, and regression status. |
| `/api/cleanup.json` | Cleanup report counts, warnings, skipped active temp paths, and history. |
| `/api/artifacts.json` | Links to readable evidence files. |
| `/api/events.json` | Recent factory activity from logs and journals. |
| `/api/next-actions.json` | Current action queue with source, command hint, blocking flag, and artifact URL. |

## Supervisor Snapshot

The supervisor combines small signals into one fast review surface:

```json
{
  "mode": "factory_local_server_supervisor",
  "read_only": true,
  "guard_status": "pass_or_blocked",
  "blocking_guard_count": 0,
  "first_guard_reason": "...",
  "first_action": "...",
  "ai_intake_status": "procedure_ready_no_copy_connected",
  "ai_intake_read_only": true,
  "ai_intake_connects_to_copy": false,
  "ai_intake_applies_changes": false
}
```

The exact private fields can vary by edition, but the public shape matters: the
supervisor should tell a reviewer whether work is safe to continue, blocked by a
guard, waiting for evidence, or ready for a bounded verification step.

## Guard Queue

A guard row should be readable without opening source code:

| Field | Meaning |
| --- | --- |
| `severity` | How urgent the guard is. |
| `category` | Runtime, promotion, local AI, decision, cleanup, or health. |
| `guard` | Stable guard name. |
| `blocking` | Whether work should stop before continuing. |
| `reason` | Human-readable explanation. |
| `artifact_url` | Evidence link to inspect next. |

## Action Queue

Action rows are intentionally practical:

```text
priority -> action -> reason -> source -> command_hint -> blocking -> artifact_url
```

The goal is to let a supervisor decide the next bounded move without reading all
reports manually.

## Local-Only Boundary

The local server should not be treated as a hosted service:

- Bind to loopback only.
- Serve evidence files, not private project content broadly.
- Keep write actions outside the dashboard.
- Keep package and promotion gates explicit.
- Surface process-scope information so sibling tool copies are not confused with
  the current project.