function Assert-DirectoryPath {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Path
    )

    Assert-PathExists -Path $Path

    $item = Get-Item -LiteralPath $Path
    if (-not $item.PSIsContainer) {
        throw "Path '$Path' must be a directory."
    }
}

