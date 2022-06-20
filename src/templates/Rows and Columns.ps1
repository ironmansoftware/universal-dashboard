New-UDDashboard -Title 'Rows and Columns' -Content {
    New-UDRow -Columns {
        New-UDColumn -SmallSize 12 -MediumSize 6 -LargeSize 3 -Content {
            New-UDCard -Text "Row 1, Col 1"
        }
        New-UDColumn -SmallSize 12 -MediumSize 6 -LargeSize 3 -Content {
            New-UDCard -Text "Row 1, Col 2"
        }
        New-UDColumn -SmallSize 12 -MediumSize 6 -LargeSize 3 -Content {
            New-UDCard -Text "Row 1, Col 3"
        }
        New-UDColumn -SmallSize 12 -MediumSize 6 -LargeSize 3 -Content {
            New-UDCard -Text "Row 1, Col 4"
        }
    }

    New-UDRow -Columns {
        New-UDColumn -SmallSize 12 -MediumSize 6 -LargeSize 3 -Content {
            New-UDCard -Text "Row 2, Col 1"
        }
        New-UDColumn -SmallSize 12 -MediumSize 6 -LargeSize 3 -Content {
            New-UDCard -Text "Row 2, Col 2"
        }
        New-UDColumn -SmallSize 12 -MediumSize 6 -LargeSize 3 -Content {
            New-UDCard -Text "Row 2, Col 3"
        }
        New-UDColumn -SmallSize 12 -MediumSize 6 -LargeSize 3 -Content {
            New-UDCard -Text "Row 2, Col 4"
        }
    }
}