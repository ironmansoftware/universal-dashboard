
function New-UDExpandListItem {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),

        [Parameter ()]
		[PSTypeName('MUIcon')]$Icon,

		[Parameter ()]
		[object] $OnClick, 

        [Parameter ()]
		[switch] $IsButton, 

        [Parameter ()]
		[string] $Label, 

        [Parameter ()]
		[scriptblock] $Content, 

        [Parameter ()]
		[string] $SubTitle,

        [Parameter ()]
		[scriptblock] $SecondaryAction,

        # [Parameter ()]
        # [switch] $Divider,

        [Parameter ()]
		[Hashtable]$Style


    )

    End 
    {
        if ($null -ne $OnClick) {
            if ($OnClick -is [scriptblock]) {
                $OnClick = [UniversalDashboard.Models.Endpoint]::new($OnClick)
            }
            elseif ($OnClick -isnot [UniversalDashboard.Models.Endpoint]) {
                throw "OnClick must be a script block or UDEndpoint"
            }
        }

        if($null -ne $SecondaryAction){
            $Action = $SecondaryAction.Invoke()
        }else{
            $Action = $null
        }

        @{
            type = 'mu-expand-list-item'
            isPlugin = $true
            assetId = $MUAssetId
            id = $Id
            subTitle = $SubTitle
            label = $Label
            onClick = $OnClick
            content = $Content.Invoke()
            secondaryAction = $Action
            icon = $Icon
            isButton = $IsButton
            # divider = $Divider
            style = $Style
        }
    }
}