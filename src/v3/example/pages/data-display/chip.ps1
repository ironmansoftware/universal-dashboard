New-ComponentPage -Title 'Chips' -Description 'Chips are compact elements that represent an input, attribute, or action.' -SecondDescription "Chips allow users to enter information, make selections, filter content, or trigger actions.

While included here as a standalone component, the most common use will be in some form of input, so some of the behaviour demonstrated here is not shown in context." -Content {
    New-Example -Title 'Basic Chips' -Description '' -Example {
        New-UDChip -Label 'Basic'
    }

    New-Example -Title 'With Icon' -Description '' -Example {
        New-UDChip -Label 'Basic' -Icon (New-UDIcon -Icon 'user')
    }

    New-Example -Title 'OnClick' -Description '' -Example {
        New-UDChip -Label 'OnClick' -OnClick {
            Show-UDToast -Message 'Hello!'
        }
    }

    New-Example -Title 'OnDelete' -Description '' -Example {
        New-UDChip -Label 'OnDelete' -OnClick {
            Show-UDToast -Message 'Goodbye!'
        }
    }
} -Cmdlet "New-UDChip"