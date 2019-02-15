Import-Module "F:\universal-dashboard-enterprise\src\output\UniversalDashboard.psd1"

Get-UDDashboard | Stop-UDDashboard

$Root = $PSScriptRoot
$EndpointInit = New-UDEndpointInitialization -Variable Root

$Folder = Publish-UDFolder -Path (Join-Path $PSScriptRoot "files") -RequestPath "/files"

$Dashboard = New-UDDashboard -Title "Downloads" -Content {
    New-UDRow -Columns {
        New-UDColumn {
            New-UDTable -Title "Downloads" -Headers @("Name", "Size", "Download") -Endpoint {
                Get-ChildItem -Path (Join-Path $Root "files") | ForEach-Object {
                    [PSCustomObject]@{
                        Name = $_.Name
                        Size = "$([Math]::Floor($_.Length / 1KB))KB"
                        Download = New-UDLink -Text "Download" -Url "/files/$($_.Name)"
                    }
                } | Out-UDTableData -Property @("Name", "Size", "Download")
            }
        }
    }    
} -EndpointInitialization $EndpointInit

Start-UDDashboard -Dashboard $Dashboard  -Port 10001 -PublishedFolder $Folder