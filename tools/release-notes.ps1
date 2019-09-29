param($MilestoneName = "2.6.2")

[System.Net.ServicePointManager]::SecurityProtocol = @("Tls12","Tls11","Tls","Ssl3")

$Milestone = (invoke-restmethod "https://api.github.com/repos/ironmansoftware/universal-dashboard/milestones?state=open") | Where-Object title -eq $MilestoneName
$Issues = invoke-restmethod "https://api.github.com/repos/ironmansoftware/universal-dashboard/issues?milestone=$($Milestone.number)&state=closed"

$Bugs = $Issues | Where-Object { $_.Labels.Name -eq "Bug" }
$Enhancements = $Issues | Where-Object { $_.Labels.Name -eq "Enhancement" }

$Markdown = ""

$Markdown += "# Enhancements " 
$Markdown += [Environment]::NewLine

foreach($Enhancement in $Enhancements) {
    $Markdown += [Environment]::NewLine
    $Markdown +="- [$($Enhancement.title)]($($Enhancement.html_url))"
}

$Markdown += [Environment]::NewLine
$Markdown += [Environment]::NewLine

$Markdown += "# Bug Fixes" 

foreach($Bug in $Bugs) {
    $Markdown += [Environment]::NewLine
    $Markdown +="- [$($Bug.title)]($($Bug.html_url)) - Reported by [$($Bug.user.login)]($($Bug.user.html_url))"
}

$Markdown





