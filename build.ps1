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
        {($_ -eq 'freepascal') -or ($_ -eq 'fp') -or ($_ -eq 'delphi')} {
            $fpPath = ($PSScriptRoot + '\Hangman\FreePascal\hangman.fp')
            $buildPath = ($PSScriptRoot + '\Hangman\FreePascal\build\')
            $exePath = ($PSScriptRoot + '\Hangman\FreePascal\build\hangman.exe')
            $fpcPath = ($PSScriptRoot + '\tools\fpc\bin\i386-win32\fpc.exe')

            if (IsDirty $fpPath $exePath) {
                New-Item -Path $buildPath -ItemType "directory" -errorAction SilentlyContinue | Out-Null
                Start-Process -FilePath $fpcPath -Argumentlist "-FE$buildPath $fpPath" -Wait
            }
            . $exePath
        }
        {($_ -eq 'kotlin') -or ($_ -eq 'kt')} {
            $ktPath = ($PSScriptRoot + '\Hangman\Kotlin\hangman.kt') 
            $jarPath = ($PSScriptRoot + '\Hangman\Kotlin\build\hangman.jar')
            $kotlinc = ($PSScriptRoot + '\tools\kotlinc\bin\kotlinc')

            if (IsDirty $ktPath $jarPath) {
                Start-Process -FilePath $kotlinc -ArgumentList "$ktPath -include-runtime -d $jarPath" -Wait

            }
            java -jar $jarPath
        }
        {($_ -eq 'powershell') -or ($_ -eq 'pwsh') -or ($_ -eq 'ps')} {
            . ($PSScriptRoot + '\Hangman\Powershell\hangman.ps1')
        }
        {($_ -eq 'python') -or ($_ -eq 'py')} {
            . ($PSScriptRoot + '\Hangman\Python\hangman.py')
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
        ($PSScriptRoot + '\Hangman\FreePascal\build\')
        ($PSScriptRoot + '\Hangman\Kotlin\build\')
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
