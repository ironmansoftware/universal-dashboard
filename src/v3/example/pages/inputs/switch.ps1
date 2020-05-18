New-ComponentPage -Title 'Switch' -Description 'Switches toggle the state of a single setting on or off.' -SecondDescription "Switches are the preferred way to adjust settings on mobile. The option that the switch controls, as well as the state it’s in, should be made clear from the corresponding inline label." -Content {
    New-Example -Title 'Switch' -Description '' -Example {
New-UDSwitch -Checked $true 
New-UDSwitch -Checked $true -Disabled
    }

    New-Example -Title 'OnChange Event' -Description '' -Example {
New-UDSwitch -OnChange { Show-UDToast -Message $Body }
    }

} -Cmdlet "New-UDSwitch"