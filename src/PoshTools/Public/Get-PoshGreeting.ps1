function Get-PoshGreeting {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string] $Name = 'friend'
    )

    Assert-NotNullOrWhiteSpace -Value $Name -ParameterName 'Name'

    "Hello, $Name. Your PowerShell tools workspace is ready."
}

