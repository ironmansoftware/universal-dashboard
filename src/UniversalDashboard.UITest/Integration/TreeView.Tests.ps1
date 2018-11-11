param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard
Describe "TreeView" {
    Context "blank tree view" {
        $Dashboard = New-UdDashboard -Title "Tree View" -Content {
            New-UDRow -Columns {
                New-UDColumn -Size 3 -Content {
                    $Root = New-UDTreeNode -Name '1' -Id '1'
                    New-UDTreeView -ActiveBackgroundColor '#DFE8E4' -Node $Root -OnNodeClicked {
                        param($Body)
        
                        $Obj = $Body | ConvertFrom-Json
                        $Depth = ([int]$Obj.NodeId) + 1

                        New-UDTreeNode -Name ($Depth).ToString() -Id  ($Depth).ToString()
                    } 
                }
            }            
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should expand dynamically" {
            1..5 | % {
                $Element = Find-SeElement -Id $_ -Driver $Cache:Driver 
                $Element | Should not be $null
                Invoke-SeClick $Element
                Start-Sleep 1
            }
        }

        Stop-SeDriver $Cache:Driver
        Stop-UDDashboard -Server $Server
    }
}






