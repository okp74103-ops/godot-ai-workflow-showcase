# Godot AI Workflow Showcase

This repository is a public preview of a Godot gameplay workflow shaped by a
local project-scanner tool. It shows how lead files, work logs, scan summaries,
and selected gameplay code samples can guide AI-assisted development.

The scanner implementation is not included.

## What This Shows

- How an AI worker starts from a lead file instead of scanning blindly.
- How work logs capture goals, changes, verification, and follow-up context.
- How scan summaries give concrete evidence before the next edit.
- How gameplay code can be split by responsibility instead of becoming one
  large manager script.
- How a catalog-based scanner can separate generic checks, paid checks,
  adapters, and template-only checks.
- How a local supervisor API can expose health, guards, actions, artifacts,
  local AI recovery, and intake boundaries without exposing implementation.
- How isolated AI output can be reviewed through an intake guardrail before any
  base-project change is accepted.

## Repository Map

```text
docs/
  LEAD.md
  TOOL_ARCHITECTURE_OVERVIEW.md
  LOCAL_SUPERVISOR_API_MAP.md
  AI_WORKFLOW_BOUNDARIES.md
  AI_WORK_LOG_EXCERPT.md
  AI_INTAKE_GUARDRAILS.md
  SAMPLE_SCAN_SUMMARY.md
samples/
  game_session_signal_flow.gd
  player_leveling_role_boundary.gd
  player_weapon_controller_excerpt.gd
  skill_catalog_data_boundary.gd
LICENSE
README.md
```

## Architecture Preview

For a technical review, read these documents in order:

1. [`docs/LEAD.md`](docs/LEAD.md) - product boundary and operating model.
2. [`docs/TOOL_ARCHITECTURE_OVERVIEW.md`](docs/TOOL_ARCHITECTURE_OVERVIEW.md) - public layer map of the tool.
3. [`docs/LOCAL_SUPERVISOR_API_MAP.md`](docs/LOCAL_SUPERVISOR_API_MAP.md) - supervisor APIs and review order.
4. [`docs/AI_WORKFLOW_BOUNDARIES.md`](docs/AI_WORKFLOW_BOUNDARIES.md) - AI, local model, intake, and verification boundaries.
5. [`docs/AI_INTAKE_GUARDRAILS.md`](docs/AI_INTAKE_GUARDRAILS.md) - isolated-output classification and acceptance gate.

## Workflow Preview

```text
1. Read docs/LEAD.md.
2. Read the latest work-log excerpt.
3. Read the scan summary.
4. Inspect only the named gameplay files.
5. Make focused code changes.
6. Classify any isolated AI output with docs/AI_INTAKE_GUARDRAILS.md.
7. Run tool checks.
8. Record the outcome for the next AI pass.
```

## itch.io

The commercial download page will be linked here:

https://itch.io/

The intended flow is two-way:

- GitHub shows the public evidence, samples, and workflow.
- itch.io provides packaged downloads, paid editions, and release files.

## License

This repository is a public showcase, not an open-source release. See
[`LICENSE`](LICENSE).
