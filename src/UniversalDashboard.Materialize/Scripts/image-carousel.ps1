function New-UDImageCarousel {
    param(
        [Parameter()]
		[ScriptBlock]$Items,
	    [Parameter()]
	    [string]$Id = ([Guid]::NewGuid()).ToString(),
	    [Parameter()]
	    [switch]$ShowIndicators,
	    # [Parameter()]
	    # [switch]$AutoCycle,
	    [Parameter()]
	    [switch]$FullWidth
	    # [Parameter()]
	    # [int]$Speed,
	    # [Parameter()]
	    # [string]$Width,
	    # [Parameter()]
	    # [string]$Height,
	    # [Parameter()]
	    # [switch]$FixButton,
	    # [Parameter()]
	    # [string]$ButtonText
    )

    End {
        @{
            type = "image-carousel"
            isPlugin = $true
            assetId = $AssetId

            items = $Items.Invoke()
            id = $id 
            indicators = $ShowIndicators.IsPresent
            fullWidth = $FullWidth.IsPresent
            # autoCycle = $AutoCycle.IsPresent
            # speed = $Speed
            # width = $Width
            # height = $Height
            # fixButton = $FixButton.IsPresent
            # buttonText = $ButtonText
        }
    }
}

function New-UDImageCarouselItem {
    param(
        [Parameter()]
		[hashtable]$Style,
	    [Parameter()]
	    [string]$Id = ([Guid]::NewGuid()).ToString(),
	    [Parameter()]
	    [string]$ImageSource,
	    [Parameter()]
	    [string]$Url
    )

    End {
        @{			
			# all those properties can be replace with the Style property
			# ----
            # backgroundColor = $BackgroundColor.HtmlColor
            # backgroundImage = $BackgroundImage
            # fontColor = $FontColor.HtmlColor
            # backgroundRepeat = $BackgroundRepeat
            # backgroundSize = $BackgroundSize
            # backgroundPosition = $BackgroundPosition
            # titlePosition = $TitlePosition
            # textPosition = $TextPosition
			# ----
			# style = $Style
			id = $id
            # title = $Title
			url = $Url
			imageSource = $ImageSource
        }
    }
}