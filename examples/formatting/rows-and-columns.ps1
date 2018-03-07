<#
    Provides an example of using rows and columns.
#>

Import-Module UniversalDashboard

$Dashboard = New-UDDashboard -Title "Formatting - Rows and Columns" -Content {
    New-UDRow -Columns {
        New-UDColumn -Size 6 -Content {
            New-UDCard -Title "Row 1 - Column 1 - Size 6"
        }
        New-UDColumn -Size 6 -Content {
            New-UDCard -Title "Row 1 - Column 2 - Size 6"
        }
    }
    New-UDRow -Columns {
        New-UDColumn -Size 3 -Content {
            New-UDCard -Title "Row 2 - Column 1 - Size 3"
        }
        New-UDColumn -Size 3 -Content {
            New-UDCard -Title "Row 2 - Column 2 - Size 3"
        }
        New-UDColumn -Size 3 -Content {
            New-UDCard -Title "Row 2 - Column 3 - Size 3"
        }
        New-UDColumn -Size 3 -Content {
            New-UDCard -Title "Row 2 - Column 4 - Size 3"
        }
    }
    New-UDRow -Columns {
        New-UDColumn -Size 6 -Content {
            New-UDCard -Title "Row 3 - Column 1 - Size 6"
        }
        New-UDColumn -Size 3 -Content {
            New-UDCard -Title "Row 3 - Column 2 - Size 3"
        }
        New-UDColumn -Size 3 -Content {
            New-UDCard -Title "Row 3 - Column 3 - Size 3"
        }
    }
}

Start-UDDashboard -Dashboard $Dashboard -Port 8080