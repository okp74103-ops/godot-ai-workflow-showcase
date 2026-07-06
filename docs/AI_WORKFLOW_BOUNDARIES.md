# AI Workflow Boundaries

This workflow is built around one rule: AI can suggest and assist, but the tool
must keep scope, evidence, and verification visible.

## What AI Is Allowed To Help With

AI can help with:

- Reading summaries and lead files.
- Choosing the next scoped target.
- Drafting candidate changes.
- Explaining why a candidate is useful.
- Proposing guard improvements.
- Classifying isolated-copy output.
- Preparing verifier instructions.
- Summarizing outcomes for the next worker.

## What AI Must Not Do Blindly

AI should not blindly:

- Rewrite large unrelated surfaces.
- Copy an isolated experiment into the base project.
- Touch distribution outputs or package files.
- Modify original Godot projects through a tool-copy workflow.
- Treat local model text as valid when the response contract failed.
- Retry the same failed candidate without cooldown or new evidence.
- Promote a build without explicit promotion-room approval.

## Candidate Selection Flow

```text
candidate source
  -> failure memory check
  -> cooldown check
  -> do-not-repeat check
  -> local AI availability check
  -> response-contract check
  -> guard check
  -> selected action or skip reason
```

The important part is not only the final selected action. Skipped candidates
should leave enough evidence for a reviewer to know why they were skipped.

## Local AI Failure Types

Local AI failures are split into different recovery routes:

| Failure type | Meaning | Recovery direction |
| --- | --- | --- |
| Model unavailable | Provider is missing, offline, or not reachable. | Retry provider/model later or choose non-local-AI candidate. |
| Model failure | Provider responded but the model failed to produce a useful result. | Try a different model or deterministic fallback. |
| Response-contract failure | Text exists but does not satisfy the expected JSON or field contract. | Repair prompt/contract before trusting output. |

This separation keeps the agent brain from treating every local AI problem as
the same failure.

## Intake Boundary

Isolated-copy output is evidence, not an automatic patch source.

A reviewer should classify each change as:

- `ai_candidate`
- `blocked_surface`
- `non_ai_ignored`
- `needs_more_evidence`

Only `ai_candidate` items that pass the minimum acceptance gate can move toward
manual acceptance.

## Verification Boundary

Worker-mode checks should be lightweight and scoped:

- Search evidence with `rg`.
- Parse PowerShell files when PowerShell changed.
- Compile C# temporarily when source changed.
- Run quick verification with package and busy self-test paths skipped.

Promotion checks, package creation, full self-tests, and engine headless runs are
separate gates. They should not happen as a side effect of ordinary AI intake.

## Public Showcase Boundary

The public repository may show:

- Architecture overview.
- API map.
- Guardrail rules.
- Work-log excerpts.
- Sample report shape.
- Selected gameplay snippets.

The public repository should not show:

- Full tool source.
- Paid rule implementation.
- Private game source.
- Executables or package output.
- Machine-local paths.
- Internal repair scripts.