[CmdletBinding()]
param(
    [switch]$Check,
    [switch]$IncludeDrafts,
    [string]$Workbook,
    [string]$MainLua
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path

if ([string]::IsNullOrWhiteSpace($Workbook)) {
    $Workbook = Join-Path $RepoRoot "㬺獸赤青版.xlsx"
}
if ([string]::IsNullOrWhiteSpace($MainLua)) {
    $MainLua = Join-Path $RepoRoot "mods\pokered-lzh\main.lua"
}

$Importer = Join-Path $PSScriptRoot "import_lzh_text_workspace.py"

foreach ($PathToCheck in @($Importer, $Workbook, $MainLua)) {
    if (-not (Test-Path -LiteralPath $PathToCheck)) {
        throw "Required file not found: $PathToCheck"
    }
}

# Prefer the Windows Python launcher, then fall back to python/python3.
$PythonCommand = $null
$PrefixArgs = @()

$PyLauncher = Get-Command py -ErrorAction SilentlyContinue
if ($null -ne $PyLauncher) {
    $PythonCommand = $PyLauncher.Source
    $PrefixArgs = @("-3")
} else {
    $Python = Get-Command python -ErrorAction SilentlyContinue
    if ($null -ne $Python) {
        $PythonCommand = $Python.Source
    } else {
        $Python3 = Get-Command python3 -ErrorAction SilentlyContinue
        if ($null -ne $Python3) {
            $PythonCommand = $Python3.Source
        }
    }
}

if ($null -eq $PythonCommand) {
    throw "Python 3 was not found. Install Python 3, then reopen PowerShell."
}

$Arguments = @()
$Arguments += $PrefixArgs
$Arguments += @($Importer, $Workbook, $MainLua)
if ($Check) {
    $Arguments += "--check"
}
if ($IncludeDrafts) {
    $Arguments += "--include-drafts"
}

Write-Host "Workbook: $Workbook"
Write-Host "Target:   $MainLua"
if ($Check) {
    Write-Host "Mode:     validation only"
} else {
    Write-Host "Mode:     import"
}
if ($IncludeDrafts) {
    Write-Host "Rows:     Import=Yes plus Status=Draft"
} else {
    Write-Host "Rows:     Import=Yes"
}
Write-Host ""

& $PythonCommand @Arguments
$ExitCode = $LASTEXITCODE
if ($ExitCode -ne 0) {
    throw "Importer exited with code $ExitCode."
}
