#    Hash Generator
#    Copyright (C) 2024 Noverse
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

$NV = @"
# Created by Noxi-Hu! - Copyright (C) 2024 Noverse
"@

sv -Scope Global -Name "ErrorActionPreference" -Value "SilentlyContinue"
$Host.UI.RawUI.BackgroundColor="Black"
$Host.UI.RawUI.WindowTitle="Noxi's Hash Generator"
cls

function bannercyan {
clear
echo ""
echo ""
Write-Host -ForegroundColor DarkBlue "              ░░░     ░░░   ░░░░░░░░░░░   ░░░     ░░░   ░░░░░░░░░░   ░░░░░░░░░░    ░░░░░░░░░░   ░░░░░░░░░░"
Write-Host -ForegroundColor DarkBlue "              ░░░░    ░░░   ░░░     ░░░   ░░░     ░░░   ░░░          ░░░     ░░░   ░░░          ░░░"
Write-Host -ForegroundColor Blue     "              ▒▒▒▒▒   ░▒▒   ▒░░     ░░▒   ▒░░     ░░▒   ░░░          ▒░░     ▒▒░   ░░░          ░░░"
Write-Host -ForegroundColor Blue     "              ▒▒▒ ▒▒▒ ▒▒▒   ▒▒░     ░▒▒   ▒▒░     ░▒▒   ▒▒▒▒▒▒▒▒     ▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒"
Write-Host -ForegroundColor Blue     "              ▒▒▒   ▒▒▒▒▒   ▒▒▒     ▒▒▒    ▒▒▒   ▒▒▒    ▒▒▒          ▒▓▓     ▓▓▒          ▒▒▒   ▒▒▒"
Write-Host -ForegroundColor DarkCyan "              ▒▓▓    ▓▓▓▒   ▓▓▓     ▓▓▓     ▒▓▓ ▓▓▒     ▓▓▓          ▓▓▓     ▓▓▓          ▓▓▓   ▓▓▓"
Write-Host -ForegroundColor DarkCyan "              ▓▓▓     ▓▓▓   ▓▓▓▓▓▓▓▓▓▓▓       ▓▓▓       ▓▓▓▓▓▓▓▓▓▓   ▓▓▓     ▓▓▓   ▓▓▓▓▓▓▓▓▓▓   ▓▓▓▓▓▓▓▓▓▓"
echo ""
Write-Host                            "‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗" -ForegroundColor DarkGray
echo ""
echo ""}

function log{
param([string]$HighlightMessage, [string]$Message, [string]$Sequence, [ConsoleColor]$TimeColor='DarkGray', [ConsoleColor]$HighlightColor='White', [ConsoleColor]$MessageColor='White', [ConsoleColor]$SequenceColor='White')
$time=" [{0:HH:mm:ss}]" -f(Get-Date)
Write-Host -ForegroundColor $TimeColor $time -NoNewline
Write-Host -NoNewline " "
Write-Host -ForegroundColor $HighlightColor $HighlightMessage -NoNewline
Write-Host -ForegroundColor $MessageColor " $Message" -NoNewline
Write-Host -ForegroundColor $SequenceColor " $Sequence"}
function nvmain {
    bannercyan
    log "[?]" "Enter input path:" -HighlightColor Blue
    Write-Host " >> " -NoNewline -ForegroundColor Blue
    $nvi = Read-Host
    nvhashgen -nvstringin $nvi}
function nvhashgen {
    param ([string]$nvstringin)
    if (-not (Test-Path $nvstringin)) {log "[-]" "Input path does not exist" -HighlightColor Red
    log "[/]" "Press any key to exit" -HighlightColor Yellow
    [System.Console]::ReadKey()> $null;exit}
    iex([System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('JG52bWV0YSA9ICIjIEhhc2hlcyBmcm9tICRudnN0cmluZ2luIHwgQ3JlYXRlZCB3aXRoIE5WLUhhc2hHZW47IE5vdmVyc2UgMjAyNCBgbmBuIg==')))
    log "[+]" "Reading content from" "$nvi" -HighlightColor Green -SequenceColor Yellow
    $nvcontent = cat -Path $nvstringin -Raw
    $nvodir = Split-Path -Path $nvstringin -Parent
    $nvo = Join-Path -Path $nvodir -ChildPath "NV-Hashes.txt"
    $nvhashalg = @("MD5", "SHA1", "SHA256", "SHA384", "SHA512", "RIPEMD160", "HMACMD5", "HMACSHA1", "HMACSHA256", "HMACSHA384", "HMACSHA512")
    $nvbytes = [System.Text.Encoding]::UTF8.GetBytes($nvcontent)
    $nvresult = @()
    foreach ($nvalgorithm in $nvhashalg) {
        try {if ($nvalgorithm -like "HMAC*") {
                $nvhmackey = [System.Text.Encoding]::UTF8.GetBytes("default-key")
                $nvhmac = [System.Security.Cryptography.KeyedHashAlgorithm]::Create($nvalgorithm)
                $nvhmac.Key = $nvhmackey
                $nvhashbytes = $nvhmac.ComputeHash($nvbytes)} else {
                $nvhashal = [System.Security.Cryptography.HashAlgorithm]::Create($nvalgorithm)
                $nvhashbytes = $nvhashal.ComputeHash($nvbytes)}
            $nvhashstring = -join ($nvhashbytes | % { "{0:X2}" -f $_ })
            $nvresult += "$nvalgorithm >> $nvhashstring"
            log "[~]" "Generating hash" "$nvalgorithm" -HighlightColor Gray -SequenceColor Blue
            sleep -Milliseconds 50
        } catch {log "[-]" "Error generating $nvalgorithm hash" -HighlightColor Red}}
    $nvfin = $nvmeta + ($nvresult -join "`n")
    $nvfin | Out-File -FilePath $nvo -Encoding UTF8
    log "[+]" "Hashes generated and saved to" "$nvo" -HighlightColor Green -SequenceColor Yellow
    log "[/]" "Done, press any key to exit" -HighlightColor Yellow
    [System.Console]::ReadKey()> $null;exit}
nvmain