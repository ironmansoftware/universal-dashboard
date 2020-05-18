New-ComponentPage -Title 'Form' -Description 'Forms provide a way to collect data from users.' -SecondDescription "Forms can include any type of control you want. This allows you to customize the look and feel and use any input controls. 

Data entered via the input controls will be sent back to the the OnSubmit script block when the form is submitted. " -Content {
    New-Example -Title 'Simple Form' -Description 'Simple forms can use inputs like text boxes and checkboxes.' -Example {
New-UDForm -Content {
    New-UDTextbox -Id 'txtTextfield'
    New-UDCheckbox -Id 'chkCheckbox'
} -OnSubmit {
    Show-UDToast -Message $Body
}
    }

    New-Example -Title 'Formatting a Form' -Description 'Since forms can use any component, you can use standard formatting components within the form.' -Example {
New-UDForm -Content {

    New-UDRow -Columns {
        New-UDColumn -SmallSize 6 -LargeSize 6 -Content {
            New-UDTextbox -Id 'txtTextfield' -Label 'First Name' 
        }
        New-UDColumn -SmallSize 6 -LargeSize 6 -Content {
            New-UDTextbox -Id 'txtTextfield' -Label 'Last Name'
        }
    }

    New-UDTextbox -Id 'txtAddress' -Label 'Address'

    New-UDRow -Columns {
        New-UDColumn -SmallSize 6 -LargeSize 6  -Content {
            New-UDTextbox -Id 'txtState' -Label 'State'
        }
        New-UDColumn -SmallSize 6 -LargeSize 6  -Content {
            New-UDTextbox -Id 'txtZipCode' -Label 'ZIP Code'
        }
    }

} -OnSubmit {
    Show-UDToast -Message $Body
}
            }

New-Example -Title 'Validating a form' -Description 'Form validation can be accomplished by using the OnValidate script block parameter' -Example {
New-UDForm -Content {
    New-UDTextbox -Id 'txtValidateForm'
} -OnValidate {
    $FormContent = $Body | ConvertFrom-Json 

    if ($FormContent.txtValidateForm -eq $null -or $FormContent.txtValidateForm -eq '') {
        New-UDFormValidationResult -ValidationError "txtValidateForm is required"
    } else {
        New-UDFormValidationResult -Valid
    }
} -OnSubmit {
    Show-UDToast -Message $Body
}
}

} -Cmdlet @("New-UDForm", "New-UDFormValidationResult")