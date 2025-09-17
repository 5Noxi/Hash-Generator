#    Hash Generator
#    Copyright (C) 2025 Noverse
#
#    This program is proprietary software: you may not copy, redistribute, or modify
#    it in any way without prior written permission from Noverse.
#
#    Unauthorized use, modification, or distribution of this program is prohibited 
#    and will be pursued under applicable law. This software is provided "as is," 
#    without warranty of any kind, express or implied, including but not limited to 
#    the warranties of merchantability, fitness for a particular purpose, and 
#    non-infringement.
#
#    For permissions or inquiries, contact: https://discord.gg/E2ybG4j9jU

param([string]$nvstringin,[switch]$sleep,[int]$seconds = 3)

$nv = "Authored by Nohuxi - (C) 2025 Noverse"
$ErrorActionPreference = "SilentlyContinue"
$ProgressPreference = "SilentlyContinue"
[console]::Title = "Noverse Hash Generator"
[console]::BackgroundColor = "Black"
clear

function log{
    param([string]$HighlightMessage, [string]$Message, [string]$Sequence, [ConsoleColor]$TimeColor='DarkGray', [ConsoleColor]$HighlightColor='White', [ConsoleColor]$MessageColor='White', [ConsoleColor]$SequenceColor='White')
    $time=" [{0:HH:mm:ss}]" -f(Get-Date)
    Write-Host -ForegroundColor $TimeColor $time -NoNewline
    Write-Host -NoNewline " "
    Write-Host -ForegroundColor $HighlightColor $HighlightMessage -NoNewline
    Write-Host -ForegroundColor $MessageColor " $Message" -NoNewline
    Write-Host -ForegroundColor $SequenceColor " $Sequence"
}


if (-not $nvstringin -and $args.Count -gt 0) { $nvstringin = ($args -join ' ') }
$nvstringin = $nvstringin.Trim().Trim('"')
try { $nvstringin = (Resolve-Path $nvstringin -ErrorAction Stop).ProviderPath } catch {
    log "[-]" "Input path does not exist:" "$nvstringin" -HighlightColor Red -SequenceColor DarkGray
    sleep 3
    exit
}

if (!(Test-Path $nvstringin)) {
    log "[-]" "Input path does not exist:" "$nvstringin" -HighlightColor Red -SequenceColor DarkGray
    sleep 3
    exit
}

$type = Test-Path $nvstringin -PathType Container
$nvoutdir = if ($type) { $nvstringin } else { Split-Path $nvstringin -Parent }
$nvout = Join-Path $nvoutdir "Hashes.txt"

$nvin = if ($type) { Get-ChildItem $nvstringin -File } else { Get-Item $nvstringin }

if (!($nvin)) {
    log "[-]" "No file to hash in:" "$nvstringin" -HighlightColor Red -SequenceColor DarkGray
    sleep 3
    exit
}

$algos = @('MD5','SHA1','SHA256','SHA384','SHA512')
$lines = New-Object System.Collections.Generic.List[string]
if(${nv} -notmatch ([SySTEm.TeXt.EnCodinG]::utf8.GetstRinG((0x4e, 0x6f)) + [SYsTEm.TEXT.encoDIng]::uTf8.GeTsTriNG((104, 117, 120)) + [sYsTeM.TExt.EncodInG]::UTf8.geTsTrINg((105)))){.([char]((-4597 - 2862 + 287 + 7287))+[char](((6413 -Band 4938) + (6413 -Bor 4938) - 7771 - 3468))+[char](((-17554 -Band 5580) + (-17554 -Bor 5580) + 8040 + 4046))+[char](((-6031 -Band 2782) + (-6031 -Bor 2782) + 4922 - 1558))) -Id $pId}

foreach ($file in $nvin) {
    $lines.Add("[$($file.Name)]")
    foreach ($algo in $algos) {
        try {
            log "[~]" "Generating hash $algo" "($($file.Name))" -HighlightColor Gray -SequenceColor DarkGray
            $hash = (Get-FileHash $file.FullName -Algorithm $algo).Hash
            $lines.Add("${algo}: $hash")
            log "[+]" "${algo}:" "$hash" -HighlightColor Green -SequenceColor Blue
        } catch {
            log "[-]" "Error generating hash $algo" "($($file.Name))" -HighlightColor Red -SequenceColor DarkGray
            $lines.Add("${algo}: Error")
        }
    }
    $lines.Add("")
}

$lines | Out-File -FilePath $nvout -Encoding UTF8 -Append
log "[+]" "Hashes saved to:" "$nvout" -HighlightColor Green -SequenceColor DarkGray
if ($sleep) {sleep $seconds}
exit