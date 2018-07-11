param($TargetDir)

$PS1s = Get-ChildItem "$PSScriptRoot\src" | Where-Object Extension -eq ".ps1"

$TargetFile = Join-Path $TargetDir "UniversalDashboard.Controls.psm1"
Remove-Item $TargetFile -ErrorAction SilentlyContinue -Force

Write-Host "$TargetFile"

foreach($ps1 in $ps1s) {
    Get-Content $ps1.FullName | Out-File -FilePath $TargetFile -Append
} 