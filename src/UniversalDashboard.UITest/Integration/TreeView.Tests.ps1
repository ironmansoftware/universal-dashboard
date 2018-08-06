param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard
Describe "TreeView" {
    Context "blank tree view" {
        $Dashboard = New-UdDashboard -Title "Tree View" -Content {
            $Root = New-UDTreeNode -Name 'FileSystem' -Id 'FileSystem'
            New-UDTreeView -Node $Root -OnNodeClicked {
                param($Body)

                $Obj = $Body | ConvertFrom-Json

                if ($Obj.NodeId -eq 'FileSystem') {
                    Get-PSDrive -PSProvider FileSystem | ForEach-Object {
                        New-UDTreeNode -Name $_.Root -Id $_.Root 
                    }        
                } else {
                    Get-ChildItem -Path $Obj.NodeId | ForEach-Object {
                        New-UDTreeNode -Name $_.Name -Id $_.FullName
                    } | ConvertTo-JsonEx
                }
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        #TODO: Write tests for tree view

        #Stop-SeDriver $Driver
        #Stop-UDDashboard -Server $Server
    }
}






