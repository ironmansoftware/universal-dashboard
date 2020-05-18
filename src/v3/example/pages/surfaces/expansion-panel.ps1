New-ComponentPage -Title 'Expansion Panel' -Description 'Expansion panels contain creation flows and allow lightweight editing of an element.' -SecondDescription "An expansion panel is a lightweight container that may either stand alone or be connected to a larger surface, such as a card." -Content {
    New-Example -Title 'Simple Expansion Panel' -Description '' -Example {
        New-UDExpansionPanelGroup -Children {
            New-UDExpansionPanel -Title "Hello" -Children {}

            New-UDExpansionPanel -Title "Hello" -Id 'expContent' -Children {
                New-UDElement -Tag 'div' -Content { "Hello" }
            }
        }
    }
} -Cmdlet "New-UDExpansionPanel"