function New-UDSlider {
    <#
    .SYNOPSIS
    A slider component.
    
    .DESCRIPTION
    A slider component. Sliders can be used to define values within a range or selecting a range of values. You can use this component with New-UDForm.
    
    .PARAMETER Id
    The ID of this component.
    
    .PARAMETER Value
    The value of the slider.
    
    .PARAMETER Minimum
    The minimum value of the slider.
    
    .PARAMETER Maximum
    The maximum value of the slider.
    
    .PARAMETER Disabled
    Whether the slider is disabled.
    
    .PARAMETER Marks
    Whether to display marks on the slider.
    
    .PARAMETER OnChange
    A script block that is invoked when the slider value changes. You can access the slider value within the script block by referencing the $EventData variable.
    
    .PARAMETER Orientation
    The orientation of the slider.
    
    .PARAMETER Step
    Step size of the slider. 
    
    .PARAMETER ValueLabelDisplay
    Whether to display value labels.
    
    .EXAMPLE
    An example

    New-UDSlider 
    
    .NOTES
    General notes
    #>
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        [int[]]$Value = 0, 
        [Parameter()]
        [int]$Minimum = 0, 
        [Parameter()]
        [int]$Maximum = 100,
        [Parameter()]
        [Switch]$Disabled, 
        [Parameter()]
        [Switch]$Marks, 
        [Parameter()]
        [Endpoint]$OnChange,
        [Parameter()]
        [ValidateSet('horizontal', 'vertical')]
        [string]$Orientation = 'horizontal',
        [Parameter()]
        [int]$Step = 1,
        [Parameter()]
        [ValidateSet('on', 'auto', 'off')]
        [string]$ValueLabelDisplay = 'auto',
        [Parameter()]
        [string]$ClassName,
        [Parameter()]
        [ValidateSet("primary", 'secondary')]
        [string]$Color = 'primary'
    )

    if ($OnChange) {
        $OnChange.Register($Id, $PSCmdlet)
    }

    if (-not $PSCmdlet.MyInvocation.BoundParameters.ContainsKey("Value")) {
        $Value = $Minimum
    }

    if ($Value -lt $Minimum) {
        throw "Value cannot be less than minimum"
    }

    if ($Value -gt $Maximum) {
        throw "Value cannot be more than maximum"
    }

    $Val = $Value 
    if ($Value.Length -eq 1) {
        $Val = $Value | Select-Object -First 1
    }

    @{
        type              = 'mu-slider'
        isPlugin          = $true 
        assetId           = $MUAssetId 
        id                = $Id 

        value             = $val 
        min               = $Minimum
        max               = $Maximum
        disabled          = $Disabled.IsPresent
        marks             = $Marks.IsPresent
        onChange          = $OnChange 
        orientation       = $Orientation 
        step              = $Step
        valueLabelDisplay = $ValueLabelDisplay
        className         = $ClassName
        color             = $Color.ToLower()
    }
}