
New-UDPage -Name "Card" -Icon clone -Content {
    New-UDRow -Columns {
        New-UDColumn -Size 3 -Content {}
        New-UDColumn -Size 6  -Content {
            New-UDHeading -Size 1 -Text "Cards" -Color $Colors.FontColor

            New-UDParagraph -Content {
                "Cards are a convenient means of displaying content composed of different types of objects. They’re also well-suited for presenting similar objects whose size or supported actions can vary considerably, like photos with captions of variable length."
            } -Color $Colors.FontColor
            
            New-UDHeading -Size 3 -Text "Basic Card"  -Color $Colors.FontColor

            New-UDElementExample -Example {
                New-UDCard -Title 'Card Title' -Content {
                    New-UDParagraph -Text 'I am a very simple card. I am good at containing small bits of information. I am convenient because I require little markup to use effectively.'
                } -Links @(
                    New-UDLink -Text 'This is a link' -Url '#!'
                    New-UDLink -Text 'This is a link' -Url '#!'
                ) -Size 'small'
            }

            New-UDHeading -Size 3 -Text "Image Card"  -Color $Colors.FontColor

            New-UDParagraph -Content {
                "Here is the standard card with an image thumbnail."
            } -Color $Colors.FontColor

            New-UDElementExample -Example {
                New-UDCard -Title 'Card Title' -Image (New-UDImage -Url 'http://materializecss.com/images/sample-1.jpg') -Content {
                    'I am a very simple card. I am good at containing small bits of information. I am convenient because I require little markup to use effectively.'
                } -Links @(
                    New-UDLink -Text 'This is a link' -Url '#!'
                    New-UDLink -Text 'This is a link' -Url '#!'
                ) -Size 'small'
            }

            New-UDHeading -Size 3 -Text "Reveal" -Color $Colors.FontColor

            New-UDParagraph -Content {
                "Here you can add a card that reveals more information once clicked. "
            } -Color $Colors.FontColor

            New-UDElementExample -Example {
                New-UDCard -Title 'Card Title' -Image (New-UDImage -Url 'http://materializecss.com/images/sample-1.jpg' -Attributes @{className = 'activator'}) -Content {
                    'Here is some basic text'
                } -Reveal {
                    "Here is some more information about this product that is only revealed once clicked on."
                } -RevealTitle 'Reveal Title' -Size 'small'
            }

            New-UDHeading -Size 3 -Text "Text Size" -Color $Colors.FontColor

            New-UDParagraph -Content {
                "Here is a card with text size of Small"
            } -Color $Colors.FontColor

            New-UDElementExample -Example {
                New-UDCard -Text 'Small Text Size' -TextSize Small
            }

            New-UDParagraph -Content {
                "Here is a card with text size of Medium"
            } -Color $Colors.FontColor

            New-UDElementExample -Example {
                New-UDCard -Text 'Medium Text Size' -TextSize Medium
            }

            New-UDParagraph -Content {
                "Here is a card with text size of Large"
            } -Color $Colors.FontColor

            New-UDElementExample -Example {
                New-UDCard -Text 'Large Text Size' -TextSize Large
            }
        }
    }
}
