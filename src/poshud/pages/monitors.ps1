$Basic = {
    New-UDMonitor -Title "Downloads per second" -Type Line  -Endpoint {
        Get-Random -Minimum 0 -Maximum 10 | Out-UDMonitorData
    } 
}

$RefreshIntervalDataRetention = {
    New-UDMonitor -Title "Downloads per second" -Type Line  -Endpoint {
        Get-Random -Minimum 0 -Maximum 10 | Out-UDMonitorData
    } -DataPointHistory 20 -RefreshInterval 5
}

$CustomColors = {
    New-UDMonitor -Title "Downloads per second" -Type Line  -Endpoint {
        Get-Random -Minimum 0 -Maximum 10 | Out-UDMonitorData
    } -ChartBackgroundColor '#59FF681B' -ChartBorderColor '#FFFF681B' -BackgroundColor "#252525" -FontColor "#FFFFFF"
}

New-UDPage -Name "Monitors" -Icon chart_line -Content {
    New-UDPageHeader -Title "Monitors" -Icon "line-chart" -Description "Visual data using dynamic charts that trace information over time" -DocLink "https://adamdriscoll.gitbooks.io/powershell-universal-dashboard/content/monitors.html"
    New-UDExample -Title "Basic Monitors" -Description "Create basic monitors from any type of data." -Script $Basic
    New-UDExample -Title "Customize refresh rate and data retention" -Description "Customize how often data is returned from the server and how much data to keep" -Script $RefreshIntervalDataRetention
    New-UDExample -Title "Custom colors" -Description "Adjust colors of different components within the monitor." -Script $CustomColors
}