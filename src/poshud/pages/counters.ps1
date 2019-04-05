$Basic = {
    New-UDCounter -Title "Total Bytes Downloaded" -Endpoint {
        Get-Random -Minimum 0 -Maximum 100000000 | ConvertTo-Json
    } -FontColor "black"
}

$AutoRefresh = {
    New-UDCounter -Title "Total Bytes Uploaded" -AutoRefresh -RefreshInterval 3 -Endpoint {
        Get-Random -Minimum 0 -Maximum 100000000 | ConvertTo-Json
    } -FontColor "black"
}

$Formatting = {
    New-UDCounter -Title "Total Revenue" -Format '$0,0.00' -Icon money_bill -Endpoint {
        Get-Random -Minimum 0 -Maximum 100000000 | ConvertTo-Json
    } -FontColor "black"
}

New-UDPage -Name "Counters" -Icon sort_numeric_down -Content {
    New-UDPageHeader -Title "Counters" -Icon "sort-numeric-asc" -Description "Show a simple count in a card." -DocLink "https://adamdriscoll.gitbooks.io/powershell-universal-dashboard/content/api/1.5.0/New-UDCounter.html"
    New-UDExample -Title "Basic Counters" -Description "Display a basic number in a card" -Script $Basic
    New-UDExample -Title "Auto Refreshing Counters" -Description "Turn on auto refresh for the counter to refresh the count." -Script $AutoRefresh
    New-UDExample -Title "Format Numbers" -Description "Format numbers on the client using format strings." -Script $Formatting
}