
New-UDPage -Name "Switch" -Icon toggle_on -Content {
    New-UDRow -Columns {
        New-UDColumn -Size 2 -Content {}
        New-UDColumn -Size 10 -Content {
            New-UDHeading -Size 1 -Text "Switches"  -Color $Colors.FontColor

            New-UDParagraph -Content {
                "Switches are special checkboxes used for binary states such as on / off"
            } -Color $Colors.FontColor
            
            New-UDElementExample -Example {
                New-UDSwitch
                New-UDSwitch -OnText "Yes" -OffText "No" -Disabled
            }
        }
    }
}
