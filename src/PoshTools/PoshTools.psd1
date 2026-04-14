@{
    RootModule = 'PoshTools.psm1'
    ModuleVersion = '0.1.0'
    GUID = '7a1f54a2-0a3d-4e90-88e2-4f5db68b0b81'
    Author = 'tz'
    CompanyName = 'Personal'
    Copyright = '(c) tz. All rights reserved.'
    Description = 'Starter module for PowerShell tools in a Dev Container workspace.'
    PowerShellVersion = '7.4'
    FunctionsToExport = @(
        'Get-FileTree',
        'Get-FolderTree',
        'Get-PoshGreeting'
    )
    CmdletsToExport = @()
    VariablesToExport = '*'
    AliasesToExport = @(
        'Show-FileTree',
        'Show-FolderTree'
    )
    PrivateData = @{
        PSData = @{
            Tags = @('powershell', 'devcontainer', 'starter')
            ProjectUri = 'https://example.invalid/posh'
        }
    }
}
