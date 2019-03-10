function New-UDMuCard {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),

        [Parameter()]
        [ValidateSet("large","medium","small")]
		[string]$Size,

		[Parameter()]
		[switch]$ShowToolBar,

        [Parameter()]
        [switch]$ShowControls,

        [Parameter ()]
		[PSTypeName('MUIcon')]$Icon,

		[Parameter()]
		[string]$Title,

		[Parameter()]
		[Hashtable]$Style,

		[Parameter()]
		[int]$Elevation,

		[Parameter()]
		[scriptblock]$Content,

        [Parameter()]
		[switch]$IsEndPoint,

		[Parameter()]
		[Hashtable]$ToolbarStyle,

        [Parameter()]
		[scriptblock]$ToolbarContent,

        [Parameter()]
		[switch]$AutoRefresh,

        [Parameter()]
		[int]$RefreshInterval = 5

    )

    End {

        if($IsEndPoint){
            $CardEndPoint = New-UDEndpoint -Endpoint $Content -Id $id
        }

        if($null -eq $ToolBarContent){
            $ToolBarItems = $null
        }else{
            $ToolBarItems = $ToolBarContent.Invoke()
        }
        
        @{
            #This needs to match what is in the register function call of chips.jsx
            type = "mu-card"
            #Eventually everything will be a plugin so we wont need this.
            isPlugin = $true
            #This was set in the UniversalDashboard.MaterialUI.psm1 file
            assetId = $MUAssetId

            id = $Id
            size = $Size
            showControls = $ShowControls.IsPresent
            showToolBar = $ShowToolBar.IsPresent
            icon = $Icon
            title = $Title
            style = $Style
            elevation = $Elevation
            content = $Content.Invoke() 
            isEndpoint = $isEndPoint.IsPresent
            toolbarStyle = $ToolBarStyle
            toolbarContent = $ToolBarItems
            refreshInterval = $RefreshInterval
            autoRefresh = $AutoRefresh.IsPresent
        }
    }
}