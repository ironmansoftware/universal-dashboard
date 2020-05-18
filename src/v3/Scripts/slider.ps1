function New-UDSlider {
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
        [string]$ValueLabelDisplay = 'auto'
    )

    if ($OnChange) {
        $OnChange.Register($Id, $PSCmdlet)
    }

    if (-not $PSCmdlet.MyInvocation.BoundParameters.ContainsKey("Value"))
    {
        $Value = $Minimum
    }

    if ($Value -lt $Minimum) 
    {
        throw "Value cannot be less than minimum"
    }

    if ($Value -gt $Maximum) 
    {
        throw "Value cannot be more than maximum"
    }

    $Val = $Value 
    if ($Value.Length -eq 1)
    {
        $Val = $Value | Select-Object -First 1
    }

    @{
        type = 'mu-slider'
        isPlugin = $true 
        assetId = $MUAssetId 
        id = $Id 

        value = $val 
        min = $Minimum
        max = $Maximum
        disabled = $Disabled.IsPresent
        marks = $Marks.IsPresent
        onChange = $OnChange 
        orientation = $Orientation 
        step = $Step
        valueLabelDisplay = $ValueLabelDisplay
    }
}