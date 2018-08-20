$Dashboard = New-UdDashboard -Title "Tree View" -Content {
    New-UDRow -Columns {
        New-UDColumn -Size 3 -Content {
            $Root = New-UDTreeNode -Name 'FileSystem' -Id 'FileSystem'
            New-UDTreeView -ActiveBackgroundColor '#DFE8E4' -Node $Root -OnNodeClicked {
                param($Body)

                $Depth = [int]$Obj.NodeId

                if ($Obj.NodeId -eq 'FileSystem') {
                    Get-PSDrive -PSProvider FileSystem | ForEach-Object {
                        New-UDTreeNode -Name $_.Root -Id $_.Root -Icon hdd_o
                    }        
                } else {
                    
                    Get-ChildItem -Path $Obj.NodeId | ForEach-Object {
                        if ($Obj.NodeId -eq $_.FullName) {
                            return;
                        }

                        if ($_.PSIsContainer) {
                            New-UDTreeNode -Name $_.Name -Id $_.FullName -Icon folder
                        } else {
                            New-UDTreeNode -Name $_.Name -Id $_.FullName -Icon file_text
                        }

                    } | ConvertTo-JsonEx

                    Set-UDElement -Id "properties" -Content {
                        New-UDGrid -Title $Obj.NodeId -Headers @("Name", "Value") -Properties @("Name", "Value") -Endpoint {
                            $Obj = $ArgumentList[0]
                            (Get-ItemProperty -Path $Obj.NodeId).PSObject.Properties | ForEach-Object {
                                [PSCustomObject]@{
                                    Name = $_.Name
                                    Value = if ( $_.Value -eq $null) { "" } else { $_.Value.ToString() }
                                }
                            } | Out-UDGridData
                        } -ArgumentList $Obj
                    }
                }
            } 
        }
        New-UDColumn -Size 9 -Content {
            New-UDElement -Tag "div" -Id "properties" -Content {}
        }
    }

    
}

$Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard