# Tool Architecture Overview

This is a public architecture view of the local Godot AI workflow tool. It shows
how the system is organized without exposing scanner implementation, paid rules,
private project code, or package outputs.

## High-Level Pipeline

```text
Godot project or copied project
  -> profile and catalog detection
  -> selected checks
  -> JSON and Markdown evidence
  -> AI-readable work brief
  -> worker routing
  -> guarded edit or generated request
  -> lightweight verification
  -> supervisor handoff
```

The tool is designed to keep AI work evidence-driven. A worker should not scan a
large project blindly or edit by guessing. It receives scoped evidence, named
files, risk signals, and a verification path.

## Main Layers

| Layer | Responsibility | Public detail shown |
| --- | --- | --- |
| Catalog | Detect available check groups and project profiles. | Group names, package level, and configured status. |
| Evidence | Produce JSON and Markdown reports for AI review. | Summary shape, pass/fail state, and artifact names. |
| Brain | Select candidates, remember failures, avoid repeats, and route work. | Decision categories and memory concepts. |
| Local AI | Use local model output only when provider and response contracts pass. | Recovery states, not provider internals. |
| Worker Board | Split work into planner, coder, verifier, packager, promoter, and supervisor lanes. | Role responsibilities and handoff structure. |
| Guard Layer | Block unsafe surfaces and expose reasons before work proceeds. | Guard names, severity, source, and artifact links. |
| Supervisor | Combine health, guards, actions, artifacts, and recent events. | Read-only local API map and review order. |
| Intake | Treat isolated AI output as evidence until manually classified. | Classification schema and acceptance gate. |

## Why The Structure Matters

A simple AI script can generate code, but it often loses track of scope, repeat
failures, stale reports, and unsafe outputs. This workflow adds supervision:

- Every candidate has evidence.
- Repeated failures can cool down instead of looping.
- Local AI failure is separated from response-contract failure.
- Workers receive bounded roles instead of one broad instruction.
- Supervisor APIs expose what is blocked, why, and where to inspect it.
- Isolated AI output is reviewed through intake before acceptance.

## Protected Implementation Areas

The public showcase intentionally hides:

- Full scanner source.
- Paid or private checker rules.
- Build, packaging, and distributed self-test internals.
- Original Godot project content.
- Executables, zip files, package outputs, and generated caches.
- Machine-local paths and private history.

## Public Evidence Shape

The public repository shows enough shape for a technical reviewer to understand
how the tool behaves:

```text
reports explain what happened
APIs explain current state
worker prompts explain who should act
intake guardrails explain what may be accepted
verification notes explain what was checked
```

That is the intended boundary: useful architecture evidence without publishing
the protected implementation.