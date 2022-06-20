New-UDDashboard -Title 'PowerShell Universal' -Content {
    New-UDRow -Columns {
        New-UDColumn -LargeSize 6 -Content {
            New-UDCard -Content {
                New-UDForm -Content {
                    New-UDTypography -Text "This is a demo form. Try it out!" -Paragraph
                    New-UDTextbox -Id 'FirstName' -Label 'First Name'
                    New-UDTextbox -Id 'LastName' -Label 'Last Name'
                    New-UDSelect -Id 'Department' -Label 'Department' -Option {
                        New-UDSelectOption -Name 'Executive' -Value 'Executive'
                        New-UDSelectOption -Name 'Development' -Value 'Development'
                        New-UDSelectOption -Name 'Sales' -Value 'Sales'
                    }
                } -OnSubmit {
                    Show-UDToast -Message "Creating user $($EventData.FirstName) $($EventData.LastName)" -Duration 3000
                    $Session:User = $EventData
                    Sync-UDElement -Id 'user'
                }
            }
        
        }
        New-UDColumn -LargeSize 6 -Content {
            New-UDDynamic -Id 'user' -Content {
                if ($Session:User) {
                    New-UDCard -Title 'New User' -Content {
                        New-UDTypography -Text "First Name: $($Session:User.FirstName)" -Variant h5
                        New-UDTypography -Text "Last Name: $($Session:User.LastName)" -Variant h5
                        New-UDTypography -Text "Department: $($Session:User.Department)" -Variant h5
                    }

                    $Session:User = $null
                }
            }
        }
    }

    New-UDDynamic -Id 'table' -Content {
        New-UDButton -Text 'Refresh' -OnClick {
            Sync-UDElement -Id 'table'
        } -Icon (New-UDIcon -Icon 'Sync')
        New-UDTable -Data (Get-Process | select Name, Id) -ShowPagination -PageSize 10 -ShowExport -ShowSort -ShowSearch
    } -LoadingComponent {
        1..5 | % { New-UDSkeleton -Animation 'wave' }
    }
} -HeaderContent {
    New-UDButton -Text 'Forums' -Icon (New-UDIcon -Icon Users) -OnClick {
        Invoke-UDRedirect https://forums.ironmansoftware.com
    }
    New-UDButton -Text 'Learn More' -Icon (New-UDIcon -Icon Book) -OnClick {
        Invoke-UDRedirect https://docs.ironmansoftware.com
    }
}