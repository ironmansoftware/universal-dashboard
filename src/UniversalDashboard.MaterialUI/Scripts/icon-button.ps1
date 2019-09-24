function New-UDIconButton {
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter ()]
		[PSTypeName('UniversalDashboard.Icon')]$Icon,
		[Parameter ()]
		[object] $OnClick, 
        [Parameter ()]
		[Switch] $Disable, 
        [Parameter ()]
		[string] $Href, 
        [Parameter ()]
		[Hashtable] $Style


    )

    End 
    {
        if ($null -ne $OnClick) {
            if ($OnClick -is [scriptblock]) {
                $OnClick =  New-UDEndpoint -Endpoint $OnClick -Id ($Id + "onClick")
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
            disable = $Disable
            style = $Style
            onClick = $OnClick
            icon = $Icon
            href = $Href
        }
    }
}