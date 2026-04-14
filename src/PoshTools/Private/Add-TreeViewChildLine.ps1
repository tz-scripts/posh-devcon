function Add-TreeViewChildLine {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $LiteralPath,

        [Parameter(Mandatory)]
        [int] $RemainingDepth,

        [Parameter(Mandatory)]
        [bool] $IncludeFiles,

        [Parameter(Mandatory)]
        [string] $Prefix,

        [Parameter(Mandatory)]
        [System.Collections.Generic.List[string]] $Lines,

        [Parameter(Mandatory)]
        [hashtable] $TreeViewFormat
    )

    if ($RemainingDepth -le 0) {
        return
    }

    $directories = @(Get-ChildItem -LiteralPath $LiteralPath -Directory | Sort-Object Name)
    $children = [System.Collections.Generic.List[object]]::new()

    foreach ($directory in $directories) {
        $children.Add($directory) | Out-Null
    }

    if ($IncludeFiles) {
        $files = @(Get-ChildItem -LiteralPath $LiteralPath -File | Sort-Object Name)
        foreach ($file in $files) {
            $children.Add($file) | Out-Null
        }
    }

    for ($index = 0; $index -lt $children.Count; $index++) {
        $child = $children[$index]
        $isLast = $index -eq ($children.Count - 1)
        $branch = if ($isLast) { $TreeViewFormat.Branch.Last } else { $TreeViewFormat.Branch.Tee }
        $Lines.Add("$Prefix$branch$($child.Name)") | Out-Null

        if ($child.PSIsContainer) {
            $nextPrefix = if ($isLast) { "$Prefix$($TreeViewFormat.Prefix.Space)" } else { "$Prefix$($TreeViewFormat.Prefix.Pipe)" }
            Add-TreeViewChildLine -LiteralPath $child.FullName -RemainingDepth ($RemainingDepth - 1) -IncludeFiles:$IncludeFiles -Prefix $nextPrefix -Lines $Lines -TreeViewFormat $TreeViewFormat
        }
    }
}
