New-ComponentPage -Title 'Date Picker' -Description 'Date pickers pickers provide a simple way to select a single value from a pre-determined set.' -SecondDescription "" -Content {
    New-Example -Title 'Date Picker' -Description '' -Example {
        New-UDDatePicker 
    }
} -Cmdlet "New-UDDatePicker"
