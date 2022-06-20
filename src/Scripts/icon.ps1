$Script:FontAwesomeSolid = Get-Content -Path (Join-Path $PSScriptRoot 'fontawesome.solid.txt')
$Script:FontAwesomeRegular = Get-Content -Path (Join-Path $PSScriptRoot 'fontawesome.regular.txt')
$Script:FontAwesomeBrands = Get-Content -Path (Join-Path $PSScriptRoot 'fontawesome.brands.txt')

function Find-UDIcon {
    <#
    .SYNOPSIS
    Find an icon.
    
    .DESCRIPTION
    Find an icon.
    
    .PARAMETER Name
    The name of the icon to find. 
    
    .EXAMPLE
    Find-UDIcon -Name 'User'
    #>
    param(
        [Parameter(Mandatory)]
        $Name
    )

    $Script:FontAwesomeSolid.Where({ $_ -match $Name })
    $Script:FontAwesomeBrands.Where({ $_ -match $Name })
    $Script:FontAwesomeRegular.Where({ $_ -match $Name })
}

function New-UDIcon {
    <#
    .SYNOPSIS
    Creates a new icon.
    
    .DESCRIPTION
    Creates a new icon.
    
    .PARAMETER Id
    The ID of this component.
    
    .PARAMETER Icon
    The Icon to display. This is a FontAwesome 5 icon name. 
    
    .PARAMETER FixedWidth
    Whether to use a fixed with. 
    
    .PARAMETER Inverse
    Whether to invert the colors of the icon.
    
    .PARAMETER Rotation
    The amount of degrees to rotate the icon.
    
    .PARAMETER ClassName
    Custom CSS class names to apply to the icon.
    
    .PARAMETER Transform
    A CSS transform to apply to the icon.
    
    .PARAMETER Flip
    Whether to flip the icon.
    
    .PARAMETER Pull
    Whether to flip the icon.
    
    .PARAMETER ListItem
    
    
    .PARAMETER Spin
    Whether the icon should spin.
    
    .PARAMETER Border
    Defines the border for this icon.
    
    .PARAMETER Pulse
    Whether this icon should publse. 
    
    .PARAMETER Size
    The size of the icon.
    
    .PARAMETER Style
    A CSS style to apply to the icon.
    
    .PARAMETER Title
    
    
    .PARAMETER Regular
    
    
    .PARAMETER Color
    The color of this icon.
    
    .EXAMPLE
    Displays a user icon.

    New-UDIcon -Icon User
    #>
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter()]
        [string]$Icon, 
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
        [Alias('Pulse')]
        [switch]$Beat,
        [Parameter()]
        [switch]$Fade,
        [Parameter()]
        [switch]$Bounce,
        [Parameter()]
        [switch]$BeatFade,
        [Parameter()]
        [switch]$Shake,
        [Parameter ()]
        [ValidateSet("xs", "sm", "lg", "1x", "2x", "3x", "4x", "5x", "6x", "7x", "8x", "9x", "10x")]
        [string]$Size = "sm",
        [Parameter()]
        [Hashtable]$Style,
        [Parameter()]
        [string]$Title,
        [Parameter()]
        [switch]$Regular,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]
        $Color
    )

    End {
        if ($Icon.Contains('_')) {
            $iconName = [UniversalDashboard.Models.FontAwesomeIconsExtensions]::GetIconName($Icon)
        }
        else {
            $IconName = $Script:FontAwesomeSolid.Where({ $_ -eq $Icon })
            if (-not $IconName) {
                $IconName = $Script:FontAwesomeBrands.Where({ $_ -eq $Icon })
            }
            if (-not $IconName) {
                $IconName = $Script:FontAwesomeRegular.Where({ $_ -eq $Icon })
            }
        }

        if (-not $IconName) {
            throw "Unknown icon $Icon"
        }

        $MUIcon = @{
            type       = "icon"
            id         = $id 
            size       = $Size
            fixedWidth = $FixedWidth
            color      = $Color.HtmlColor
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
            icon       = $iconName
        }

        $MUIcon.PSTypeNames.Insert(0, "UniversalDashboard.Icon") | Out-Null

        $MUIcon
    }
}

$scriptBlock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    if ($fakeBoundParameters.ContainsKey('Regular')) {
        $Script:FontAwesomeRegular | Where-Object {
            $_ -like "$wordToComplete*"
        }
    }
    else {
        $Script:FontAwesomeSolid | Where-Object {
            $_ -like "$wordToComplete*"
        } 
        $Script:FontAwesomeBrands | Where-Object {
            $_ -like "$wordToComplete*"
        } 
    }   
}

Register-ArgumentCompleter -CommandName New-UDIcon -ParameterName Icon -ScriptBlock $scriptBlock