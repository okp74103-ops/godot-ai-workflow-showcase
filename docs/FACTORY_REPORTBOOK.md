# Factory Reportbook

The reportbook is the readable layer around the code factory. It explains what
was considered, what was skipped, what was generated, and what verification said.
This repository includes a public guide instead of raw private report files.

## Main Report Families

| Report family | What it explains | Public-showcase policy |
| --- | --- | --- |
| Candidate filter | Which files/functions were considered, skipped, cooled down, or blocked by memory. | Share sanitized examples only. |
| Agent brain | The current decision state: candidate score, skip cause, recovery path, and next action. | Share structure and selected safe metrics. |
| Decision journal | Append-only record of decisions over time. Useful for debugging repeated AI behavior. | Do not publish raw journals. Summarize only. |
| Local AI status | Whether local AI was unavailable, skipped, used successfully, or rejected by contract checks. | Share failure classes, not prompts. |
| Copy AI intake | What was accepted from an experimental copy and what was rejected. | Share high-level adoption decision. |
| Function connection index | Search-oriented map of related functions across `.gd` files. | Share behavior and field names, not private game code. |
| Quick verify | Lightweight final check for source, package, hub, and drift status. | Share pass/fail summary. |
| Self-test | Deeper tool health check for parser/report/checker behavior. | Share aggregate result. |
| Package/hub sync | Confirms whether packaged output and hub copies match the current source/package. | Share hash-match status, not local paths. |

## How To Read A Run

1. Start from the request: what did the user ask the tool to do?
2. Read the candidate filter: what work was available and what was blocked?
3. Read the agent brain: why was this candidate chosen now?
4. Check local AI status: was AI used, skipped, or rejected?
5. Inspect generated output: patch, companion report, or no-op result.
6. Read verification: did the tool pass the allowed gates?
7. Read promotion evidence: was the result safe to package, sync, or keep only as a sandbox artifact?

## Important No-Op Case

A clean project is not a failure. If the scanner finds no useful issue, the
correct result is `no changes needed` or `not executed`, not a fake failed task.
That prevents an AI worker from inventing unnecessary edits just to satisfy a
forced improvement loop.

## Why This Exists

A local AI workflow becomes hard to trust when it only says "done". The
reportbook makes the process auditable:

- why the AI acted
- why it did not act
- what it generated
- what was verified
- what should happen next
