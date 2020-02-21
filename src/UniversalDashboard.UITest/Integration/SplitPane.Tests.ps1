. "$PSScriptRoot\..\TestFramework.ps1"

Describe "New-UDSplitPane" {

    Context "creates split pane" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDSplitPane -Content {
                New-UDHeading -Text "Content1"
                New-UDHeading -Text "Content2"
            }
        }
        
        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force

        It "should create a split pane" {
            Find-SeElement -Driver $Driver -ClassName "Resizer" | Should not be $null
        }
    }

    Context "creates horizontal split pane" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDSplitPane -Direction horizontal -Content {
                New-UDHeading -Text "Content1"
                New-UDHeading -Text "Content2"
            }
        }
        
        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force

        It "should create a split pane" {
            Find-SeElement -Driver $Driver -ClassName "horizontal" | Should not be $null
        }
    }

    Context "3 items in split pane" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDSplitPane -Direction horizontal -Content {
                New-UDHeading -Text "Content1"
                New-UDHeading -Text "Content2"
                New-UDHeading -Text "Content3"
            }
            New-UDElement -Content {} -Id 'test' -Tag div
        }
        
        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force

        It "should not blow up dashboard" {
            Find-SeElement -Driver $Driver -Id "test" | Should not be $null
        }
    }
}