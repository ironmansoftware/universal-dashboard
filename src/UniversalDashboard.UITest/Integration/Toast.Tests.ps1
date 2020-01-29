param([Switch]$Release)

. "$PSScriptRoot\..\TestFramework.ps1"
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard
Describe "Toast" {
    Context "Show toasts" {
        $Dashboard = New-UdDashboard -Title "Making Toast" -Content {
            New-UDButton -Text "Standard" -Id "btnStandard" -OnClick {
                Show-UDToast -Title "Shipped!" -Message "You order has shipped!" -Id "Standard" -Duration 5000 -Position "bottomLeft" -Icon user
            }

            New-UDButton -Text "ShowToast HideToast" -Id "btnHide" -OnClick {
                Show-UDToast -Title "Showing!" -Message "Hi!" -Id "Hide" -Duration 10000 -Position "bottomRight" -Icon user -TransitionIn flipInX
                Start-Sleep 1
                Hide-UDToast -Id "Hide"
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

            $Text.Contains("You order has shipped!") | Should be $true
            $Text.Contains("Shipped!") | Should be $true
        }

        It "should show hide toast" {
            Find-SeElement -Driver $Driver -Id 'btnHide' | Invoke-SeClick

            Start-Sleep -Seconds 3

            $Element = Find-SeElement -Driver $Driver -Id 'Hide' 
            $Text = $Element.Text
            $Text | Should be $null
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }
}






