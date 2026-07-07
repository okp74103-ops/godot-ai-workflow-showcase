# Sample Copy AI Intake

The local workflow can learn from an experimental copy, but it should not merge
everything from that copy. This sample shows the public shape of a selective AI
intake decision.

## Intake Decision

```text
status: selective_adopt
full_source_merge: rejected
accepted_content: stable guard rules only
rejected_content: malformed patch plans, bad JSON, failed self-test artifacts
```

## Why Full Merge Was Rejected

A copy can contain useful lessons and unsafe generated residue at the same time.
The safe intake path is to extract stable rules and reject noisy artifacts.

Rejected examples include:

- generated helper code that only made sense inside the copy
- malformed patch-plan JSON
- malformed patch-apply JSON
- self-test records with invalid or failed exit state
- patch output without a clean reproduction and verification path

## Accepted Guard Rules

The accepted material was rule-level learning, not code import. Example rule
names from the sanitized intake:

```text
do_not_repeat_selection_basis_self_rule_without_repro
do_not_repeat_selection_basis_best_score_after_guard_skips_without_repro
do_not_damage_tool_root_or_original_project_for_self_development
do_not_count_sandbox_breakage_as_growth_without_repair_and_quick_verify
do_not_repeat_self_development_damage_type_without_new_checker_or_regression_fixture
do_not_level_up_self_development_after_any_failed_or_unverified_experience
do_not_treat_fail_restored_as_success_without_recording_the_failed_custom_tool_stage
do_not_accept_partial_restore_when_missing_mismatch_or_extra_counts_remain
```

## Takeaway

The copy is treated as a training source, not as a trusted upstream. The main
project should only accept lessons that are stable, explainable, and backed by
verification.
