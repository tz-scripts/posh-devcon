function Assert-NotNullOrWhiteSpace {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string] $Value,

        [Parameter(Mandatory)]
        [string] $ParameterName
    )

    if ([string]::IsNullOrWhiteSpace($Value)) {
        throw "Parameter '$ParameterName' cannot be null, empty, or whitespace."
    }
}

