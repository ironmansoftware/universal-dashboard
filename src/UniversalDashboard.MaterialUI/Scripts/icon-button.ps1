function New-UDIconButton {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),

        [Parameter ()]
		[PSTypeName('MUIcon')]$Icon,

		[Parameter ()]
		[object] $OnClick, 

		[Parameter ()]
		[int] $BadgeContent,

		[Parameter ()]
		[Switch] $Badge,

        [Parameter ()]
		[Switch] $Disable, 

        [Parameter ()]
		[ValidateSet("default","primary","secondary","inherit")]
		[string] $Color  = "default",

		[Parameter ()]
		[ValidateSet("default","primary","secondary","error")]
		[string] $BadgeColor = "default"

    )

    End 
    {
        if ($null -ne $OnClick) {
            if ($OnClick -is [scriptblock]) {
                $OnClick = New-UDEndpoint -Endpoint $OnClick 
            }
            elseif ($OnClick -isnot [UniversalDashboard.Models.Endpoint]) {
                throw "OnClick must be a script block or UDEndpoint"
            }
        }

        @{
            type = 'mu-icon-button'
            isPlugin = $true
            assetId = $MUAssetId
            id = $Id
            color = $Color 
            disable = $Disable
            badge = $Badge
            badgeContent = $BadgeContent
            badgeColor = $BadgeColor
            onClick = $OnClick
            icon = $Icon
        }
    }
}