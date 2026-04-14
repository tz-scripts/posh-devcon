BeforeAll {
    $moduleManifest = Join-Path $PSScriptRoot '../src/PoshTools/PoshTools.psd1'
    Import-Module $moduleManifest -Force
}

Describe 'Get-FileTree' {
    BeforeAll {
        $treeRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("PoshTree_{0}" -f [guid]::NewGuid())
        New-Item -ItemType Directory -Path $treeRoot | Out-Null

        New-Item -ItemType Directory -Path (Join-Path $treeRoot 'alpha') | Out-Null
        New-Item -ItemType Directory -Path (Join-Path $treeRoot 'beta') | Out-Null
        New-Item -ItemType Directory -Path (Join-Path $treeRoot 'alpha/inner') | Out-Null
        New-Item -ItemType File -Path (Join-Path $treeRoot 'aardvark.log') | Out-Null
        New-Item -ItemType File -Path (Join-Path $treeRoot 'zulu.log') | Out-Null
        New-Item -ItemType File -Path (Join-Path $treeRoot 'alpha/note.txt') | Out-Null
    }

    AfterAll {
        Remove-Item -LiteralPath $treeRoot -Recurse -Force
    }

    It 'lists folders and files' {
        $result = Get-FileTree -Path $treeRoot -Depth 2

        $result | Should -Be @(
            (Split-Path -Leaf $treeRoot)
            '+-- alpha'
            '|   +-- inner'
            '|   \\-- note.txt'
            '+-- beta'
            '+-- aardvark.log'
            '\\-- zulu.log'
        )
    }

    It 'limits nested traversal by depth' {
        $result = Get-FileTree -Path $treeRoot -Depth 1

        $result | Should -Be @(
            (Split-Path -Leaf $treeRoot)
            '+-- alpha'
            '+-- beta'
            '+-- aardvark.log'
            '\\-- zulu.log'
        )
    }

    It 'supports unicode output' {
        $result = Get-FileTree -Path $treeRoot -Depth 2 -Format Unicode

        $result | Should -Be @(
            (Split-Path -Leaf $treeRoot)
            '├── alpha'
            '│   ├── inner'
            '│   └── note.txt'
            '├── beta'
            '├── aardvark.log'
            '└── zulu.log'
        )
    }

    It 'throws for file paths' {
        { Get-FileTree -Path (Join-Path $treeRoot 'aardvark.log') } | Should -Throw
    }

    It 'exports the alias' {
        (Get-Command Show-FileTree).ResolvedCommandName | Should -Be 'Get-FileTree'
    }
}
