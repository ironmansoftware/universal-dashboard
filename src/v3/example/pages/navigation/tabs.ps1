New-ComponentPage -Title 'Tabs' -Description 'Tabs make it easy to explore and switch between different views.' -SecondDescription "Tabs organize and allow navigation between groups of content that are related and at the same level of hierarchy." -Content {
    New-Example -Title 'Simple Tables' -Description 'A simple example with no frills.' -Example {
New-UDTabs -Tabs {
    New-UDTab -Text 'Item One' -Content { New-UDTypography -Text 'Item One' -Variant 'h2' }
    New-UDTab -Text 'Item Two' -Content { New-UDTypography -Text 'Item Two' -Variant 'h2' }
    New-UDTab -Text 'Item Three' -Content { New-UDTypography -Text 'Item Three' -Variant 'h2' }
}
    }

    New-Example -Title 'Vertical Tables' -Description 'Vertical tabs' -Example {
New-UDTabs -Tabs {
    New-UDTab -Text 'Item One' -Content { New-UDTypography -Text 'Item One' -Variant 'h2' }
    New-UDTab -Text 'Item Two' -Content { New-UDTypography -Text 'Item Two' -Variant 'h2' }
    New-UDTab -Text 'Item Three' -Content { New-UDTypography -Text 'Item Three' -Variant 'h2' }
} -Orientation vertical
            }
    
} -Cmdlet @("New-UDTabs", "New-UDTab")