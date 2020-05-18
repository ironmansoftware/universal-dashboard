New-ComponentPage -Title 'Progress' -Description 'Progress indicators commonly known as spinners, express an unspecified wait time or display the length of a process.' -SecondDescription "Progress indicators inform users about the status of ongoing processes, such as loading an app, submitting a form, or saving updates. They communicate an app’s state and indicate available actions, such as whether users can navigate away from the current screen.

Determinate indicators display how long an operation will take.

Indeterminate indicators visualize an unspecified wait time." -Content {
    New-Example -Title 'Circular Progress' -Description '' -Example {
New-UDProgress -Circular -Color Red
New-UDProgress -Circular -Color Green 
New-UDProgress -Circular -Color Blue 
New-UDProgress -Circular -Size Small
New-UDProgress -Circular -Size Medium 
New-UDProgress -Circular -Size Large
    }

    New-Example -Title 'Linear Indeterminate' -Description '' -Example {
New-UDProgress 
    }

    New-Example -Title 'Linear Determinate' -Description '' -Example {
New-UDProgress -PercentComplete 75
    }

} -Cmdlet "New-UDProgress"