function New-UDCounter {
    param(
		[Parameter()]
		[string]$Title,
		[Parameter()]
		[string]$Format = "0,0",
		[Parameter()]
		[UniversalDashboard.FontAwesomeIcons]$Icon,
		[Parameter()]
		[DashboardColor]$BackgroundColor,
		[Parameter()]
		[DashboardColor]$FontColor,
	    [Parameter()]
	    [Hashtable[]]$Links,
        [Parameter()]
        [ValidateSet('small', 'medium', 'large')]
		[string]$TextSize = 'small',
		[Parameter('left', 'center', 'right')]
		[string]$TextAlignment = 'left',
		[Parameter()]
        [object]OnClick,
        [Parameter()]
        [Switch]$AutoRefresh,
        [Parameter()]
        [int]$RefreshInterval = 30
    )

    End {

        if ($null -ne $OnClick) {
            if ($OnClick -is [scriptblock]) {
                $OnClick = New-UDEndpoint -Endpoint $OnClick -Id ($Id + "OnClick")
            }
            elseif ($OnClick -isnot [UniversalDashboard.Models.Endpoint]) {
                throw "OnClick must be a script block or UDEndpoint"
            }
        }

        @{
            type = 'ud-counter'
            isPlugin = $true 
            assetId = $AssetId

            id = $Id
        }
    }
}