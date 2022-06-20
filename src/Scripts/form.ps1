function New-UDForm {
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

    .PARAMETER OnCancel
    A script block that is called when a form is cancelled. Useful for closing forms in modals.

    .PARAMETER SubmitText
    Text to show within the submit button

    .PARAMETER CancelText
    Text to show within the cancel button.

    .PARAMETER ButtonVariant
    Type of button to display.

    
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
        [Parameter(Mandatory, ParameterSetName = 'form')]
        [ALias("Content")]
        [ScriptBlock]$Children,
        [Parameter(Mandatory, ParameterSetName = 'form')]
        [Parameter(Mandatory, ParameterSetName = 'schema')]
        [Endpoint]$OnSubmit,
        [Parameter(ParameterSetName = 'form')]
        [Endpoint]$OnValidate,
        [Parameter(ParameterSetName = 'form')]
        [ScriptBlock]$OnProcessing,
        [Parameter(ParameterSetName = 'form')]
        [Endpoint]$OnCancel,
        [Parameter(ParameterSetName = 'form')]
        [string]$SubmitText = 'Submit',
        [Parameter(ParameterSetName = 'form')]
        [string]$CancelText = 'Cancel',
        [ValidateSet('text', 'contained', 'outlined')]
        [string]$ButtonVariant = 'text',
        [Parameter(ParameterSetName = 'form')]
        [string]$ClassName,
        [Parameter(Mandatory = $true, ParameterSetName = 'schema')]
        [Hashtable]$Schema,
        [Parameter()]
        [switch]$DisableSubmitOnEnter
    )

    if ($null -ne $OnValidate) {
        $OnValidate.Register($id + "validate", $PSCmdlet) 
    }

    $LoadingComponent = $null 
    if ($null -ne $OnProcessing) {
        $LoadingComponent = New-UDErrorBoundary -Content $OnProcessing
    }

    if ($OnCancel) {
        $OnCancel.Register($id + 'cancel', $PSCmdlet)
    }

    $OnSubmit.Register($id, $PSCmdlet)

    try {
        $c = New-UDErrorBoundary -Content $Children 
    }
    catch {
        $c = New-UDError -Message $_
    }

    if ($PSCmdlet.ParameterSetName -eq 'schema') {
        @{
            id       = $Id 
            assetId  = $MUAssetId 
            isPlugin = $true 
            type     = "mu-schema-form"
    
            onSubmit = $OnSubmit 
            schema   = $Schema
        }
    } 
    else 
    {
        @{
            id                   = $Id 
            assetId              = $MUAssetId 
            isPlugin             = $true 
            type                 = "mu-form"

            onSubmit             = $OnSubmit 
            onValidate           = $OnValidate
            loadingComponent     = $LoadingComponent
            children             = $c
            onCancel             = $OnCancel
            cancelText           = $CancelText
            submitText           = $SubmitText
            buttonVariant        = $ButtonVariant 
            className            = $ClassName
            disableSubmitOnEnter = $DisableSubmitOnEnter.IsPresent
        }
    }
}

New-Alias -Name 'New-UDFormValidationResult' -Value 'New-UDValidationResult'

function New-UDValidationResult {
    <#
    .SYNOPSIS
    Creates a new validation result. 
    
    .DESCRIPTION
    Creates a new validation result. This cmdlet should return its value from the OnValidate script block parameter on New-UDForm or New-UDStepper. 
    
    .PARAMETER Valid
    Whether the status is considered valid. 
    
    .PARAMETER ValidationError
    An error to display if the is not valid. 

    .PARAMETER Context
    Update the context based on validation. This is only used for New-UDStepper.

    .PARAMETER DisablePrevious
    Disables the previous button. This is only used for New-UDStepper.

    .PARAMETER ActiveStep
    Sets the active step. This is only used for New-UDStepper.

    #>
    param(
        [Parameter()]
        [Switch]$Valid,
        [Parameter()]
        [string]$ValidationError = "Form is invalid.",
        [Parameter()]
        [HashTable]$Context,
        [Parameter()]
        [Switch]$DisablePrevious,
        [Parameter()]
        [int]$ActiveStep = -1
    )

    @{
        valid           = $Valid.IsPresent
        validationError = $ValidationError
        context         = $Context 
        disablePrevious = $DisablePrevious.IsPresent
        activeStep      = $ActiveStep
    }
}

function Test-UDForm {
    <#
    .SYNOPSIS
    Invokes validation for a form.
    
    .DESCRIPTION
    Invokes validation for a form.
    
    .PARAMETER Id
    Id of the form to invoke validation for.
    
    .EXAMPLE
    New-UDButton -Text 'Validate' -OnClick {
        Test-UDForm -Id 'myForm'
    }
    #>
    param(
        [Parameter(Mandatory)]
        [string]$Id
    )

    $DashboardHub.SendWebSocketMessage($ConnectionId, "testForm", $Id)
}

function Invoke-UDForm {
    <#
    .SYNOPSIS
    Invokes a form.
    
    .DESCRIPTION
    Invokes a form and optionally validates it. 
    
    .PARAMETER Id
    The ID of the form to invoke.
    
    .PARAMETER Validate
    Whether to run form validation.
    
    .EXAMPLE
    Invoke-UDForm -Id "MyForm" -Validate
    #>
    param(
        [Parameter(Mandatory)]
        [string]$Id,
        [Parameter()]
        [Switch]$Validate
    )

    $Data = @{
        method   = "invokeForm"
        id       = $Id 
        validate = $Validate.IsPresent
    }

    $DashboardHub.SendWebSocketMessage($ConnectionId, "invokeMethod", $Data)
}