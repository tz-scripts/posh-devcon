BeforeAll {
    $moduleManifest = Join-Path $PSScriptRoot '../src/PoshTools/PoshTools.psd1'
    Import-Module $moduleManifest -Force
}

Describe 'Get-PoshGreeting' {
    It 'returns a default greeting' {
        Get-PoshGreeting | Should -Be 'Hello, friend. Your PowerShell tools workspace is ready.'
    }

    It 'returns a personalized greeting' {
        Get-PoshGreeting -Name 'Taylor' | Should -Be 'Hello, Taylor. Your PowerShell tools workspace is ready.'
    }

    It 'throws for whitespace names' {
        { Get-PoshGreeting -Name '   ' } | Should -Throw
    }
}
