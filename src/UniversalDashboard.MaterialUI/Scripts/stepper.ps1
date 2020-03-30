function New-UDStepper {
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
    )

    $OnFinish.Register($Id + "onFinish", $PSCmdlet)

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
    }
}

function New-UDStep {
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Alias("Content")]
        [Parameter(Mandatory)]
        [Endpoint]$OnLoad,
        [Parameter()]
        [string]$Label,
        [Parameter()]
        [Switch]$Optional,
        [Parameter()]
        [Endpoint]$OnComplete,
        [Parameter()]
        [Endpoint]$OnValidate
    )

    $OnLoad.Register($Id + "onLoad", $PSCmdlet)

    if ($OnComplete) {
        $OnComplete.Register($Id + "onComplete", $PSCmdlet)
    }

    if ($OnValidate) {
        $OnValidate.Register($Id + "onValidate", $PSCmdlet)
    }

    @{
        id = $id 
        isPlugin = $true 
        type = 'mu-stepper-step'
        assetId = $MUAssetId 

        onLoad = $OnLoad
        label = $Label
        optional = $Optional.IsPresent 
        onValidate = $OnValidate 
        onComplete = $OnComplete
    }
}

