<#
    .SYNOPSIS
    Rosetta build scripts.

    .DESCRIPTION
    Tool to auto compile/build the Rosetta language learning project.

    .PARAMETER Project
    Project to run [hangman (default)]

    .PARAMETER Source
    Source language [cs (default), fp, kt, lua, ps, py, rb, vb]

    .PARAMETER Clean
    Clean build folders

    .PARAMETER Help
    Get this help

    .OUTPUTS
    System.String. Add-Extension returns a string with the extension or file name.

    .EXAMPLE
    PS> build.ps1 -p 'hangman' -s 'cs'

    .EXAMPLE
    PS> build.ps1 -project 'hangman' -source 'cs'

    .EXAMPLE
    PS> build.ps1 -clean

    .LINK
    Source: https://github.com/dragonmost/Rosetta
#>

param (
    [string]$project='hangman',
    [string]$source='CSharp',
    [switch]$clean,
    [switch]$help
    )

#-----------------------------------------------------------[Functions]------------------------------------------------------------

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
        {($_ -eq 'lua')} {
            $lua = ($PSScriptRoot + "\tools\lua\lua54.exe")
            . $lua ($PSScriptRoot + '\Hangman\Lua\hangman.lua')
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
        {($_ -eq 'visualbasic') -or ($_ -eq 'vbnet') -or ($_ -eq 'vb')} {
            $vbPath = ($PSScriptRoot + '\Hangman\VisualBasic\hangman.vb')
            $vbprojPath = ($PSScriptRoot + '\Hangman\VisualBasic\hangman.vbproj')
            $exePath = ($PSScriptRoot + '\Hangman\VisualBasic\build\hangman.exe')
            $buildPath = ($PSScriptRoot + '\Hangman\VisualBasic\build\')

            if (IsDirty $vbPath $exePath) {
                dotnet build -o $buildPath $vbprojPath
            }
            . $exePath
        }
        default { Write-Host 'Unavailable source' }
    }

}

function CleanHangmanFiles {
    $buildDirectories = @(
        ($PSScriptRoot + '\Hangman\CSharp\hangman\bin\'),
        ($PSScriptRoot + '\Hangman\CSharp\hangman\obj\'),
        ($PSScriptRoot + '\Hangman\FreePascal\build\')
        ($PSScriptRoot + '\Hangman\Kotlin\build\'),
        ($PSScriptRoot + '\Hangman\VisualBasic\build\'),
        ($PSScriptRoot + '\Hangman\VisualBasic\obj\')
    )

    foreach ($dir in $buildDirectories) {
        Remove-Item -Path $dir -Recurse -Force -errorAction SilentlyContinue
    }
}

function CleanBuildFiles {
    CleanHangmanFiles
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------

if ($help) {
    Get-Help $PSCommandPath
    return
}

if ($clean) {
    CleanBuildFiles
    return
}

switch ($project.ToLower())
{
    'hangman' {BuildRunHangman $source}
}
