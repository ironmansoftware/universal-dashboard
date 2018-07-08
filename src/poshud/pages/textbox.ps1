
New-UDPage -Name "Textbox" -Icon font -Content {
    New-UDRow -Columns {
        New-UDColumn -Size 2 -Content {}
        New-UDColumn -Size 10 -Content {
            New-UDHeading -Size 1 -Text "Textboxes"  -Color $Colors.FontColor

            New-UDParagraph -Content {
                "Text fields allow user input."
            } -Color $Colors.FontColor
            
            New-UDElementExample -Example {
                New-UDTextbox -Label 'First Name'
                New-UDTextbox -Placeholder 'Last Name'
                New-UDTextbox -Label 'Disabled' -Placeholder 'I am not editable' -Disabled 
                New-UDTextbox -Label 'Password' -Type 'password'
                New-UDTextbox -Label 'Email' -Type 'email'
            }
        }
    }
}
