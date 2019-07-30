Describe "New-UDTreeView" {
    Context "TreeView" {
        Set-TestDashboard {
            $DomainNode = New-UDTreeNode -Name "Domain" -Id "domain"
            New-UDTreeView -Node $DomainNode -OnNodeClicked {
              param($Body)
              $Obj = $Body | ConvertFrom-Json

              if ($Obj.NodeId -eq 'domain')
              {
                  1..10 | % {
                     New-UDTreeNode -Name $_ -Id $_
                  }
              }
              else
              {
                1..10 | % {
                    $Name = $Obj.NodeId * $_
                    New-UDTreeNode -Name $Name -Id $Name
                }
              }
            }
        } 
        
        It "expands dynamically" {
            Find-SeElement -Id 'domain' -Driver $Driver | Invoke-SeClick
            Start-Sleep 1
            Find-SeElement -Id '1' -Driver $Driver | Invoke-SeClick
            Start-Sleep 1
            Find-SeElement -Id '11' -Driver $Driver | Invoke-SeClick
        }
    }
}

