New-ComponentPage -Title 'Nivo Calendar' -Description 'Creates a calendar display' -Content {
    New-Example -Title 'Calendar' -Description '' -Example {
        $Data = @()
        for($i = 365; $i -gt 0; $i--) {
            $Data += @{
                day = (Get-Date).AddDays($i * -1).ToString("yyyy-MM-dd")
                value = Get-Random
            }
        }
        
        $From = (Get-Date).AddDays(-365)
        $To = Get-Date
        
        New-UDNivoChart -Calendar -Data $Data -From $From -To $To -Height 500 -Width 1000 -MarginTop 50 -MarginRight 130 -MarginBottom 50 -MarginLeft 60
    }
} -Cmdlet @("New-UDNivoChart") -Enterprise

