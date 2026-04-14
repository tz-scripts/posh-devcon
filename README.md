# Posh

Starter workspace for building and testing PowerShell tools inside a Dev Container.

## What's Included

- Dev Container with PowerShell, Git, Pester, and PSScriptAnalyzer
- Module skeleton under `src/PoshTools`
- Public/private function layout
- Pester tests under `tests`
- Lint and test helper script under `build`

## Quick Start

1. Open the folder in VS Code.
2. Reopen in the Dev Container.
3. Run:

```powershell
pwsh ./build/Invoke-Checks.ps1

Import-Module ./src/PoshTools/PoshTools.psd1 -Force
Get-FolderTree -Path . -Depth 2
Get-FileTree -Path . -Depth 2
Show-FolderTree -Path . -Depth 2 -Format Unicode
```

`Get-FolderTree` shows directories only.
`Get-FileTree` shows directories first, then files, with each group sorted by name.
Both commands accept `-Format Ascii|Unicode`, with `Ascii` as the default.

## Repo Layout

```text
.devcontainer/         Dev Container definition
build/                 Local quality checks
src/PoshTools/         PowerShell module source
tests/                 Pester tests
tools/                 Bootstrap scripts
```

## Next Steps

- Rename `PoshTools` to your actual module name
- Add real commands in `src/PoshTools/Public`
- Expand tests as you add behavior
