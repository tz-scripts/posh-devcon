BeforeAll {
    $moduleManifest = Join-Path $PSScriptRoot '../src/PoshTools/PoshTools.psd1'
    Import-Module $moduleManifest -Force
}

Describe 'Get-PathFolderTree' {
    It 'renders a relative path using unicode by default' {
        $result = Get-PathFolderTree -Path 'src/PoshTools/Public'

        $result | Should -Be @(
            'src'
            '├── PoshTools'
            '│   └── Public'
        )
    }

    It 'renders a unix absolute path' {
        $result = Get-PathFolderTree -Path '/workspaces/Posh/src'

        $result | Should -Be @(
            '/'
            '├── workspaces'
            '│   ├── Posh'
            '│   │   └── src'
        )
    }

    It 'renders a windows path with ascii explicitly' {
        $result = Get-PathFolderTree -Path 'C:\Tools\Posh\src' -Format Ascii

        $result | Should -Be @(
            'C:\'
            '+-- Tools'
            '|   +-- Posh'
            '|   |   \-- src'
        )
    }

    It 'exports the alias' {
        (Get-Command Show-PathFolderTree).ResolvedCommandName | Should -Be 'Get-PathFolderTree'
    }

    It 'throws for empty paths' {
        { Get-PathFolderTree -Path '   ' } | Should -Throw
    }
}

