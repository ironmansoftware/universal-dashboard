Describe "Table" {
    Context "Error in table" {
        Set-TestDashboard -Content {
            New-UDTable -Title "Top GitHub Issues" -Id "Table" -Headers @("Id", "Title", "Description", "Comments", "Date") -Endpoint {
                throw "Error"
            }
        }

        It "has an error" {

            Start-Sleep 1

            $Element = Find-SeElement -Id "Table" -Driver $Driver
            $Element.Text.Contains("Error") | should be true
        }
    }

    Context "AutoRefresh" {
        Set-TestDashboard -Content {
            New-UDTable -Title "Top GitHub Issues" -Id "Table" -Headers @("Id") -Endpoint {
                $items = @()
                $items += [PSCustomObject]@{ ID = Get-Random}
                $items += [PSCustomObject]@{ ID = Get-Random}
                $items += [PSCustomObject]@{ ID = Get-Random}
                $items += [PSCustomObject]@{ ID = Get-Random}

                $items | Out-UDTableData -Property @("ID")
            } -AutoRefresh -RefreshInterval 1
        }

        It "auto reloads" {
            $Element = Find-SeElement -Id "Table" -Driver $Driver
            $Text = $Element.Text

            Start-Sleep 2 

            $Element = Find-SeElement -Id "Table" -Driver $Driver
            $Element.Text | should not be $text

        }
    }

    Context "Table" {
        Set-TestDashboard -Content {
            New-UDTable -Title "Top GitHub Issues" -Id "Table" -Headers @("Id", "Title", "Description", "Comments", "Date") -Endpoint {
                $issues = @();
                $issues += [PSCustomObject]@{ "ID" = 123456;  "Title" = "Product is too awesome...";  "Description" = "Universal Desktop is just too awesome."; Comments = (Get-Random -Minimum 10 -Maximum 10000); Date = (Get-Date -Day 2 -Month 12 -Year 2007) }
                $issues += [PSCustomObject]@{ "ID" = (Get-Random -Minimum 10 -Maximum 10000);  "Title" = "Support for running on a PS4";  "Description" = "A dashboard on a PS4 would be pretty cool."; Comments = (Get-Random -Minimum 10 -Maximum 10000); Date = (Get-Date) }
                $issues += [PSCustomObject]@{ "ID" = (Get-Random -Minimum 10 -Maximum 10000);  "Title" = "Bug in the flux capacitor";  "Description" = "The flux capacitor is constantly crashing."; Comments = (Get-Random -Minimum 10 -Maximum 10000); Date = "/Date(1231232132131)/" }
                $issues += [PSCustomObject]@{ "ID" = (Get-Random -Minimum 10 -Maximum 10000);  "Title" = (New-UDLink -Text "This is text" -Url "http://www.google.com");  "Description" = "Every dashboard needs more hypnotoad"; Comments = (Get-Random -Minimum 10 -Maximum 10000); Date = (Get-Date) }
                
                $issues | Out-UDTableData -Property @("ID", "Title", "Description", "Comments", "Date") 
            } -Links @(
                (New-UDLink -Text "Other Link" -Url "http://www.google.com")
            )

            New-UDTable -Title "Single Item" -Id "SingleItemTable" -Headers @("Id", "Title") -Endpoint {
                [PSCustomObject]@{ "ID" = 123456;  "Title" = "Product is too awesome...";  "Description" = "Universal Desktop is just too awesome."; Comments = (Get-Random -Minimum 10 -Maximum 10000); Date = (Get-Date -Day 2 -Month 12 -Year 2007) } | Out-UDTableData -Property @("ID", "Title") 
            } 
        }

        Start-Sleep 1

        It "has Id in column" {
            $Element = Find-SeElement -Id "Table" -Driver $Driver
            $Element.Text.Contains("123456") | should be true
        }

        It "has formatted DateTime correctly in column" {
            $Element = Find-SeElement -Id "Table" -Driver $Driver
            $Element.Text.Contains("Dec 2, 2007") | should be true
        }

        It "has link in table" {
            Find-SeElement -LinkText "This is text" -Driver $Driver | Should not be $null
        }

        It "has link in footer" {
            Find-SeElement -LinkText "OTHER LINK" -Driver $Driver | Should not be $null
        }

        It "has Id in column for single item table" {
            $Element = Find-SeElement -Id "SingleItemTable" -Driver $Driver
            $Element.Text.Contains("123456") | should be true
        }
    }

    Context "Element onClick in table" {
        Set-TestDashboard -Content {

            New-UDElement -Tag "span" -Id "spanTest" -Content {""}

            New-UDTable -Title "Top GitHub Issues" -Id "Table2" -Headers @("Id", "Title", "Description", "Comments", "Date") -Endpoint {
                [PSCustomObject]@{ Test = $null; Name = "Test"; Description = (
                    New-UDElement -Tag "a" -Id "btnTest" -Attributes @{ href = "#!"; onClick = {
                        Set-TestData -Data $true
                    } 
                } -Content { "Click Me" }
                ) } | Out-UDTableData -Property @("Test", "Name", "Description")
            }
        }

        It "element changes on click" {
            $Element = Find-SeElement -Id "btnTest" -Driver $Driver
            Invoke-SeClick -Element $Element 

            Get-TestData | should be $true
        }
    }

    Context "No error with table with no rows" {
        Set-TestDashboard -Content {
            New-UDTable -Title "Top GitHub Issues" -Id "Table" -Headers @("Id", "Title", "Description", "Comments", "Date") -Endpoint {
                
            }

            New-UDTable -Title "Top GitHub Issues" -Id "Table2" -Headers @("Id", "Title", "Description", "Comments", "Date") -Endpoint {
                [PSCustomObject]@{ Test = $null; Name = "Test" } | Out-UDTableData -Property @("Test", "Name")
            }
        }

        It "has no error" {
            $Element = Find-SeElement -Id "Table" -Driver $Driver
            $Element.Text.Contains("An error occurred in this component") | should not be true
        }

        It "has no error for blank column" {
            $Element = Find-SeElement -Id "Table2" -Driver $Driver
            $Element.Text.Contains("An error occurred in this component") | should not be true
        }
    }
}
