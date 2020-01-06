function New-UDImageCarousel {
	param(
		[Parameter()]
		[ScriptBlock]$Items,
		[Parameter()]
		[string]$Id = ([Guid]::NewGuid()).ToString(),
		[Parameter()]
		[alias("ShowIndicators")] 
		[switch]$Indicators,
		[Parameter()]
		[alias("FullWidth")]
		[switch]$FullScreen,
		[Parameter()]
		[alias("Speed")]
		[int]$Interval = 6000,
		[Parameter()]
		[int]$Duration = 500,
		[Parameter()]
		[int]$Height = 400
	)

	End {

		$Options = @{
			duration   = $Duration
			height     = $Height 
			interval   = $Interval
			indicators = $Indicators.IsPresent
		}

		@{
			type       = "image-carousel"
			isPlugin   = $true
			assetId    = $AssetId
			items      = $Items.Invoke()
			id         = $id 
			fullscreen = $FullScreen.IsPresent
			options    = $Options
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
		[alias("BackgroundImage")]
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
			style       = $Style
			id          = $id
			url         = $Url
			imageSource = $ImageSource
		}
	}
}