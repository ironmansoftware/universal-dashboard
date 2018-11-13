param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
Import-Module $ModulePath -Force
Describe "Image" {
    Context "path" {

        
        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            $image = (Join-Path $PSScriptRoot "..\assets\logo1.png")
            New-UDDashboard -Title "Test" -Content {
            New-UDImage -Path $image -Id "img" -height 100 -Width 100
        }))') -SessionVariable ss -ContentType "text/plain"

        $Cache:Driver.navigate().refresh()

        It "should have set base64 string" {
            $Element = Find-SeElement -Id "img" -Driver $Cache:Driver
        }
    }
}