# Sample Factory Run

This is a sanitized example of the kind of result the local tool produces. It is
not a raw private log and does not include local file paths, prompts, full JSON
journals, binaries, or project source.

## Request Shape

```text
Goal: improve a Godot project through the local code factory.
Mode: copy-first / sandbox-first.
Expected output: generated report, candidate decision evidence, and verification.
```

## Result Summary

| Check | Public result |
| --- | --- |
| Factory self-test | pass |
| Self-test errors | 0 |
| Self-test warnings | 0 |
| Checked files | 136 |
| Cleanup residue removed | 14 |
| Quick verify after hub sync | pass |
| Quick verify errors | 0 |
| Quick verify warnings | 0 |
| Package/hub drift | false |
| ZIP entry count | 75 |

## Example Decision Trace

```text
request_received
scan_project
build_candidate_list
filter_candidates_with_failure_memory_cooldown_and_do_not_repeat
classify_local_ai_status
produce_patch_or_noop_report
run_allowed_verification
write_reportbook_entries
sync_package_and_hub_only_after_pass
```

## Example Candidate Filter Row

| Field | Example value |
| --- | --- |
| candidate | `inventory_auto_sort_service` |
| target type | function cluster |
| candidate state | skipped |
| skip reason | cooldown plus missing fresh reproduction evidence |
| memory link | prior similar attempt already recorded |
| next safe action | choose a different candidate or collect new evidence |

This is the behavior the public showcase wants to make visible: skipped work is
not silent. It explains why the next AI pass should move elsewhere.

## Example Local AI Status

| Status | Meaning |
| --- | --- |
| unavailable | Endpoint/model could not be used. Do not blame the candidate. |
| skipped | Deterministic path was safer for this candidate. |
| model_failure | The local AI route failed before a usable answer existed. |
| contract_failure | The model answered, but the answer did not satisfy the required structure. |
| accepted | The answer satisfied the contract and can continue to guarded application. |

## What Is Not Published

- the private implementation
- full local AI prompts
- raw decision journals
- full agent memory files
- local machine paths
- packaged commercial ZIP or EXE files
- private Godot project source
