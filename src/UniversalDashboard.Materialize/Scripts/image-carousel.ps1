function New-UDImageCarousel {
    param(
        [Parameter()]
		[ScriptBlock]$Items,
	    [Parameter()]
	    [string]$Id = (New-Guid).ToString(),
	    [Parameter()]
	    [switch]$ShowIndicators,
	    [Parameter()]
	    [switch]$AutoCycle,
	    [Parameter()]
	    [int]$Speed,
	    [Parameter()]
	    [string]$Width,
	    [Parameter()]
	    [string]$Height,
	    [Parameter()]
	    [switch]$FullWidth,
	    [Parameter()]
	    [switch]$FixButton,
	    [Parameter()]
	    [string]$ButtonText
    )

    End {
        @{
            type = "image-carousel"
            isPlugin = $true
            assetId = $AssetId

            items = $Items.Invoke()
            id = $id 
            showIndicators = $ShowIndicators.IsPresent
            autoCycle = $AutoCycle.IsPresent
            speed = $Speed
            width = $Width
            height = $Height
            fullWidth = $FullWidth.IsPresent
            fixButton = $FixButton.IsPresent
            buttonText = $ButtonText
        }
    }
}

function New-UDImageCarouselItem {
    param(
        [Parameter()]
		[string]$Text,
	    [Parameter()]
	    [UniversalDashboard.Models.DashboardColor]$BackgroundColor = "#000",
	    [Parameter()]
	    [string]$BackgroundImage,
	    [Parameter()]
	    [UniversalDashboard.Models.DashboardColor]$FontColor = "#fff",
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

    End {
        @{
            text = $Text 
            backgroundColor = $BackgroundColor.HtmlColor
            backgroundImage = $BackgroundImage
            fontColor = $FontColor.HtmlColor
            backgroundRepeat = $BackgroundRepeat
            backgroundSize = $BackgroundSize
            backgroundPosition = $BackgroundPosition
            titlePosition = $TitlePosition
            textPosition = $TextPosition
            id = $id
            title = $Title
            url = $Url
        }
    }
}