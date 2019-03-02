function New-UDList {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),

        [Parameter ()]
		[scriptblock]$Content
    )
    End
    {
        @{
            type = 'mu-list'
            isPlugin = $true
            assetId = $MUAssetId
            id = $Id
            content = $Content.Invoke()
        }
    }
}


function New-UDListItem {
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
		[scriptblock] $SecondaryAction

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

        if($null -ne $SecondaryAction){
            $Action = $SecondaryAction.Invoke()
        }else{
            $Action = $null
        }

        if($null -ne $Content){
            $ItemContent = $Content.Invoke()
        }else{
            $ItemContent = $null
        }

        @{
            type = 'mu-list-item'
            isPlugin = $true
            assetId = $MUAssetId
            id = $Id
            subTitle = $SubTitle
            label = $Label
            onClick = $OnClick
            content = $ItemContent
            secondaryAction = $Action
            icon = $Icon
            isButton = $IsButton
        }
    }
}