[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$modules = @(
    'Pester',
    'PSScriptAnalyzer'
)

Set-PSRepository PSGallery -InstallationPolicy Trusted

foreach ($module in $modules) {
    if (-not (Get-Module -ListAvailable -Name $module)) {
        Write-Host "Installing $module..." -ForegroundColor Cyan
        Install-Module -Name $module -Scope CurrentUser -Force -SkipPublisherCheck
    }
}

Write-Host 'PowerShell dependencies are ready.' -ForegroundColor Green

