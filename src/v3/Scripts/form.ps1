function New-UDForm 
{
    <#
    .SYNOPSIS
    Creates a new form. 
    
    .DESCRIPTION
    Creates a new form. Forms can contain any set of input controls. Each of the controls will report its value back up to the form when the submit button is clicked. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Children
    Controls that make up this form. This can be any combination of controls. Input controls will report their state to the form. 
    
    .PARAMETER OnSubmit
    A script block that is execute when the form is submitted. You can return controls from this script block and the form will be replaced by the script block. The $EventData variable will contain a hashtable of all the input fields and their values. 
    
    .PARAMETER OnValidate
    A script block that validates the form. Return the result of a call to New-UDFormValidationResult.

    .PARAMETER OnProcessing
    A script block that is called when the form begins processing. The return value of this script block should be a component that displays a loading dialog. The script block will receive the current form data.
    
    .EXAMPLE
    Creates a form that contains many input controls and displays the $eventdata hashtable as a toast. 

    New-UDForm -Id 'defaultForm' -Content {
        New-UDTextbox -Id 'txtNameDefault' -Value 'Name'
        New-UDTextbox -Id 'txtLastNameDefault' -Value 'LastName'
        New-UDCheckbox -Id 'chkYesDefault' -Label YesOrNo -Checked $true

        New-UDSelect -Label '1-3' -Id 'selectDefault' -Option {
            New-UDSelectOption -Name "OneDefault" -Value 1
            New-UDSelectOption -Name "TwoDefault" -Value 2
            New-UDSelectOption -Name "ThreeDefault" -Value 3
        } -DefaultValue '1'

        New-UDSwitch -Id 'switchYesDefault' -Checked $true

        New-UDDatePicker -Id 'dateDateDefault' -Value '1-2-2020'

        New-UDTimePicker -Id 'timePickerDefault' -Value '10:30 AM'

        New-UDRadioGroup -Label 'group' -Id 'simpleRadioDefault' -Children {
            New-UDRadio -Value 'Adam' -Label 'Adam'  -Id 'adamDefault'
            New-UDRadio -Value 'Alon' -Label 'Alon' -Id 'alonDefault'
            New-UDRadio -Value 'Lee' -Label 'Lee' -Id 'leeDefault'
        } -Value 'Adam'
    } -OnSubmit {
        Show-UDToast -Message $Body
    }
    #>
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid().ToString(),
        [Parameter(Mandatory)]
        [ALias("Content")]
        [ScriptBlock]$Children,
        [Parameter(Mandatory)]
        [Endpoint]$OnSubmit,
        [Parameter()]
        [Endpoint]$OnValidate,
        [Parameter()]
        [ScriptBlock]$OnProcessing
    )

    if ($null -ne $OnValidate) {
       $OnValidate.Register($id + "validate", $PSCmdlet) 
    }

    $LoadingComponent = $null 
    if ($null -ne $OnProcessing) {
        $LoadingComponent = & $OnProcessing
     }

    $OnSubmit.Register($id, $PSCmdlet)

    @{
        id = $Id 
        assetId = $MUAssetId 
        isPlugin = $true 
        type = "mu-form"

        onSubmit = $OnSubmit 
        onValidate = $OnValidate
        loadingComponent = $LoadingComponent
        children = & $Children
    }
}

function New-UDFormValidationResult {
    <#
    .SYNOPSIS
    Creates a new form validation result. 
    
    .DESCRIPTION
    Creates a new form validation result. This cmdlet should return its value from the OnValidate script block parameter on New-UDForm. 
    
    .PARAMETER Valid
    Whether the form status is considered valid. 
    
    .PARAMETER ValidationError
    An error to display if the form is not valid. 
    
    .EXAMPLE
    An example
    #>
    param(
        [Parameter()]
        [Switch]$Valid,
        [Parameter()]
        [string]$ValidationError = "Form is invalid."
    )

    @{
        valid = $Valid.IsPresent
        validationError = $ValidationError
    }
}