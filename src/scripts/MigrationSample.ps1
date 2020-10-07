﻿Clear-Host

$scriptDirectory = & {
    if ($psISE) {
        Split-Path -Path $psISE.CurrentFile.FullPath        
    } else {
        $PSScriptRoot
    }
}
. "$($scriptDirectory)\Copy-RainbowContent.ps1"

$sourceSession = New-ScriptSession -user "Admin" -pass 'b' -conn "https://sourcesite.local"
$destinationSession = New-ScriptSession -user "Admin" -pass 'b' -conn "https://destinationsite.local"

$copyProps = @{
    "CopyBehavior"="Overwrite"
    "Recurse"=$true
    "RemoveNotInSource"=$false
    "ClearAllCaches"=$true
    "Detailed"=$true
    "CheckDependencies"=$false
    "BoringMode"=$false
}

$copyProps["SourceSession"] = $sourceSession
$copyProps["DestinationSession"] = $destinationSession
# Default Home
Copy-RainbowContent @copyProps -RootId "{110D559F-DEA5-42EA-9C1C-8A5DF7E70EF9}"