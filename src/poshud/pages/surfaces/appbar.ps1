New-ComponentPage -Title 'AppBar' `
    -Description 'The App Bar displays information and actions relating to the current screen.' `
    -SecondDescription "The top App Bar provides content and actions related to the current screen. It's used for branding, screen titles, navigation, and actions." -Content {

    New-Example -Title 'AppBar with Custom Drawer' -Example {
        $Drawer = New-UDDrawer -Children {
            New-UDList -Children {
                New-UDListItem -Label "Home"
                New-UDListItem -Label "Getting Started" -Children {
                    New-UDListItem -Label "Installation" -OnClick {}
                    New-UDListItem -Label "Usage" -OnClick {}
                    New-UDListItem -Label "FAQs" -OnClick {}
                    New-UDListItem -Label "System Requirements" -OnClick {}
                    New-UDListItem -Label "Purchasing" -OnClick {}
                }
            }
        }

        New-UDAppBar -Position relative -Children { New-UDElement -Tag 'div' -Content { "Title" } } -Drawer $Drawer
    }
} -Cmdlet 'New-UDAppBar'
