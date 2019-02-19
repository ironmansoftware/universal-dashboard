function New-UDImageCarousel {
    param(
        [Parameter()]
        [ScriptBlock]$Items, 
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [Switch]$ShowIndicators,
        [Parameter()]
        [Switch]$AutoCycle,
        [Parameter()]
        [int]$Speed,
        [Parameter()]
        [string]$Width,
        [Parameter()]
        [string]$Height,
        [Parameter()]
        [Switch]$FullWidth,
        [Parameter()]
        [Switch]$FixButton,
        [Parameter()]
        [string]$ButtonText
    )

    @{
        type= 'imageCarousel'
        isPlugin = $true
        assetId = $Script:AssetId
        id = $Id
        showIndecators = $ShowIndecators
        speed = $Speed
        autoCycle = $AutoCycle
        width = $Width
        height = $Height
        fullWidth = $FullWidth
        fixButton = $FixButton
        buttonText = $ButtonText
        items = $items.Invoke()
    }
}

function New-UDImageCarouselItem {
    param(
        [Parameter()]
        [string]$Text,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$BackgroundColor,
        [Parameter()]
        [string]$BackgroudImage,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$FontColor,
        [Parameter()]
        [string]$BackgroundRepeat,
        [Parameter()]
        [string]$BackgroundSize,
        [Parameter()]
        [string]$BackgroundPosition,
        [Parameter()]
        [string]$TitlePosition,
        [Parameter()]
        [string]$TextPosition,
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [string]$Title,
        [Parameter()]
        [string]$Url
    )

    @{
        type = 'imageCarouselItem'
        isPlugin = $true
        assetId = $Script:AssetId
        text = $Text 
        backgroundColor = $BackgroundColor.HtmlColor
        fontColor = $FontColor.HtmlColor
        backgroundRepeat = $BackgroundRepeat
        backgroundSize = $BackgroundSize
        backgroundPosition = $BackgroundPosition
        titlePosition = $TitlePosition
        textPosition = $TextPosition
        id = $Id
        title = $Title
        url = $Url
    }
}