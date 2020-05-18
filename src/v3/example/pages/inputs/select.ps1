$Pages += New-ComponentPage -Title 'Select' -Description 'Select components are used for collecting user provided information from a list of options.' -SecondDescription "" -Content {
    New-Example -Title 'Simple Select' -Description '' -Example {
New-UDSelect -Option {
    New-UDSelectOption -Name 'One' -Value 1
    New-UDSelectOption -Name 'Two' -Value 2
    New-UDSelectOption -Name 'Three' -Value 3
}
    }

    New-Example -Title 'Grouped Select' -Description '' -Example {
New-UDSelect -Option {
    New-UDSelectGroup -Name 'Group One' -Option {
        New-UDSelectOption -Name 'One' -Value 1
        New-UDSelectOption -Name 'Two' -Value 2
        New-UDSelectOption -Name 'Three' -Value 3
    }
    New-UDSelectGroup -Name 'Group Two' -Option {
        New-UDSelectOption -Name 'Four' -Value 4
        New-UDSelectOption -Name 'Five' -Value 5
        New-UDSelectOption -Name 'Size' -Value 6
    }
}
    }

    New-Example -Title 'OnChange' -Description '' -Example {
New-UDSelect -Option {
    New-UDSelectOption -Name 'One' -Value 1
    New-UDSelectOption -Name 'Two' -Value 2
    New-UDSelectOption -Name 'Three' -Value 3
} -OnChange { Show-UDToast -Message $Body }
    }

} -Cmdlet "New-UDSelect"