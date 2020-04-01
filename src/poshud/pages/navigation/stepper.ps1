New-ComponentPage -Title 'Stepper' -Description 'Steppers convey progress through numbered steps. It provides a wizard-like workflow.' -SecondDescription "Steppers display progress through a sequence of logical and numbered steps. They may also be used for navigation. Steppers may display a transient feedback message after a step is saved." -Content {
    New-Example -Title 'Stepper' -Description '' -Example {
New-UDStepper -Steps {
    New-UDStep -OnLoad {
        New-UDElement -tag 'div' -Content { "Step 1" }
        New-UDTextbox -Id 'txtStep1' 
    } -Label "Step 1"
    New-UDStep -OnLoad {
        New-UDElement -tag 'div' -Content { "Step 2" }
        New-UDElement -tag 'div' -Content { "Previous data: $Body" }
        New-UDTextbox -Id 'txtStep2' 
    } -Label "Step 2"
    New-UDStep -OnLoad {
        New-UDElement -tag 'div' -Content { "Step 3" }
        New-UDElement -tag 'div' -Content { "Previous data: $Body" }
        New-UDTextbox -Id 'txtStep3' 
    } -Label "Step 3"
} -OnFinish {
    New-UDTypography -Text 'Nice! You did it!' -Variant h3
    New-UDElement -Tag 'div' -Id 'result' -Content {$Body}
}
    }

} -Cmdlet @("New-UDStepper", "New-UDStep")