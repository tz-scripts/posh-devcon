function Get-TreeViewFormat {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet('Ascii', 'Unicode')]
        [string] $Format
    )

    switch ($Format) {
        'Unicode' {
            @{
                Branch = [pscustomobject]@{
                    Tee = '├── '
                    Last = '└── '
                }
                Prefix = [pscustomobject]@{
                    Pipe = '│   '
                    Space = '    '
                }
            }
        }
        default {
            @{
                Branch = [pscustomobject]@{
                    Tee = '+-- '
                    Last = '\-- '
                }
                Prefix = [pscustomobject]@{
                    Pipe = '|   '
                    Space = '    '
                }
            }
        }
    }
}

