$GridSystem = {
    New-UDRow {
        New-UDColumn -Size 9 {
            New-UDRow {
                New-UDColumn -Size 3 {
                    New-UDCard
                }
                New-UDColumn -Size 3 {
                    New-UDCard
                }
                New-UDColumn -Size 6 {
                    New-UDCard
                }
            }
        }
        New-UDColumn -Size 3 {
            New-UDCard
        }
    }
}

$Layout = {
    New-UDRow {
        New-UDColumn -Size 12 {
            New-UDLayout -Columns 3 -Content {
                New-UDCard 
                New-UDCard
                New-UDCard
                New-UDCard 
                New-UDCard 
                New-UDCard 
            }
        }
    }
}

New-UDPage -Name "Formatting" -Icon th {
    New-UDPageHeader -Title "Formatting" -Icon "th" -Description "Control the layout of your website." -DocLink "https://adamdriscoll.gitbooks.io/powershell-universal-dashboard/content/formatting.html"
    New-UDExample -Title 'Row and column' -Description 'Organize elements by row and column.' -Script $GridSystem
    New-UDExample -Title 'Layouts' -Description 'Automaticaly generates rows and columns based on the number of child elements.' -Script $Layout
}