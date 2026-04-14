$publicPath = Join-Path $PSScriptRoot 'Public'
$privatePath = Join-Path $PSScriptRoot 'Private'

foreach ($path in @($privatePath, $publicPath)) {
    if (Test-Path $path) {
        Get-ChildItem -Path $path -Filter '*.ps1' | ForEach-Object {
            . $_.FullName
        }
    }
}

$publicFunctions = if (Test-Path $publicPath) {
    Get-ChildItem -Path $publicPath -Filter '*.ps1' | ForEach-Object {
        $_.BaseName
    }
}

Set-Alias -Name Show-FolderTree -Value Get-FolderTree
Set-Alias -Name Show-FileTree -Value Get-FileTree

$publicAliases = @(
    'Show-FolderTree',
    'Show-FileTree'
)

Export-ModuleMember -Function $publicFunctions -Alias $publicAliases
