function New-UDCheckBox {
    param
    (
        [Parameter (Position = 0)]
        [string]$Label,

        [Parameter (Position = 1)]
        [PSTypeName('UniversalDashboard.Icon')]$Icon,

        [Parameter (Position = 2)]
        [PSTypeName('UniversalDashboard.Icon')]$CheckedIcon,

        [Parameter (Position = 3)]
        [Endpoint]$OnChange,

        [Parameter (Position = 4)]
        [Hashtable]$Style,

        [Parameter (Position = 5)]
        [switch]$Disabled,

        [Parameter (Position = 6)]
        [switch]$Checked,

        [Parameter (Position = 7)]
        [string]$ClassName,

        [Parameter (Position = 7)]
        [ValidateSet("top","start","bottom","end")]
        [string]$LabelPlacement,

        [Parameter(Position = 8)]
        [string]$Id = ([Guid]::NewGuid()).ToString()

    )

    End {

        if ($OnChange)
        {
            $OnChange.Register($Id + "onChange", $PSCmdlet)
        }

        @{
            # Mandatory properties to load as plugin.
            type        = 'mu-checkbox'
            isPlugin    = $true
            assetId     = $MUAssetId

            # Command properties.
            id          = $Id
            className   = $ClassName
            checked     = $Checked.IsPresent
            onChange    = $OnChange
            icon        = $Icon
            checkedIcon = $CheckedIcon
            disabled    = $Disabled.IsPresent
            style       = $Style
            label       = $Label
            labelPlacement = $LabelPlacement
        }

    }
}