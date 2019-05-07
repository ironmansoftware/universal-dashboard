function New-UDMuIcon {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [UniversalDashboard.Models.FontAwesomeIcons]$Icon, 
        [Parameter()]
        [Switch]$FixedWidth,
        [Parameter()]
        [switch]$Inverse,
        [Parameter()]
        [int]$Rotation,
        [Parameter()]
        [string]$ClassName,
        [Parameter()]
        [string]$Transform,
        [Parameter()]
        [ValidateSet("horizontal", 'vertical', 'both')]
        [string]$Flip,
        [Parameter()]
        [ValidateSet('right', 'left')]
        [string]$Pull,
        [Parameter()]
        [switch]$ListItem,
        [Parameter()]
        [switch]$Spin,
        [Parameter()]
        [switch]$Border,
        [Parameter()]
        [switch]$Pulse,
        [Parameter ()]
        [ValidateSet("xs", "sm", "lg", "2x", "3x", "4x", "5x", "6x", "7x", "8x", "9x", "10x")]
        [string]$Size = "sm",
        [Parameter()]
        [Hashtable]$Style,
        [Parameter()]
        [string]$Title,
        [Parameter()]
        [switch]$Regular
    )

    End {
        $MUIcon = @{
            type       = "mu-icon"
            isPlugin   = $true 
            assetId    = $MUAssetId

            id         = $id 
            size       = $Size
            fixedWidth = $FixedWidth
            color      = $Color
            listItem   = $ListItem.IsPresent
            inverse    = $Inverse.IsPresent
            rotation   = $Rotation
            flip       = $Flip
            spin       = $Spin.IsPresent
            pulse      = $Pulse.IsPresent
            border     = $Border.IsPresent
            pull       = $Pull
            className  = $ClassName
            transform  = $Transform
            style      = $Style
            title      = $Title
            regular    = $Regular.IsPresent
            icon       = [CultureInfo]::CurrentCulture.TextInfo.ToTitleCase($Icon.ToString()).Replace("_", "")
        }

        $MUIcon.PSTypeNames.Insert(0, "UniversalDashboard.Icon") | Out-Null

        $MUIcon
    }
}