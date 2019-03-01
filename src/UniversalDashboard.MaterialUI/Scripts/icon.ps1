function New-UDIcon {
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
        [string]$Color
    )

    End {
        @{
            type = "mu-icon"
            isPlugin = $true 
            assetId = $AssetId

            id = $id 
            size = $Size
            fixedWidth = $FixedWidth
            color = $Color
            listItem = $ListItem.IsPresent
            inverse = $Inverse.IsPresent
            rotation = $Rotation
            flip = $Flip
            spin = $Spin.IsPresent
            pulse = $Pulse.IsPresent
            border = $Border.IsPresent
            pull = $Pull
            className = $ClassName
            transform = $Transform
            icon = [CultureInfo]::CurrentCulture.TextInfo.ToTitleCase($Icon.ToString()).Replace("_", "-")
        }
    }
}