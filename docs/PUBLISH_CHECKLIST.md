# Publish Checklist

Use this checklist before making the repository public.

## Must Be Included

- `README.md`
- `LICENSE`
- `docs/LEAD.md`
- `docs/AI_WORK_LOG_EXCERPT.md`
- `docs/SAMPLE_SCAN_SUMMARY.md`
- selected `samples/*.gd` excerpts

## Must Not Be Included

- full private game project
- scanner source code
- paid tool rules
- generated Godot cache folders
- personal machine paths
- private logs
- full original `.gd` systems that can recreate the game

## Final Checks

```powershell
rg --files
Get-ChildItem -Recurse -File | Select-String -SimpleMatch -Pattern '<private-path-or-credential-pattern>'
```

Expected result: no private paths, local machine paths, or credential-shaped strings.
