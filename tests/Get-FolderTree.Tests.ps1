BeforeAll {
    $moduleManifest = Join-Path $PSScriptRoot '../src/PoshTools/PoshTools.psd1'
    Import-Module $moduleManifest -Force
}

Describe 'Get-FolderTree' {
    BeforeAll {
        $treeRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("PoshTree_{0}" -f [guid]::NewGuid())
        New-Item -ItemType Directory -Path $treeRoot | Out-Null

        New-Item -ItemType Directory -Path (Join-Path $treeRoot 'alpha') | Out-Null
        New-Item -ItemType Directory -Path (Join-Path $treeRoot 'beta') | Out-Null
        New-Item -ItemType Directory -Path (Join-Path $treeRoot 'alpha/inner') | Out-Null
        New-Item -ItemType File -Path (Join-Path $treeRoot 'root.txt') | Out-Null
        New-Item -ItemType File -Path (Join-Path $treeRoot 'alpha/note.txt') | Out-Null
    }

    AfterAll {
        Remove-Item -LiteralPath $treeRoot -Recurse -Force
    }

    It 'lists only folders using unicode by default' {
        $result = Get-FolderTree -Path $treeRoot -Depth 2

        $result | Should -Be @(
            (Split-Path -Leaf $treeRoot)
            '├── alpha'
            '│   └── inner'
            '└── beta'
        )
    }

    It 'honors depth zero' {
        $result = Get-FolderTree -Path $treeRoot -Depth 0

        $result | Should -Be @(
            (Split-Path -Leaf $treeRoot)
        )
    }

    It 'supports unicode output' {
        $result = Get-FolderTree -Path $treeRoot -Depth 2 -Format Unicode

        $result | Should -Be @(
            (Split-Path -Leaf $treeRoot)
            '├── alpha'
            '│   └── inner'
            '└── beta'
        )
    }

    It 'supports ascii output explicitly' {
        $result = Get-FolderTree -Path $treeRoot -Depth 2 -Format Ascii

        $result | Should -Be @(
            (Split-Path -Leaf $treeRoot)
            '+-- alpha'
            '|   \-- inner'
            '\-- beta'
        )
    }

    It 'throws for missing paths' {
        { Get-FolderTree -Path (Join-Path $treeRoot 'missing') } | Should -Throw
    }

    It 'throws for file paths' {
        { Get-FolderTree -Path (Join-Path $treeRoot 'root.txt') } | Should -Throw
    }

    It 'exports the alias' {
        (Get-Command Show-FolderTree).ResolvedCommandName | Should -Be 'Get-FolderTree'
    }
}
