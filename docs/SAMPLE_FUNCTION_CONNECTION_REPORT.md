# Sample Function Connection Report

One important user-facing feature is the function connection filter: search one
function and see related functions across other Godot `.gd` files.

This document describes the behavior without publishing private game code.

## Problem It Solves

Large Godot projects often hide behavior across many scripts. A search for one
function name may not be enough because the real work can be spread across
signal handlers, service scripts, UI scripts, inventory scripts, and helper
functions.

The function connection report turns that into a navigable index.

## Search Flow

```text
1. User searches a function, keyword, or role.
2. Tool finds matching functions.
3. Tool expands outbound references: what the function calls or touches.
4. Tool expands inbound references: what calls or references the function.
5. Tool groups connected functions across `.gd` files.
6. Tool marks ambiguous same-name candidates.
7. User filters the result instead of scanning every script manually.
```

## Useful Filters

| Filter | What it does |
| --- | --- |
| text search | Finds function names, file names, and nearby role labels. |
| cross-file only | Shows connections that leave the current script. |
| connects to | Shows functions called or referenced by the selected function. |
| referenced by | Shows functions or scripts that point back to the selected function. |
| ambiguous only | Shows same-name or uncertain matches that need review. |
| role group | Groups service, UI, gameplay, inventory, save, or editor-like code paths. |

## Example Public Row

| Field | Example value |
| --- | --- |
| function | `sort_inventory` |
| file role | inventory service |
| outbound references | item scoring, stack merge, UI refresh signal |
| inbound references | inventory panel button, autosort shortcut, loot pickup flow |
| cross-file count | 3 |
| ambiguous same-name candidates | 1 |
| review hint | confirm whether UI refresh should be delayed until sort completes |

## Why This Matters

This feature is the difference between "AI searched a word" and "AI understood
the connected work area." It helps the agent choose smaller, safer edits because
it can see the surrounding function cluster before generating a patch.
