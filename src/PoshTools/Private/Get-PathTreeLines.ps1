function Get-PathTreeLines {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Path,

        [Parameter(Mandatory)]
        [ValidateSet('Ascii', 'Unicode')]
        [string] $Format
    )

    Assert-NotNullOrWhiteSpace -Value $Path -ParameterName 'Path'

    $normalizedPath = $Path.Trim()
    $treeViewFormat = Get-TreeViewFormat -Format $Format
    $lines = [System.Collections.Generic.List[string]]::new()

    $segments = [regex]::Split($normalizedPath, '[\\/]+') | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
    $hasUnixRoot = $normalizedPath.StartsWith('/')
    $hasWindowsDrive = $normalizedPath -match '^[A-Za-z]:([\\/]|$)'

    if ($hasWindowsDrive) {
        $root = '{0}\' -f $segments[0]
        $lines.Add($root) | Out-Null
        $segments = @($segments | Select-Object -Skip 1)
    }
    elseif ($hasUnixRoot) {
        $lines.Add('/') | Out-Null
    }
    elseif ($segments.Count -gt 0) {
        $lines.Add($segments[0]) | Out-Null
        $segments = @($segments | Select-Object -Skip 1)
    }

    $prefix = ''
    for ($index = 0; $index -lt $segments.Count; $index++) {
        $isLast = $index -eq ($segments.Count - 1)
        $branch = if ($isLast) { $treeViewFormat.Branch.Last } else { $treeViewFormat.Branch.Tee }
        $lines.Add("$prefix$branch$($segments[$index])") | Out-Null
        $prefix += if ($isLast) { $treeViewFormat.Prefix.Space } else { $treeViewFormat.Prefix.Pipe }
    }

    $lines
}
