return 

. "$PSScriptRoot\..\TestFramework.ps1"

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

            New-UDButton -Text "Replace Toast" -Id "btnReplace" -OnClick {
                Show-UDToast -Title "Shipped!" -Message "You order has shipped!" -Id "Replace" -Duration 5000 -Position "bottomLeft" -Icon user -ReplaceToast
            }
        } 

        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force
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

        It "should replace toast" {
            Find-SeElement -Driver $Driver -Id 'btnReplace' | Invoke-SeClick

            Start-Sleep -Seconds 3

            (Find-SeElement -Driver $Driver -Id 'Replace' | Measure-Object).Count | should be 1
        }
    }
}






