function New-UDStepper {
    <#
    .SYNOPSIS
    Creates a new stepper component.
    
    .DESCRIPTION
    Creates a new stepper component. Steppers can be used as multi-step forms or to display information in a stepped manner.
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER ActiveStep
    Sets the active step. This should be the index of the step. 
    
    .PARAMETER Children
    The steps for this stepper. Use New-UDStep to create new steps. 
    
    .PARAMETER NonLinear
    Allows the user to progress to steps out of order. 
    
    .PARAMETER AlternativeLabel
    Places the step label under the step number. 
    
    .PARAMETER OnFinish
    A script block that is executed when the stepper is finished. 
    
    .EXAMPLE
    Creates a stepper that reports the stepper context with each step. 

    New-UDStepper -Id 'stepper' -Steps {
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

    #>
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        [int]$ActiveStep = 0,
        [Alias("Steps")]
        [Parameter(Mandatory)]
        [ScriptBlock]$Children,
        [Parameter()]
        [Switch]$NonLinear,
        [Parameter()]
        [Switch]$AlternativeLabel,
        [Parameter(Mandatory)]
        [Endpoint]$OnFinish
        # [Parameter()]
        # [Endpoint]$OnCompleteStep,
        # [Parameter()]
        # [Endpoint]$OnValidateStep
    )

    $OnFinish.Register($Id + "onFinish", $PSCmdlet)

    if ($OnCompleteStep) {
        $OnCompleteStep.Register($Id + "onComplete", $PSCmdlet)
    }

    if ($OnValidateStep) {
        $OnValidateStep.Register($Id + "onValidate", $PSCmdlet)
    }


    @{
        id = $id 
        isPlugin = $true 
        type = 'mu-stepper'
        assetId = $MUAssetId 

        children = & $Children
        nonLinear = $NonLinear.IsPresent 
        alternativeLabel = $AlternativeLabel.IsPresent
        onFinish = $OnFinish
        activeStep = $ActiveStep
        onValidateStep = $OnValidateStep 
        onCompleteStep = $OnCompleteStep
    }
}

function New-UDStep {
    <#
    .SYNOPSIS
    Creates a new step for a stepper. 
    
    .DESCRIPTION
    Creates a new step for a stepper. Add to the Children (alias Steps) parameter for New-UDStepper. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER OnLoad
    The script block that is executed when the step is loaded. The script block will receive the $Body parameter which contains JSON for the current state of the stepper. If you are using form controls, their data will be availalble in the $Body.Context property. 
    
    .PARAMETER Label
    A label for this step. 
    
    .PARAMETER Optional
    Whether this step is optional.
    
    .EXAMPLE
    Creates a stepper that reports the stepper context with each step. 

    New-UDStepper -Id 'stepper' -Steps {
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
    
    #>
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Alias("Content")]
        [Parameter(Mandatory)]
        [Endpoint]$OnLoad,
        [Parameter()]
        [string]$Label,
        [Parameter()]
        [Switch]$Optional
    )

    $OnLoad.Register($Id + "onLoad", $PSCmdlet)

    @{
        id = $id 
        isPlugin = $true 
        type = 'mu-stepper-step'
        assetId = $MUAssetId 

        onLoad = $OnLoad
        label = $Label
        optional = $Optional.IsPresent 
    }
}

