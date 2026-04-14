function Get-PathFolderTree {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Path,

        [Parameter()]
        [ValidateSet('Ascii', 'Unicode')]
        [string] $Format = 'Unicode'
    )

    Get-PathTreeLines -Path $Path -Format $Format
}

