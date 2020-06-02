function New-UDSideNav {
    param(
        [Parameter(ParameterSetName = "Endpoint", Mandatory = $true)]
        [Endpoint]$Endpoint, 
        [Parameter(ParameterSetName = "Content", Mandatory = $true)]
        [ScriptBlock]$Content,
        [Parameter(ParameterSetName = "None", Mandatory = $true)]
        [Switch]$None,
        [Parameter()]
        [Switch]$Fixed,
        [Parameter()]
        [int]$Width = 300
    )

    [array]$c = @()
    if ($Content) { 
        try 
        {
            [array]$c = & $Content 
        }
        catch 
        {
            [array]$c = @(New-UDError -Message $_)
        }
    }

    @{
        content = $c
        none = $None.IsPresent
        fixed = $Fixed.IsPresent
        width = $Width 
        type = 'side-nav'
    }
}

function New-UDSideNavItem {
    param( 
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),

        [Parameter(ParameterSetName = "Divider")]
        [Switch]$Divider,

        [Parameter(ParameterSetName = "SubHeader")]
        [Switch]$SubHeader,

        [Parameter(ParameterSetName = "SubHeader")]
        [ScriptBlock]$Children,

        [Parameter(ParameterSetName = "Url")]
        [Alias("PageName")]
        [string]$Url,

        [Parameter()]
        [string]$Image,
        [Parameter()]
        [string]$Background,

        [Parameter(ParameterSetName = "SubHeader")]
        [Parameter(ParameterSetName = "Url")]
        [Parameter(ParameterSetName = "OnClick")]
        [string]$Text,

        [Parameter(ParameterSetName = "SubHeader")]
        [Parameter(ParameterSetName = "Url")]
        [Parameter(ParameterSetName = "OnClick")]
        [string]$Icon,

        [Parameter(ParameterSetName = "OnClick")]
        [Endpoint]$OnClick
    )

    [array]$c = @()
    if ($Children) { 
        try {
            [array]$c = & $Children;      
        }
        catch {
            [array]$c = @(New-UDError -Message $_)
        }
        
    }

    if ($OnClick) {
        $OnClick.Register($Id + "onClick", $PSCmdlet) | Out-Null
    }

    @{
        id = $Id
        divider = $Divider.IsPresent
        subHeader = $subHeader.IsPresent
        children = $c
        text = $Text
        image = $Image
        background = $Background
        url = $Url
        icon = $Icon 
        type = "side-nav-item"
        hasCallback = $null -ne $OnClick
    }
}