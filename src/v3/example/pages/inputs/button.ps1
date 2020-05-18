New-ComponentPage -Title 'Button' -Description 'Buttons allow users to take actions, and make choices, with a single tap.' -SecondDescription 'asdfasfas' -Content {
    New-Example -Title 'Contained Button' -Description 'Contained buttons are high-emphasis, distinguished by their use of elevation and fill. They contain actions that are primary to your app.' -Example {
        New-UDButton -Variant 'contained' -Text 'Default'
    }

    New-Example -Title 'Outlined Button' -Description "Outlined buttons are medium-emphasis buttons. They contain actions that are important, but aren’t the primary action in an app.

    Outlined buttons are also a lower emphasis alternative to contained buttons, or a higher emphasis alternative to text buttons." -Example {
        New-UDButton -Variant 'outlined' -Text 'Default' 
    }

    New-Example -Title 'Buttons with icons and label' -Description 'Sometimes you might want to have icons for certain button to enhance the UX of the application as we recognize logos more easily than plain text. For example, if you have a delete button you can label it with a dustbin icon.' -Example {
        New-UDButton -Icon (New-UDIcon -Icon trash) -Text 'Delete'
    }

    New-Example -Title 'Buttons with event handlers' -Description 'You can specify a script block to execute when the button is clicked' -Example {
New-UDButton -Text 'Message Box' -OnClick {
    Show-UDToast -Message 'Hello, world!'
}
    }
} -Cmdlet "New-UDButton"