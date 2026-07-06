# Lead File

This file is the first document an AI worker should read before touching code.

## Product Boundary

This showcase demonstrates a scanner-guided Godot workflow. It does not include
the scanner source code, the full game project, paid tool implementation, or
private project history.

## Scanner Operating Model

The scanner is designed around a catalog-first workflow:

```text
project folder
  -> catalog/profile detection
  -> available check groups
  -> selected scan commands
  -> JSON/Markdown reports
  -> AI-readable work brief
  -> focused code edits
  -> final tool verification
```

For isolated AI experiments, generated output is handled as evidence first:

```text
isolated copy result
  -> changed-file evidence
  -> AI-only classification
  -> blocked-surface rejection
  -> lightweight verification plan
  -> manual acceptance or deferral
```

The catalog separates tool groups by package and risk:

| Package | Purpose |
| --- | --- |
| `basic` | Syntax, load, and path checks that should work in most Godot projects. |
| `pro` | Deeper reports such as project status, risk scans, visual evidence, and AI briefs. |
| `adapter` | Checks that run only when a matching project profile exists. |
| `template_only` | Example checks that must be copied or adapted before use. |

## Rules For AI Work

- Start from this lead file, not a broad repository scan.
- Use work logs and scan summaries to narrow the next files to inspect.
- Do not assume project-specific paths exist in every Godot project.
- Keep manager-style scripts from owning unrelated gameplay state.
- Prefer role-boundary comments for files that define ownership.
- Treat isolated AI output as evidence until it passes an intake guardrail.
- Reject blocked surfaces before reviewing code quality.
- Run tool checks before calling work complete.
- Record the outcome so the next AI worker has context.

## What Public Samples Are Allowed To Show

- Selected gameplay snippets.
- Role boundaries and signal flow.
- Scan summary excerpts.
- Work-log excerpts.
- High-level catalog architecture.
- AI intake rules and review boundaries.

## What Public Samples Must Not Include

- Full scanner implementation.
- Full paid tool rules.
- Full private game source.
- Personal machine paths.
- One-off internal repair scripts.
- Generated caches or imported engine data.
- Distribution packages, executable outputs, or zip releases.
