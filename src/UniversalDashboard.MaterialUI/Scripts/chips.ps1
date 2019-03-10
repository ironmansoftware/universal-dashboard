function New-UDMuChip {
    [CmdletBinding(DefaultParameterSetName = 'Icon')]
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),

        [Parameter(Position = 0)]
		[string]$Label,

		[Parameter(Position = 8)]
		[object]$OnDelete,

        [Parameter(Position = 7)]
        [object]$OnClick,

        [Parameter (Position = 1, ParameterSetName = "Icon")]
		[PSTypeName('MUIcon')]$Icon,

		[Parameter(Position = 2)]
        [ValidateSet("default","primary","secondary")]
		[string]$Color = "default",

		[Parameter(Position = 3)]
        [ValidateSet("outlined","default")]
		[string]$Style = "default",

		[Parameter(Position = 4)]
		[Switch]$Clickable,

		[Parameter(Position = 5, ParameterSetName = "Avatar")]
		[string]$Avatar,

		[Parameter(Position = 6, ParameterSetName = "Avatar" )]
		[ValidateSet("letter","image")]
		[string]$AvatarType
    )

    End {

        if ($null -ne $OnClick) {
            if ($OnClick -is [scriptblock]) {
                $OnClick = New-UDEndpoint -Endpoint $OnClick -Id ($Id + "onClick")
            }
            elseif ($OnClick -isnot [UniversalDashboard.Models.Endpoint]) {
                throw "OnClick must be a script block or UDEndpoint"
            }
        }

        $Delete = $False
        if ($null -ne $OnDelete) {
            $Delete = $true
            if ($OnDelete -is [scriptblock]) {
                $OnDelete = New-UDEndpoint -Endpoint $OnDelete -Id ($Id + "onDelete")
            }
            elseif ($OnDelete -isnot [UniversalDashboard.Models.Endpoint]) {
                throw "OnDelete must be a script block or UDEndpoint"
            }
        }

        @{
            #This needs to match what is in the register function call of chips.jsx
            type = "mu-chip"
            #Eventually everything will be a plugin so we wont need this.
            isPlugin = $true
            #This was set in the UniversalDashboard.MaterialUI.psm1 file
            assetId = $MUAssetId

            id = $Id
            label = $Label
            icon = $Icon 
            color = $Color 
            style = $Style 
            clickable = $Clickable 
            onClick = $OnClick
            onDelete  = $OnDelete
            delete = $Delete 
            avatar = $Avatar
            avatarType = $AvatarType
        }
    }
}