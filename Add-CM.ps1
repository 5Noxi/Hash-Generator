$nvfolder  = "$env:localappdata\Noverse"
$gen = "$env:localappdata\Noverse\HashGen.ps1"
New-Item -ItemType Directory -Path $nvfolder -Force | Out-Null
Move-Item -Path "$home\Downloads\HashGen.ps1" -Destination $gen -Force

Write-Host " Enable sleep at the end?" -NoNew
Write-Host " [Y/N]" -ForegroundColor DarkGray
Write-Host " >> " -foregroundcolor blue -NoNewline
$sleep = Read-Host
if ($sleep -match 'Y') {
    echo ""
    Write-Host " Time in seconds:"
    Write-Host " >> " -foregroundcolor blue -NoNewline
    $seconds = Read-Host
    $param = "-sleep -seconds $seconds"
}

$cmd = ('powershell -file "{0}" -nvstringin "%1" {1}' -f $gen, $param)

$filecontext = "HKCU:\Software\Classes\*\shell\NV-Hash"
$filecmd = "HKCU:\Software\Classes\*\shell\NV-Hash\command"
$foldercontext = "HKCU:\Software\Classes\Directory\shell\NV-Hash"
$foldercmd = "HKCU:\Software\Classes\Directory\shell\NV-Hash\command"

if (!(Test-Path $filecontext)) {New-Item -Path $filecontext -Force | Out-Null}
Set-ItemProperty -Path $filecontext -Name "(Default)" -Value "Generate Hashes"

if (!(Test-Path $filecmd)) {New-Item -Path $filecmd -Force | Out-Null}
Set-ItemProperty -Path $filecmd -Name "(Default)" -Value $cmd

if (!(Test-Path $foldercontext)) {New-Item -Path $foldercontext -Force | Out-Null}
Set-ItemProperty -Path $foldercontext -Name "(Default)" -Value "Generate Hashes"

if (!(Test-Path $foldercmd)) {New-Item -Path $foldercmd -Force | Out-Null}
Set-ItemProperty -Path $foldercmd -Name "(Default)" -Value $cmd