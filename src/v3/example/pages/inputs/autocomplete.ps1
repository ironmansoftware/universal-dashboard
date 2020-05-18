New-ComponentPage -Title 'Autocomplete' `
-Description 'The autocomplete is a normal text input enhanced by a panel of suggested options.' `
-SecondDescription "This is a useful control for allowing the user to select from a large set of options." -Content {

New-Example -Title 'Autocomplete with a static list of options' -Example {
    New-UDAutocomplete -Options @('Test', 'Test2', 'Test3', 'Test4') 
}

New-Example -Title 'Autocomplete with a dynamic list of options' -Example {
    New-UDAutocomplete -OnLoadOptions { 
        @('Test', 'Test2', 'Test3', 'Test4') | Where-Object { $_ -match $Body } | ConvertTo-Json
    }
}

New-Example -Title 'Autocomplete with an OnChange script block' -Example {
    New-UDAutocomplete -OnLoadOptions { 
        @('Test', 'Test2', 'Test3', 'Test4') | Where-Object { $_ -match $Body } | ConvertTo-Json
    } -OnChange {
        Show-UDToast $Body 
    }
}

} -Cmdlet 'New-UDAutocomplete'