param (
    [string]$p='hangman',
    [string]$s='CSharp',
    [switch]$clean
    )

function IsDirty {
    param (
        [string]$sourcePath,
        [string]$exePath
    )

    if (-not [System.IO.File]::Exists($exePath)) {
        return $true
    }

    (Get-Item $sourcePath).LastWriteTime -gt (Get-Item $exePath).LastWriteTime
}

function BuildRunHangman {
    param (
        [string] $source
    )

    switch ($source.ToLower())
    {
        {($_ -eq 'csharp') -or ($_ -eq 'c#') -or ($_ -eq 'cs')} {
            $csPath = ($PSScriptRoot + '\Hangman\CSharp\hangman\Program.cs')
            $csprojPath = ($PSScriptRoot + '\Hangman\CSharp\hangman\hangman.csproj')
            $exePath = ($PSScriptRoot + '\Hangman\CSharp\hangman\bin\Debug\net7.0\hangman.exe')

            if (IsDirty $csPath $exePath) {
                dotnet build $csprojPath
            }
            . $exePath
        }
        {($_ -eq 'ruby') -or ($_ -eq 'rb')} {
            . ($PSScriptRoot + '\Hangman\Ruby\hangman.rb')
        }
        default { Write-Host 'Unavailable source' }
    }

}

function CleanHangmanFiles {
    $buildDirectories = @(
        ($PSScriptRoot + '\Hangman\CSharp\hangman\bin\'),
        ($PSScriptRoot + '\Hangman\CSharp\hangman\obj\'),
    )

    foreach ($dir in $buildDirectories) {
        Remove-Item -Path $dir -Recurse -Force -errorAction SilentlyContinue
    }
}

function CleanBuildFiles {
    CleanHangmanFiles
}

if ($clean) {
    CleanBuildFiles
    return
}

switch ($p.ToLower())
{
    'hangman' {BuildRunHangman $s}
}
