function Get-TreeViewLines {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Path,

        [Parameter(Mandatory)]
        [int] $Depth,

        [Parameter(Mandatory)]
        [bool] $IncludeFiles,

        [Parameter(Mandatory)]
        [ValidateSet('Ascii', 'Unicode')]
        [string] $Format
    )

    $resolvedPath = (Resolve-Path -LiteralPath $Path).Path
    $rootItem = Get-Item -LiteralPath $resolvedPath
    $lines = [System.Collections.Generic.List[string]]::new()
    $treeViewFormat = Get-TreeViewFormat -Format $Format
    $lines.Add($rootItem.Name) | Out-Null

    Add-TreeViewChildLine -LiteralPath $resolvedPath -RemainingDepth $Depth -IncludeFiles:$IncludeFiles -Prefix '' -Lines $lines -TreeViewFormat $treeViewFormat

    $lines
}
