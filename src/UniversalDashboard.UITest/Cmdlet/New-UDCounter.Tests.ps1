. "$PSScriptRoot\..\TestFramework.ps1"

Describe "New-UDCounter" {
    It "sets all valid properties" {
        $Counter = New-UDCounter -Title "Title" -Format "Format" -FontColor "Blue" -Icon user -BackgroundColor Black -Links (
            New-UDLink -Text "Test" -Url "http://www.google.com"
        ) -TextSize Large -TextAlignment Left -Endpoint {} -AutoRefresh -RefreshInterval 20 -Id "Counter"

        $Counter.Title | Should be "Title"
        $Counter.Format | Should be "Format"
        $Counter.FontColor | Should be "rgba(0, 0, 255, 1)"
        $Counter.BackgroundColor | SHould be "rgba(0, 0, 0, 1)"
        $Counter.Links[0].Text | should be "Test"
        $Counter.TextSize | should be "Large"
        $Counter.TextAlignment | Should be "left"
        $Counter.Callback | should not be $null
        $Counter.AutoRefresh | should be $true
        $Counter.RefreshInterval | should be 20
        $Counter.Id | Should be "Counter"
        $Counter.Callback | should not be $null
    }
}