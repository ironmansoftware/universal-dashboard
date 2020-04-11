New-ComponentPage -Title 'Floating Action Button' -Description 'A floating action button (FAB) performs the primary, or most common, action on a screen.' -SecondDescription "A floating action button appears in front of all screen content, typically as a circular shape with an icon in its center. FABs come in two types: regular, and extended.

Only use a FAB if it is the most suitable way to present a screen’s primary action.

Only one floating action button is recommended per screen to represent the most common action." -Content {
    New-Example -Title 'Floating Action Button' -Description '' -Example {
        New-UDFloatingActionButton -Icon (New-UDIcon -Icon user) -Size Small
        New-UDFloatingActionButton -Icon (New-UDIcon -Icon user) -Size Medium
        New-UDFloatingActionButton -Icon (New-UDIcon -Icon user) -Size Large
    }

    New-Example -Title 'OnClick' -Description '' -Example {
        New-UDFloatingActionButton -Icon (New-UDIcon -Icon user) -OnClick {
            Show-UDToast -Message "Hello!"
        }
    }
} -Cmdlet "New-UDFloatingActionButton"