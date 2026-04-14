# Posh

Starter workspace for building and testing PowerShell tools inside a Dev Container.

## What's Included

- Dev Container based on Microsoft's supported `.NET SDK 9.0` image with PowerShell
- Git, Pester, and PSScriptAnalyzer available in the container
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
Both commands accept `-Format Ascii|Unicode`, with `Unicode` as the default.

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



# Decision Making Guide

This shows a decision making tree whether to use the recommended docker image by microsoft for installing powershell on a container. Or to use a full ubuntu distribution.

Use this rule of thumb.

Choose a supported PowerShell container image when:
- your main goal is “I need PowerShell working in a container”
- you want the least maintenance
- you want the most supported path
- you don’t care that the base image is from the `.NET SDK` line

This is your default choice.

Choose Ubuntu + manual PowerShell install when:
- you specifically need Ubuntu as the base
- you need Ubuntu package behavior or compatibility
- you are okay owning the package/repo setup
- you understand you now have more moving parts to maintain

This is a deliberate exception choice.

Choose a generic devcontainers base image + manual install when:
- you need devcontainer-specific conveniences from that image
- and you also need to customize language/tool installs yourself
- and you’re willing to maintain those installs

This is usually the most flexible, but also the easiest to get wrong.

A simple decision tree:

1. Do I just need PowerShell in a container?
- Use the supported image.

2. Do I need Ubuntu specifically?
- Use Ubuntu and install PowerShell correctly for that Ubuntu version.

3. Do I need devcontainer-specific base-image features badly enough to justify extra setup?
- Use the devcontainers base image and accept the maintenance cost.

For your repo:
- You want a PowerShell tools devcontainer
- You do not appear to need Ubuntu specifically
- So the supported image is the best fit

The practical heuristic is:
- optimize for fewer layers of responsibility
- only drop lower if you have a concrete requirement

So in order of preference for most cases like yours:
1. supported image with PowerShell already present
2. Ubuntu with correct version-matched install
3. generic base image with manual PowerShell install

If you want, I can also turn this into a short “container base image decision checklist” you can reuse for future repos.

Use this checklist before picking a base image for a devcontainer.

**Checklist**

1. What is the main thing I need inside the container?
- If the answer is one tool/runtime, prefer an image that already includes it.

2. Do I need a specific Linux distro?
- If no, don’t choose one just because it feels familiar.
- If yes, be explicit about why.

3. Am I optimizing for support or flexibility?
- Support: choose the officially supported image path.
- Flexibility: choose a more generic base and accept more maintenance.

4. Am I willing to maintain package-install logic?
- If no, avoid manual apt/repo install steps.
- If yes, make sure version matching is part of the design.

5. Will this repo be reused over time by future-me?
- If yes, pick the option with the fewest moving parts.

6. Does the image already include a good non-root dev user?
- If no, plan to create one properly.

7. Are my terminal customizations project-specific or personal?
- Project-specific: keep in the repo.
- Personal: consider dotfiles instead.

**Decision shortcut**

- “I just need PowerShell in a devcontainer.”
  Use a supported image that already has PowerShell.

- “I need Ubuntu specifically.”
  Use Ubuntu and install PowerShell with the exact matching Ubuntu instructions.

- “I need a very customized devcontainer base.”
  Use a generic base image only if you’re comfortable owning the install/setup details.

**Red flags**

Avoid or pause when you catch yourself thinking:
- “I’ll just hardcode this package repo URL.”
- “This base image is close enough.”
- “I can always fix dependencies later.”
- “I want the convenience of one image and the assumptions of another.”

Those are the situations that usually lead to container drift and setup pain.

**Good default mindset**

Pick the highest-level image that already satisfies your core runtime requirement.
Only go lower-level when you have a concrete requirement, not just a preference.

If you want, I can also turn this into a reusable `BASE-IMAGE-CHECKLIST.md` for this repo or for your general notes.
