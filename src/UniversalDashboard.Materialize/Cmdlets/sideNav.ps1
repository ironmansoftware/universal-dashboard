function New-UDSideNav {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter(Mandatory, ParameterSetName = 'Endpoint')]
        [object]$Endpoint,
        [Parameter(Mandatory, ParameterSetName = 'Content')]
        [ScriptBlock]$Content,
        [Parameter(Mandatory, ParameterSetName = 'None')]
        [Switch]$None,
        [Parameter()]
        [Switch]$Fixed,
        [Parameter()]
        [int]$Width = 100
    )

    $control = @{
        type = 'sideNav'
        isPlugin = $true
        assetId = $Script:AssetId    
        fixed = $fixed 
        none = $None
        width = $Width
    }

    if ($PSCmdlet.ParameterSetName -eq 'Endpoint') {
        if (-not ($Endpoint -is [UniversalDashboard.Models.Endpoint])) {
            $Endpoint = New-UDEndpoint -Endpoint $Endpoint -Id $Id
        }
    }

    if ($PSCmdlet.ParameterSetName -eq 'Content') {
        $control['content'] = $Content.Invoke()
    }

    $control
}

function New-UDSideNavItem {
    param(

        [Parameter()]
        [string]$Id = (New-Guid).ToString(),

        [Parameter(Mandatory, ParameterSetName = 'Divider')]
        [Switch]$Divider,

        [Parameter(Mandatory, ParameterSetName = 'SubHeader')]
        [Switch]$SubHeader,
        [Parmaeter(Mandatory, ParmaeterSetName = 'SubHeader')]
        [ScriptBlock]$Children,
        
        [Parameter(ParameterSetName = "Url")]
        [Alias("PageName")]
        [string]$Url,

        [Parameter(ParameterSetName = "SubHeader")]
        [Parameter(ParameterSetName = "Url")]
        [Parameter(ParameterSetName = "OnClick")]
        [string]$Text,

        [Parameter(ParameterSetName = "SubHeader")]
        [Parameter(ParameterSetName = "Url")]
        [Parameter(ParameterSetName = "OnClick")]
        [UniversalDashboard.Models.FontAwesomeIcons]$Icon,

        [Parameter(ParameterSetName = "OnClick")]
        [object]$OnClick
    )

    if ($PSCmdlet.ParameterSetName -eq 'OnClick') {
        if (-not ($OnClick -is [UniversalDashboard.Models.Endpoint])) {
            $OnClick = New-UDEndpoint -Endpoint $OnClick -Id $Id
        }
    }

    @{
        type = 'sideNavItem'
        isPlugin = $true
        assetId = $Script:AssetId
        divider = $Divider
        subHeader = $SubHeader
        text = $Text 
        url = $Url
        icon = $Icon.ToString().Replace("_", "-")
        id = $Id
        children = $Children.Invoke()
    }
}