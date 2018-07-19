param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard
Describe "Toast" {
    Context "Show toasts" {
        $Dashboard = New-UdDashboard -Title "Making Toast" -Content {
            New-UDButton -Text "Standard" -Id "btnStandard" -OnClick {
                Show-UDToast -Title "Hey" -Message "Hi" -Id "Standard" -Duration 5000 -Position "bottomLeft"
            }
        } 

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should show standard toast" {
            Find-SeElement -Driver $Driver -Id 'btnStandard' | Invoke-SeClick

            Start-Sleep 1

            $Element = Find-SeElement -Driver $Driver -Id 'Standard'
            $Text = $Element.Text

            $Text.Contains("Hi") | Should be $true
            $Text.Contains("Hey") | Should be $true
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }
}






