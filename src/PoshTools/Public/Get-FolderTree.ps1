function Get-FolderTree {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string] $Path = '.',

        [Parameter()]
        [ValidateRange(0, 100)]
        [int] $Depth = 2,

        [Parameter()]
        [ValidateSet('Ascii', 'Unicode')]
        [string] $Format = 'Ascii'
    )

    Assert-DirectoryPath -Path $Path

    Get-TreeViewLines -Path $Path -Depth $Depth -IncludeFiles:$false -Format $Format
}
