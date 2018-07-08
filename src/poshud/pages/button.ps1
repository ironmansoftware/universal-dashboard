
New-UDPage -Name "Button" -Icon plus_circle -Content {
    New-UDRow -Columns {
        New-UDColumn -Size 2 -Content {}
        New-UDColumn -Size 10 -Content {
            New-UDHeading -Size 1 -Text "Buttons" -Color $Colors.FontColor

            New-UDParagraph -Content {
                "There are 3 main button types described in material design. The raised button is a standard button that signify actions and seek to give depth to a mostly flat page. The floating circular action button is meant for very important functions. Flat buttons are usually used within elements that already have depth like cards or modals."
            } -Color $Colors.FontColor
            
            New-UDHeading -Size 3 -Text "Raised" -Color $Colors.FontColor

            New-UDElementExample -Example {
                New-UDButton -Text "Button" 
                New-UDButton -Text "Button" -Icon cloud -IconAlignment left
                New-UDButton -Text "Button" -Icon cloud -IconAlignment right
            }
            
            New-UDHeading -Size 3 -Text "Floating" -Color $Colors.FontColor

            New-UDElementExample -Example {
                New-UDButton -Floating -Icon plus
            }
            
            New-UDHeading -Size 3 -Text "Flat" -Color $Colors.FontColor
            
            New-UDParagraph -Content {
                "Flat buttons are used to reduce excessive layering. For example, flat buttons are usually used for actions within a card or modal so there aren't too many overlapping shadows."
            } -Color $Colors.FontColor
            
            New-UDElementExample -Example {
                New-UDButton -Text "Button" -Flat
            }

            New-UDHeading -Size 3 -Text "OnClick Event" -Color $Colors.FontColor
            
            New-UDParagraph -Content {
                "Tie ScriptBlocks to an OnClick event."
            } -Color $Colors.FontColor

            New-UDElementExample -Example {
                New-UDHeading -Size 5 -Id "ShowOnClick" -Text ""
                New-UDButton -Text "Button" -OnClick {
                    Set-UDElement -Id "ShowOnClick" -Content { "You clicked the button!" }
                }
            }
        }
    }
}
