
New-UDPage -Name "Collapsible" -Icon check_square -Content {
    New-UDRow -Columns {
        New-UDColumn -Size 2 -Content {}
        New-UDColumn -Size 10 -Content {
            New-UDHeading -Size 1 -Text "Collapsible"  -Color $Colors.FontColor

            New-UDParagraph -Content {
                "Collapsibles organize components into groups that you can hide. "
            } -Color $Colors.FontColor
            
            New-UDElementExample -Example {
                New-UDCollapsible -Items {
                    New-UDCollapsibleItem -Title "" -Content {
                        "Hey!"
                    }
                }
            }
        }
    }
}
