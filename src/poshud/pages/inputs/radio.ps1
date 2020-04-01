New-ComponentPage -Title 'Radio' -Description 'Radio buttons allow the user to select one option from a set.' -SecondDescription "Use radio buttons when the user needs to see all available options. If available options can be collapsed, consider using a dropdown menu because it uses less space.

Radio buttons should have the most commonly used option selected by default." -Content {
    New-Example -Title 'Simple Radio' -Description '' -Example {
New-UDRadioGroup -Label "Day" -Content {
    New-UDRadio -Label Monday -Value 'monday'
    New-UDRadio -Label Tuesday -Value 'tuesday'
    New-UDRadio -Label Wednesday -Value 'wednesday'
    New-UDRadio -Label Thursday -Value 'thursday'
    New-UDRadio -Label Friday  -Value 'friday'
    New-UDRadio -Label Saturday -Value 'saturday'
    New-UDRadio -Label Sunday -Value 'sunday'
}
    }

    New-Example -Title 'OnChange' -Description '' -Example {
New-UDRadioGroup -Label "Day" -Content {
    New-UDRadio -Label Monday -Value 'monday'
    New-UDRadio -Label Tuesday -Value 'tuesday'
    New-UDRadio -Label Wednesday -Value 'wednesday'
    New-UDRadio -Label Thursday -Value 'thursday'
    New-UDRadio -Label Friday  -Value 'friday'
    New-UDRadio -Label Saturday -Value 'saturday'
    New-UDRadio -Label Sunday -Value 'sunday'
} -OnChange { Show-UDToast -Message $Body }
    }
} -Cmdlet "New-UDRadio"