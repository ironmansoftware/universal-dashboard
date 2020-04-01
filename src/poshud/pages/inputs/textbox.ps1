New-ComponentPage -Title 'Textbox' -Description 'A textbox lets users enter and edit text.' -SecondDescription "" -Content {
    New-Example -Title 'Textbox' -Description '' -Example {
        New-UDTextbox -Label 'Standard' -Placeholder 'Textbox'
        New-UDTextbox -Label 'Disabled' -Placeholder 'Textbox' -Disabled
        New-UDTextbox -Label 'Textbox' -Value 'With value'
    }

    New-Example -Title 'Password Textbox' -Description '' -Example {
        New-UDTextbox -Label 'Password' -Type password
    }

    New-Example -Title 'Retrieving a textbox value' -Description 'You can use Get-UDElement to get the value of a textbox' -Example {
        New-UDTextbox -Id 'txtExample' 
        New-UDButton -OnClick {
            $Value = (Get-UDElement -Id 'txtExample').value 
            Show-UDToast -Message $Value
        } -Text "Get textbox value"
    }
} -Cmdlet "New-UDTextbox"