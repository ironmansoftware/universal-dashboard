param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard
Describe "TreeView" {
    Context "blank tree view" {
        $Dashboard = New-UdDashboard -Title "Making Toast" -Content {
            New-UDTreeView -Node (
                New-UDTreeNode -Name "Root" -Children {
                    New-UDTreeNode -Name "Child 1"
                    New-UDTreeNode -Name "Child 2" -Children {
                        New-UDTreeNode -Name "Nested"
                    }
                    New-UDTreeNode -Name "Child 3"
                }
            )
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        #TODO: Write tests for tree view

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server
    }
}






