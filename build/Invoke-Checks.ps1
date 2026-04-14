[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$moduleRoot = Join-Path $repoRoot 'src/PoshTools'
$settingsPath = Join-Path $repoRoot 'PSScriptAnalyzerSettings.psd1'
$testPath = Join-Path $repoRoot 'tests'
$analyzerPaths = @(
    $moduleRoot
    $testPath
    (Join-Path $repoRoot 'build')
    (Join-Path $repoRoot 'tools')
)

Write-Host 'Running PSScriptAnalyzer...' -ForegroundColor Cyan
foreach ($analyzerPath in $analyzerPaths) {
    Invoke-ScriptAnalyzer -Path $analyzerPath -Settings $settingsPath
}

Write-Host 'Running Pester...' -ForegroundColor Cyan
$config = New-PesterConfiguration
$config.Run.Path = $testPath
$config.Output.Verbosity = 'Detailed'
$config.TestResult.Enabled = $true
$config.TestResult.OutputPath = Join-Path $repoRoot 'testResults.xml'
$config.TestResult.OutputFormat = 'NUnitXml'

Invoke-Pester -Configuration $config
