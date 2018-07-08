$PS1s = Get-ChildItem $PSScriptRoot | Where-Object Extension -eq ".ps1"

foreach($ps1 in $ps1s) {
    . $ps1.FullName
}