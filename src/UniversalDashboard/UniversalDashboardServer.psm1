function Find-Object {
    param(
        [Parameter(ValueFromPipeline=$true, Mandatory)]
        $InputObject,
        [Parameter(Mandatory)]
        $FilterText
        )

        Process {
            $results = $InputObject.psobject.Properties | Where { $InputObject.($_.Name) -match $FilterText }

            if ($results.length -gt 0) {
                $InputObject
            }

        }
}

function Set-UDSessionData {
	param(
		[Parameter(Mandatory = $true)]
		[String]$Key,
		[Parameter(Mandatory = $true)]
		[String]$Value
	)

	if ($Session -eq $null) {
		Write-Error "Session variable is not available"
	} else {
		$bytes = [System.Text.Encoding]::UTF8.GetBytes($Value)
		$Session.Set($Key, $bytes)
	}
}

function Get-UDSessionData {
	param(
		[Parameter(Mandatory = $true)]
		[String]$Key
	)

	if ($Session -eq $null) {
		Write-Error "Session variable is not available"
	} else {
		$bytes = $null
		if ($Session.TryGetValue($Key, [ref]$bytes)) {
			[System.Text.Encoding]::UTF8.GetString($bytes)
		}
	}
}

function New-UDLayout {
	param(
		[Parameter()]
		$ColumnSize = 12,
		[Parameter()]
		$Content
	)
}
function Write-UDLog {
	param(
		[Parameter(Mandatory = $true, Position = 0)]
		[String]$Message,
		[Parameter()]
		[ValidateSet("Debug", "Info", "Warning", "Error")]
		[String]$Level = "Info",
		[Parameter()]
		[String]$LoggerName = "Endpoint"
	)

	$Log = [NLog.LogManager]::GetLogger($LoggerName)

	switch ($Level) {
		"Debug" { $Log.Debug($Message) }
		"Info" { $Log.Info($Message) }
		"Warning" { $Log.Warn($Message) }
		"Error" { $Log.Error($Message) }
	}
}

function Out-UDMonitorData {
	[CmdletBinding()]
    param(
	[Parameter(ValueFromPipeline = $true)]
	$Data)

	Begin {
		New-Variable -Name Items -Value @()
	}

	Process {
		$Items += $Data
	}

	End {
		$Timestamp = [DateTime]::UtcNow
		$dataSets = @()
		foreach($item in $Items) {
			$dataSets += @{
				x = $Timestamp
				y = $item
			}
		}
		$dataSets | ConvertTo-Json
	}
}

function Out-UDChartData {
	[CmdletBinding()]
    param(
		[Parameter(ValueFromPipeline = $true)]
		$Data,
		[Parameter()]
		[string]$DataProperty,
		[Parameter()]
		[string]$LabelProperty,
		[Parameter()]
		[string]$DatasetLabel = "",
		[Parameter()]
		[Hashtable[]]$Dataset,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$BackgroundColor = @("#808978FF"),
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$BorderColor = @("#FF8978FF"),
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$HoverBackgroundColor = @("#807B210C"),
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$HoverBorderColor = @("#FF7B210C")
	)

    Begin {
        New-Variable -Name Items -Value @()
    }

	Process {
		$Items += $Data
	}

	End {
		$datasets = @()

		if ($Dataset -ne $null) {
			Foreach($datasetDef in $Dataset) {
				$datasetDef.data = @($Items | ForEach-Object { $_.($datasetDef.DataProperty) })
				$datasets += $datasetDef
			}
		}
		else {
			$datasets +=
				@{
					label = $DatasetLabel
					backgroundColor = $BackgroundColor.HtmlColor
					borderColor = $BorderColor.HtmlColor
					hoverBackgroundColor = $HoverBackgroundColor.HtmlColor
					hoverBorderColor = $HoverBorderColor.HtmlColor
					borderWidth = 1
					data = @($Items | ForEach-Object { $_.$DataProperty })
				}
		}

	    @{
			labels = @($Items | ForEach-Object { $_.$LabelProperty })
			datasets = $datasets
		} | ConvertTo-Json -Depth 10
	}
}

function New-UDChartDataset {
	[CmdletBinding()]
	param(
		[string]$DataProperty,
		[string]$Label,
		[UniversalDashboard.Models.DashboardColor[]]$BackgroundColor = @("#807B210C"),
		[UniversalDashboard.Models.DashboardColor[]]$BorderColor = @("#FF7B210C"),
		[int]$BorderWidth,
		[UniversalDashboard.Models.DashboardColor[]]$HoverBackgroundColor = @("#807B210C"),
		[UniversalDashboard.Models.DashboardColor[]]$HoverBorderColor = @("#FF7B210C"),
		[int]$HoverBorderWidth,
		[string]$XAxisId,
		[string]$YAxisId,
		[Hashtable]$AdditionalOptions
	)

	Begin {
		$datasetOptions = @{
			data = @()
			DataProperty = $DataProperty
			label = $Label
			backgroundColor = $BackgroundColor.HtmlColor
			borderColor = $BorderColor.HtmlColor
			borderWidth = $BorderWidth
			hoverBackgroundColor = $HoverBackgroundColor.HtmlColor
			hoverBorderColor = $HoverBorderColor.HtmlColor
			hoverBorderWidth = $HoverBorderWidth
			xAxisId = $XAxisId
			yAxisId = $YAxisId
		}

		if ($AdditionalOptions) {
			$AdditionalOptions.GetEnumerator() | ForEach-Object {
				$datasetOptions.($_.Key) = $_.Value
			}
		}

		$datasetOptions
	}
}

function Out-UDGridData {
	[CmdletBinding()]
    param(
		[Parameter(ValueFromPipeline = $true)]
		$Data,
		[int]$TotalItems = 0,
		[Parameter()]
		[int]$Depth = 10
	)

    Begin {
        New-Variable -Name Items -Value @()
    }

	Process {
		$Items += $Data
	}

	End {
		if ($TotalItems -eq 0 -and $Items.Length -ne 0) {
			$TotalItems = $Items.Length
		}

	    @{
			data = $Items
			recordsTotal = $TotalItems
			recordsFiltered = $Items.Length
			draw = $drawId
		} | ConvertTo-JsonEx -Depth $Depth
	}
}

function Out-UDTableData {
	[CmdletBinding()]
    param(
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		$Data,
		[Parameter(Mandatory = $true)]
		[string[]]$Property,
		[Parameter()]
	    [string]$DateTimeFormat = "lll"
	)

	Process {
		New-UDElement -Tag 'tr' -Content {
			foreach($itemProperty in $Property) {
				New-UDElement -Tag 'td' -Content {
					if ($Data.$itemProperty -is [System.DateTime]) {
						$DateTimeComponent = New-Object -TypeName UniversalDashboard.Models.DateTimeComponent
						$DateTimeComponent.DateTimeFormat = $DateTimeFormat
						$DateTimeComponent.Value = $Data.$itemProperty.ToString("O")
						$DateTimeComponent
					}
					else
					{
						$Data.$itemProperty
					}
				}
			}
		}
	}
}

function Set-UDCookie {
	param(
		[Parameter(Mandatory = $true)]
		[string]$Name,
		[Parameter(Mandatory = $true)]
		[string]$Value,
		[Parameter()]
		[Microsoft.AspNetCore.Http.CookieOptions]$CookieOptions
	)

	Process {
		if ($CookieOptions -ne $null) {
			$Response.Cookies.Append($Name, $Value, $CookieOptions)
		}
		else {
			$Response.Cookies.Append($Name, $Value)
		}
	}
}

function Remove-UDCookie {
	param(
		[Parameter(Mandatory = $true)]
		[string]$Name,
		[Parameter()]
		[Microsoft.AspNetCore.Http.CookieOptions]$CookieOptions
	)

	Process {
		if ($CookieOptions -ne $null) {
			$Response.Cookies.Delete($Name, $CookieOptions)
		}
		else {
			$Response.Cookies.Delete($Name)
		}
	}
}

function Get-UDCookie {
	param(
		[Parameter()]
		[string]$Name
	)

	if ($Name) {
		$Request.Cookies | Where-Object Key -match $Name
	} else {
		$Request.Cookies
	}
}

function Get-UDContentType {
	$Request.ContentType
}

function Set-UDContentType {
	param([Parameter(Mandatory=$true)]$ContentType)
	$Response.ContentType = $ContentType
}

#region Charting

function New-UDChartLayoutOptions {
	param(
		[Parameter(Mandatory = $true, ParameterSetName = "Size")]
		[int]$Padding,
		[Parameter(Mandatory = $true, ParameterSetName = "Object")]
		[int]$PaddingLeft,
		[Parameter(Mandatory = $true, ParameterSetName = "Object")]
		[int]$PaddingRight,
		[Parameter(Mandatory = $true, ParameterSetName = "Object")]
		[int]$PaddingTop,
		[Parameter(Mandatory = $true, ParameterSetName = "Object")]
		[int]$PaddingBottom
	)

	if ($PSCmdlet.ParameterSetName -eq "Size") {
		$obj = [PSCustomObject]@{
			left = $PaddingSize
			right = $PaddingSize
			bottom = $PaddingSize
			top = $PaddingSize
		}
	} else {
		$obj = [PSCustomObject]@{
			left = $PaddingLeft
			right = $PaddingRight
			bottom = $PaddingBottom
			top = $PaddingTop
		}
	}

	$obj.psobject.TypeNames.Insert(0,"UDLayoutOptions")
	$obj
}

function New-UDChartLegendOptions {
	param(
		[Parameter()]
		[Switch]$Hide,
		[Parameter()]
		[ValidateSet("top", "bottom", "left", "right")]
		[string]$Position = "top",
		[Parameter()]
		[bool]$FullWidth = $true,
		[Parameter()]
		[Switch]$Reverse,
		[Parameter()]
		[int]$LabelBoxWidth = 40,
		[Parameter()]
		[int]$LabelFontSize = 12,
		[Parameter()]
		[ValidateSet("normal", "bold", "italic")]
		[string]$LabelFontStyle = 'normal',
		[Parameter()]
		[string]$LabelFontFamily = 'Helvetica Neue',
		[Parameter()]
		[int]$LabelPadding = 10,
		[Parameter()]
		[bool]$LabelUsePointStyle
	)

	$obj = @{}

	if ($PSBoundParameters.ContainsKey("Hide")) {
		$obj["display"] = $false
	}

	if ($PSBoundParameters.ContainsKey("Position")) {
		$obj["position"] = $Position
	}

	if ($PSBoundParameters.ContainsKey("FullWidth")) {
		$obj["fullWidth"] = $FullWidth
	}

	if ($PSBoundParameters.ContainsKey("Reverse")) {
		$obj["reverse"] = $Reverse
	}

    $labelOptions = $PSBoundParameters | Where-Object {$_.Keys -match "Label*"}
    if ($labelOptions.Count -gt 0) {
		$obj["labels"] = @{}

		if ($PSBoundParameters.ContainsKey("LabelBoxWidth")) {
			$obj["labels"]["boxWidth"] = $LabelBoxWidth
		}

		if ($PSBoundParameters.ContainsKey("LabelFontSize")) {
			$obj["labels"]["fontSize"] = $LabelFontSize
		}

		if ($PSBoundParameters.ContainsKey("LabelFontStyle")) {
			$obj["labels"]["fontStyle"] = $LabelFontStyle
		}

		if ($PSBoundParameters.ContainsKey("LabelFontFamily")) {
			$obj["labels"]["fontFamily"] = $LabelFontFamily
		}

		if ($PSBoundParameters.ContainsKey("LabelPadding")) {
			$obj["labels"]["padding"] = $LabelPadding
		}

		if ($PSBoundParameters.ContainsKey("LabelUsePointStyle")) {
			$obj["labels"]["usePointStyle"] = $LabelUsePointStyle
		}
	}

	$obj.psobject.TypeNames.Insert(0,"UDLegendOptions")

	$obj
}

function New-UDChartTitleOptions {
	param(
		[Parameter()]
		[Switch]$Display,
		[Parameter()]
		[ValidateSet("top", "bottom", "left", "right")]
		[string]$Position = "top",
		[Parameter()]
		[int]$FontSize = 12,
		[Parameter()]
		[ValidateSet("normal", "bold", "italic")]
		[string]$FontStyle = 'bold',
		[Parameter()]
		[string]$FontFamily = 'Helvetica Neue',
		[Parameter()]
		[int]$Padding = 10,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor]$FontColor = "#666",
		[Parameter()]
		[float]$LineHeight = 1.2,
		[Parameter()]
		[string]$Text
	)

	$obj = @{}
	foreach($parameter in $PSBoundParameters.GetEnumerator())
	{
		$propertyName = [Char]::ToLowerInvariant($parameter.Key[0]) + $parameter.Key.Substring(1)

		if ($parameter.Value -is [UniversalDashboard.Models.DashboardColor]) {
			$obj[$propertyName] = $parameter.Value.HtmlColor
		} else {
			$obj[$propertyName] = $parameter.Value
		}
	}

	$obj.psobject.TypeNames.Insert(0,"UDTitleOptions")

	$obj
}

function New-UDChartTooltipOptions {
	param(
		[Parameter()]
		[Switch]$Disabled,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor]$BackgroundColor = 'rgba(0,0,0,0.8)',

		[Parameter()]
		[string]$TitleFontFamily = 'Helvetica Neue',
		[Parameter()]
		[int]$TitleFontSize = 12,
		[Parameter()]
		[ValidateSet("normal", "bold", "italic")]
		[string]$TitleFontStyle = 'bold',
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor]$TitleFontColor = "#fff",
		[Parameter()]
		[int]$TitleSpacing = 2,
		[Parameter()]
		[int]$TitleMarginBottom = 6,

		[Parameter()]
		[string]$BodyFontFamily = 'Helvetica Neue',
		[Parameter()]
		[int]$BodyFontSize = 12,
		[Parameter()]
		[ValidateSet("normal", "bold", "italic")]
		[string]$BodyFontStyle = 'bold',
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor]$BodyFontColor = "#fff",
		[Parameter()]
		[int]$BodySpacing = 2,

		[Parameter()]
		[string]$FooterFontFamily = 'Helvetica Neue',
		[Parameter()]
		[int]$FooterFontSize = 12,
		[Parameter()]
		[ValidateSet("normal", "bold", "italic")]
		[string]$FooterFontStyle = 'bold',
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor]$FooterFontColor = "#fff",
		[Parameter()]
		[int]$FooterSpacing = 2,
		[Parameter()]
		[int]$FooterMarginTop = 6,

		[Parameter()]
		[int]$xPadding = 6,
		[Parameter()]
		[int]$yPadding = 6,
		[Parameter()]
		[int]$CaretPadding = 2,
		[Parameter()]
		[int]$CaretSize = 5,
		[Parameter()]
		[int]$CornerRadius = 6,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor]$MultiKeyBackground = "#fff",
		[Parameter()]
		[bool]$DisplayColors = $true,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor]$BorderColor = 'rgba(0,0,0,0)',
		[Parameter()]
		[int]$BorderWidth = 0
	)

	$obj = @{}

	foreach($parameter in $PSBoundParameters.GetEnumerator())
	{
		$propertyName = [Char]::ToLowerInvariant($parameter.Key[0]) + $parameter.Key.Substring(1)

		if ($parameter.Value -is [UniversalDashboard.Models.DashboardColor]) {
			$obj[$propertyName] = $parameter.Value.HtmlColor
		} else {
			$obj[$propertyName] = $parameter.Value
		}
	}

	$obj.psobject.TypeNames.Insert(0,"UDTooltipOptions")

	$obj
}

function New-UDLineChartOptions {
	param(
		[Parameter()]
		[PSTypeName('UDLayoutOptions')]$LayoutOptions,
		[Parameter()]
		[PSTypeName('UDLegendOptions')]$LegendOptions,
		[Parameter()]
		[PSTypeName('UDTitleOptions')]$TitleOptions,
		[Parameter()]
		[PSTypeName('UDTooltipOptions')]$TooltipOptions,
		[Parameter()]
		[PSTypeName('UDChartAxis')]$xAxes,
		[Parameter()]
		[PSTypeName('UDChartAxis')]$yAxes,
		[Parameter()]
		[bool]$ShowLines,
		[Parameter()]
		[bool]$SpanGaps
	)

	$obj = @{}

	if ($PSBoundParameters.ContainsKey("LayoutOptions")) {
		$obj["layout"] = $LayoutOptions
	}

	if ($PSBoundParameters.ContainsKey("LegendOptions")) {
		$obj["legend"] = $LegendOptions
	}

	if ($PSBoundParameters.ContainsKey("TitleOptions")) {
		$obj["title"] = $TitleOptions
	}

	if ($PSBoundParameters.ContainsKey("TooltipOptions")) {
		$obj["tooltips"] = $TooltipOptions
	}

	if ($PSBoundParameters.ContainsKey("ShowLines")) {
		$obj["showLines"] = $ShowLines
	}

	if ($PSBoundParameters.ContainsKey("SpanGaps")) {
		$obj["spanGaps"] = $SpanGaps
	}

	$ticks = @{}

	if ($PSBoundParameters.ContainsKey("xAxes")) {
		$ticks["xAxes"] = @($xAxes)
	}

	if ($PSBoundParameters.ContainsKey("yAxes")) {
		$ticks["yAxes"] = @($yAxes)
	}

	if ($ticks.Count -gt 0) {
		$obj["scales"] = $ticks
	}

	$obj.psobject.TypeNames.Insert(0,"UDLineChartOptions")

	$obj
}

function New-UDBarChartOptions {
	param(
		[Parameter()]
		[PSTypeName('UDLayoutOptions')]$LayoutOptions,
		[Parameter()]
		[PSTypeName('UDLegendOptions')]$LegendOptions,
		[Parameter()]
		[PSTypeName('UDTitleOptions')]$TitleOptions,
		[Parameter()]
		[PSTypeName('UDTooltipOptions')]$TooltipOptions,
		[Parameter()]
		[PSTypeName('UDChartAxis')]$xAxes,
		[Parameter()]
		[PSTypeName('UDChartAxis')]$yAxes,
		[Parameter()]
		[float]$BarPercentage,
		[Parameter()]
		[float]$CategoryPercentage,
		[Parameter()]
		[int]$BarThickness,
		[Parameter()]
		[int]$MaxBarThickness
	)

	$obj = @{}

	if ($PSBoundParameters.ContainsKey("LayoutOptions")) {
		$obj["layout"] = $LayoutOptions
	}

	if ($PSBoundParameters.ContainsKey("LegendOptions")) {
		$obj["legend"] = $LegendOptions
	}

	if ($PSBoundParameters.ContainsKey("TitleOptions")) {
		$obj["title"] = $TitleOptions
	}

	if ($PSBoundParameters.ContainsKey("TooltipOptions")) {
		$obj["tooltips"] = $TooltipOptions
	}

	if ($PSBoundParameters.ContainsKey("Circumference")) {
		$obj["circumference"] = $Circumference
	}

	if ($PSBoundParameters.ContainsKey("Rotation")) {
		$obj["rotation"] = $Rotation
	}

	$ticks = @{}

	if ($PSBoundParameters.ContainsKey("xAxes")) {
		$ticks["xAxes"] = @($xAxes)
	}

	if ($PSBoundParameters.ContainsKey("yAxes")) {
		$ticks["yAxes"] = @($yAxes)
	}

	if ($ticks.Count -gt 0) {
		$obj["scales"] = $ticks
	}

	if ($PSBoundParameters.ContainsKey("BarPercentage")) {
		$obj["barPercentage"] = $BarPercentage
	}

	if ($PSBoundParameters.ContainsKey("CategoryPercentage")) {
		$obj["categoryPercentage"] = $CategoryPercentage
	}

	if ($PSBoundParameters.ContainsKey("BarThickness")) {
		$obj["barThickness"] = $BarThickness
	}

	if ($PSBoundParameters.ContainsKey("MaxBarThickness")) {
		$obj["maxBarThickness"] = $MaxBarThickness
	}

	$obj.psobject.TypeNames.Insert(0,"UDBarChartOptions")

	$obj
}

function New-UDDoughnutChartOptions {
	param(
		[Parameter()]
		[PSTypeName('UDLayoutOptions')]$LayoutOptions,
		[Parameter()]
		[PSTypeName('UDLegendOptions')]$LegendOptions,
		[Parameter()]
		[PSTypeName('UDTitleOptions')]$TitleOptions,
		[Parameter()]
		[PSTypeName('UDTooltipOptions')]$TooltipOptions,
		[Parameter()]
		[PSTypeName('UDChartAxis')]$xAxes,
		[Parameter()]
		[PSTypeName('UDChartAxis')]$yAxes,
		[Parameter()]
		[int]$CutoutPercentage,
		[Parameter()]
		[float]$Rotation,
		[Parameter()]
		[float]$Circumference,
		[Parameter()]
		[bool]$AnimateRotate,
		[Parameter()]
		[bool]$AnimateScale
	)

	$obj = @{}

	if ($PSBoundParameters.ContainsKey("LayoutOptions")) {
		$obj["layout"] = $LayoutOptions
	}

	if ($PSBoundParameters.ContainsKey("LegendOptions")) {
		$obj["legend"] = $LegendOptions
	}

	if ($PSBoundParameters.ContainsKey("TitleOptions")) {
		$obj["title"] = $TitleOptions
	}

	if ($PSBoundParameters.ContainsKey("TooltipOptions")) {
		$obj["tooltips"] = $TooltipOptions
	}

	if ($PSBoundParameters.ContainsKey("Circumference")) {
		$obj["circumference"] = $Circumference
	}

	if ($PSBoundParameters.ContainsKey("Rotation")) {
		$obj["rotation"] = $Rotation
	}

	$ticks = @{}

	if ($PSBoundParameters.ContainsKey("xAxes")) {
		$ticks["xAxes"] = @($xAxes)
	}

	if ($PSBoundParameters.ContainsKey("yAxes")) {
		$ticks["yAxes"] = @($yAxes)
	}

	if ($ticks.Count -gt 0) {
		$obj["scales"] = $ticks
	}

	$animation = @{}

	if ($PSBoundParameters.ContainsKey("AnimateRotate")) {
		$animation["animateRotate"] = $AnimateRotate
	}

	if ($PSBoundParameters.ContainsKey("AnimateScale")) {
		$animation["animateScale"] = $AnimateScale
	}

	if ($animation.Count -gt 0) {
		$obj["animation"] = $animation
	}

	$obj.psobject.TypeNames.Insert(0,"UDDoughnutChartOptions")

	$obj
}

function New-UDPolarChartOptions {
	param(
		[Parameter()]
		[PSTypeName('UDLayoutOptions')]$LayoutOptions,
		[Parameter()]
		[PSTypeName('UDLegendOptions')]$LegendOptions,
		[Parameter()]
		[PSTypeName('UDTitleOptions')]$TitleOptions,
		[Parameter()]
		[PSTypeName('UDTooltipOptions')]$TooltipOptions,
		[Parameter()]
		[PSTypeName('UDChartAxis')]$xAxes,
		[Parameter()]
		[PSTypeName('UDChartAxis')]$yAxes,
		[Parameter()]
		[float]$StartAngle,
		[Parameter()]
		[bool]$AnimateRotate,
		[Parameter()]
		[bool]$AnimateScale
	)


	$obj = @{}

	if ($PSBoundParameters.ContainsKey("LayoutOptions")) {
		$obj["layout"] = $LayoutOptions
	}

	if ($PSBoundParameters.ContainsKey("LegendOptions")) {
		$obj["legend"] = $LegendOptions
	}

	if ($PSBoundParameters.ContainsKey("TitleOptions")) {
		$obj["title"] = $TitleOptions
	}

	if ($PSBoundParameters.ContainsKey("TooltipOptions")) {
		$obj["tooltips"] = $TooltipOptions
	}

	$ticks = @{}

	if ($PSBoundParameters.ContainsKey("xAxes")) {
		$ticks["xAxes"] = @($xAxes)
	}

	if ($PSBoundParameters.ContainsKey("yAxes")) {
		$ticks["yAxes"] = @($yAxes)
	}

	if ($ticks.Count -gt 0) {
		$obj["scales"] = $ticks
	}

	if ($PSBoundParameters.ContainsKey("StartAngle")) {
		$obj["startAngle"] = $StartAngle
	}

	$animation = @{}

	if ($PSBoundParameters.ContainsKey("AnimateRotate")) {
		$animation["animateRotate"] = $AnimateRotate
	}

	if ($PSBoundParameters.ContainsKey("AnimateScale")) {
		$animation["animateScale"] = $AnimateScale
	}

	if ($animation.Count -gt 0) {
		$obj["animation"] = $animation
	}

	$obj.psobject.TypeNames.Insert(0,"UDPolarChartOptions")

	$obj
}

function New-UDLinearChartAxis {
	param(
		[Parameter()]
		[ValidateSet("left", "right", "top", "bottom")]
		[string]$Position,
		[Parameter()]
		[bool]$Offset,
		[Parameter()]
		[string]$Id,
		[Parameter()]
		[bool]$BeginAtZero,
		[Parameter()]
		[int]$Minimum,
		[Parameter()]
		[int]$Maximum,
		[Parameter()]
		[int]$MaxTickLimit = 11,
		[Parameter()]
		[int]$StepSize,
		[Parameter()]
		[int]$SuggestedMaximum,
		[Parameter()]
		[int]$SuggestedMinimum
	)

	$obj = @{
		type = "linear"
	}

	if ($PSBoundParameters.ContainsKey("Position")) {
		$obj["position"] = $Position
	}

	if ($PSBoundParameters.ContainsKey("Offset")) {
		$obj["offset"] = $Offset
	}

	if ($PSBoundParameters.ContainsKey("Id")) {
		$obj["id"] = $Id
	}

	if ($PSBoundParameters.ContainsKey("Position")) {
		$obj["position"] = $Position
	}

	$ticks = @{}

	if ($PSBoundParameters.ContainsKey("BeginAtZero")) {
		$ticks["beginAtZero"] = $BeginAtZero
	}

	if ($PSBoundParameters.ContainsKey("Minimum")) {
		$ticks["min"] = $Minimum
	}

	if ($PSBoundParameters.ContainsKey("Maximum")) {
		$ticks["max"] = $Maximum
	}

	if ($PSBoundParameters.ContainsKey("MaxTickLimit")) {
		$ticks["maxTickLimit"] = $MaxTickLimit
	}

	if ($PSBoundParameters.ContainsKey("StepSize")) {
		$ticks["stepSize"] = $StepSize
	}

	if ($PSBoundParameters.ContainsKey("SuggestedMaximum")) {
		$ticks["suggestedMax"] = $SuggestedMaximum
	}

	if ($PSBoundParameters.ContainsKey("SuggestedMinimum")) {
		$ticks["suggestedMin"] = $SuggestedMinimum
	}

	if ($ticks.Keys.Count -gt 0) {
		$obj["ticks"] = $ticks
	}

	$obj.psobject.TypeNames.Insert(0,"UDChartAxis")

	$obj
}

function New-UDCategoryChartAxis {
	param(
		[Parameter()]
		[ValidateSet("left", "right", "top", "bottom")]
		[string]$Position,
		[Parameter()]
		[bool]$Offset,
		[Parameter()]
		[string]$Id,
		[Parameter()]
		[string[]]$Labels,
		[Parameter()]
		[int]$Minimum,
		[Parameter()]
		[int]$Maximum
	)

	$obj = @{
		type = "category"
	}

	if ($PSBoundParameters.ContainsKey("Position")) {
		$obj["position"] = $Position
	}

	if ($PSBoundParameters.ContainsKey("Offset")) {
		$obj["offset"] = $Offset
	}

	if ($PSBoundParameters.ContainsKey("Id")) {
		$obj["id"] = $Id
	}

	if ($PSBoundParameters.ContainsKey("Position")) {
		$obj["position"] = $Position
	}

	$ticks = @{}

	if ($PSBoundParameters.ContainsKey("Labels")) {
		$ticks["labels"] = $Labels
	}

	if ($PSBoundParameters.ContainsKey("Maximum")) {
		$ticks["max"] = $Maximum
	}

	if ($PSBoundParameters.ContainsKey("Minimum")) {
		$ticks["min"] = $Minimum
	}

	if ($ticks.Keys.Count -gt 0) {
		$obj["ticks"] = $ticks
	}

	$obj.psobject.TypeNames.Insert(0,"UDChartAxis")

	$obj
}

function New-UDLogarithmicChartAxis {
	param(
		[Parameter()]
		[ValidateSet("left", "right", "top", "bottom")]
		[string]$Position,
		[Parameter()]
		[bool]$Offset,
		[Parameter()]
		[string]$Id,
		[Parameter()]
		[int]$Minimum,
		[Parameter()]
		[int]$Maximum
	)

	$obj = @{
		type = "logarithmic"
	}

	if ($PSBoundParameters.ContainsKey("Position")) {
		$obj["position"] = $Position
	}

	if ($PSBoundParameters.ContainsKey("Offset")) {
		$obj["offset"] = $Offset
	}

	if ($PSBoundParameters.ContainsKey("Id")) {
		$obj["id"] = $Id
	}

	if ($PSBoundParameters.ContainsKey("Position")) {
		$obj["position"] = $Position
	}

	$ticks = @{}

	if ($PSBoundParameters.ContainsKey("Maximum")) {
		$ticks["max"] = $Maximum
	}

	if ($PSBoundParameters.ContainsKey("Minimum")) {
		$ticks["min"] = $Minimum
	}

	if ($ticks.Keys.Count -gt 0) {
		$obj["ticks"] = $ticks
	}

	$obj.psobject.TypeNames.Insert(0,"UDChartAxis")

	$obj
}

function New-UDChartOptions {
	param(
		[Parameter()]
		[PSTypeName('UDLayoutOptions')]$LayoutOptions,
		[Parameter()]
		[PSTypeName('UDLegendOptions')]$LegendOptions,
		[Parameter()]
		[PSTypeName('UDTitleOptions')]$TitleOptions,
		[Parameter()]
		[PSTypeName('UDTooltipOptions')]$TooltipOptions,
		[Parameter()]
		[PSTypeName('UDChartAxis')]$xAxes,
		[Parameter()]
		[PSTypeName('UDChartAxis')]$yAxes
	)

	$obj = @{}

	if ($PSBoundParameters.ContainsKey("LayoutOptions")) {
		$obj["layout"] = $LayoutOptions
	}

	if ($PSBoundParameters.ContainsKey("LegendOptions")) {
		$obj["legend"] = $LegendOptions
	}

	if ($PSBoundParameters.ContainsKey("TitleOptions")) {
		$obj["title"] = $TitleOptions
	}

	if ($PSBoundParameters.ContainsKey("TooltipOptions")) {
		$obj["tooltips"] = $TooltipOptions
	}

	$ticks = @{}

	if ($PSBoundParameters.ContainsKey("xAxes")) {
		$ticks["xAxes"] = @($xAxes)
	}

	if ($PSBoundParameters.ContainsKey("yAxes")) {
		$ticks["yAxes"] = @($yAxes)
	}

	if ($ticks.Count -gt 0) {
		$obj["scales"] = $ticks
	}

	$obj
}

function New-UDLineChartDataset {
	param(
		[Parameter()]
		[string]$DataProperty,
		[Parameter()]
		[string]$Label,
		[Parameter()]
		[string]$xAxisId,
		[Parameter()]
		[string]$yAxisId,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$BackgroundColor = @("#807B210C"),
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$BorderColor = @("#FF7B210C"),
		[Parameter()]
		[int]$BorderWidth,
		[Parameter()]
		[ValidateSet("butt", "round", "square")]
		[string]$BorderCapStyle,
		[Parameter()]
		[ValidateSet("bevel", "round", "miter")]
		[string]$BorderJoinStyle,
		[Parameter()]
		$Fill,
		[Parameter()]
		[int]$LineTension,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$PointBackgroundColor,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$PointBorderColor,
		[Parameter()]
		[int[]]$PointBorderWidth,
		[Parameter()]
		[int[]]$PointRadius,
		[Parameter()]
		[ValidateSet("circle", "cross", "crossRot", "dash", "line", "rect", "rectRounded", "rectRot", "star", "triangle")]
		[string[]]$PointStyle,
		[Parameter()]
		[int[]]$PointHitRadius,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$PointHoverBackgroundColor,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$PointHoverBorderColor,
		[Parameter()]
		[int[]]$PointHoverBorderWidth,
		[Parameter()]
		[int[]]$PointHoverRadius,
		[Parameter()]
		[bool]$ShowLine,
		[Parameter()]
		[bool]$SpanGaps,
		[Parameter()]
		[bool]$SteppedLine
	)

	$obj = @{
		data = @()
	}

	foreach($parameter in $PSBoundParameters.GetEnumerator())
	{
		$propertyName = [Char]::ToLowerInvariant($parameter.Key[0]) + $parameter.Key.Substring(1)

		if ($parameter.Value -is [UniversalDashboard.Models.DashboardColor[]]) {
			$obj[$propertyName] = $parameter.Value.HtmlColor
		} else {
			$obj[$propertyName] = $parameter.Value
		}
	}

	$obj.psobject.TypeNames.Insert(0,"UDLineChartDataset")

	$obj
}

function New-UDBarChartDataset {
	param(
		[Parameter()]
		[string]$DataProperty,
		[Parameter()]
		[string]$Label,
		[Parameter()]
		[string]$xAxisId,
		[Parameter()]
		[string]$yAxisId,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$BackgroundColor = @("#807B210C"),
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$BorderColor = @("#FF7B210C"),
		[Parameter()]
		[int]$BorderWidth,
		[Parameter()]
		[ValidateSet("bottom", "left", "top", "right")]
		[string]$BorderSkipped,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$HoverBackgroundColor,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$HoverBorderColor,
		[Parameter()]
		[int[]]$HoverBorderWidth
	)

	$obj = @{
		data = @()
	}

	foreach($parameter in $PSBoundParameters.GetEnumerator())
	{
		$propertyName = [Char]::ToLowerInvariant($parameter.Key[0]) + $parameter.Key.Substring(1)

		if ($parameter.Value -is [UniversalDashboard.Models.DashboardColor[]]) {
			$obj[$propertyName] = $parameter.Value.HtmlColor
		} else {
			$obj[$propertyName] = $parameter.Value
		}
	}

	$obj.psobject.TypeNames.Insert(0,"UDBarChartDataset")

	$obj
}

function New-UDRadarChartDataset {
	param(
		[Parameter()]
		[string]$DataProperty,
		[Parameter()]
		[string]$Label,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$BackgroundColor = @("#807B210C"),
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$BorderColor = @("#FF7B210C"),
		[Parameter()]
		[int]$BorderWidth,
		[Parameter()]
		[ValidateSet("butt", "round", "square")]
		[string]$BorderCapStyle,
		[Parameter()]
		[ValidateSet("bevel", "round", "miter")]
		[string]$BorderJoinStyle,
		[Parameter()]
		$Fill,
		[Parameter()]
		[int]$LineTension,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$PointBackgroundColor,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$PointBorderColor,
		[Parameter()]
		[int[]]$PointBorderWidth,
		[Parameter()]
		[int[]]$PointRadius,
		[Parameter()]
		[ValidateSet("circle", "cross", "crossRot", "dash", "line", "rect", "rectRounded", "rectRot", "star", "triangle")]
		[string[]]$PointStyle,
		[Parameter()]
		[int[]]$PointHitRadius,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$PointHoverBackgroundColor,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$PointHoverBorderColor,
		[Parameter()]
		[int[]]$PointHoverBorderWidth,
		[Parameter()]
		[int[]]$PointHoverRadius
	)

	$obj = @{
		data = @()
	}

	foreach($parameter in $PSBoundParameters.GetEnumerator())
	{
		$propertyName = [Char]::ToLowerInvariant($parameter.Key[0]) + $parameter.Key.Substring(1)

		if ($parameter.Value -is [UniversalDashboard.Models.DashboardColor[]]) {
			$obj[$propertyName] = $parameter.Value.HtmlColor
		} else {
			$obj[$propertyName] = $parameter.Value
		}
	}

	$obj.psobject.TypeNames.Insert(0,"UDRadarChartDataset")

	$obj
}

function New-UDDoughnutChartDataset {
	param(
		[Parameter()]
		[string]$DataProperty,
		[Parameter()]
		[string]$Label,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$BackgroundColor = @("#807B210C"),
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$BorderColor = @("#FF7B210C"),
		[Parameter()]
		[int]$BorderWidth,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$HoverBackgroundColor,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$HoverBorderColor,
		[Parameter()]
		[int[]]$HoverBorderWidth
	)

	$obj = [PSCustomObject]@{
		data = @()
	}

	foreach($parameter in $PSBoundParameters.GetEnumerator())
	{
		$propertyName = [Char]::ToLowerInvariant($parameter.Key[0]) + $parameter.Key.Substring(1)

		if ($parameter.Value -is [UniversalDashboard.Models.DashboardColor[]]) {
			$obj[$propertyName] = $parameter.Value.HtmlColor
		} else {
			$obj[$propertyName] = $parameter.Value
		}
	}

	$obj.psobject.TypeNames.Insert(0,"UDDonutChartDataset")

	$obj
}

function New-UDPolarChartDataset {
	param(
		[Parameter()]
		[string]$DataProperty,
		[Parameter()]
		[string]$Label,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$BackgroundColor = @("#807B210C"),
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$BorderColor = @("#FF7B210C"),
		[Parameter()]
		[int]$BorderWidth,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$HoverBackgroundColor,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor[]]$HoverBorderColor,
		[Parameter()]
		[int[]]$HoverBorderWidth
	)

	$obj = @{
		data = @()
	}

	foreach($parameter in $PSBoundParameters.GetEnumerator())
	{
		$propertyName = [Char]::ToLowerInvariant($parameter.Key[0]) + $parameter.Key.Substring(1)

		if ($parameter.Value -is [UniversalDashboard.Models.DashboardColor[]]) {
			$obj[$propertyName] = $parameter.Value.HtmlColor
		} else {
			$obj[$propertyName] = $parameter.Value
		}
	}

	$obj.psobject.TypeNames.Insert(0,"UDPolarChartDataset")

	$obj
}


#endregion

function Update-UDDashboard {
	param(
		[Parameter(Mandatory = $true)]
		$Url,
		[Parameter(Mandatory = $true)]
		$UpdateToken,
		[Parameter(ParameterSetName = "Content", Mandatory = $true)]
		[ScriptBlock]$Content,
		[Parameter(ParameterSetName = "FilePath", Mandatory = $true)]
		[string]$FilePath
	)

	Process {
		if ($PSCmdlet.ParameterSetName -eq "Content") {
			$Body = $Content.ToString()
		}

		if ($PSCmdlet.ParameterSetName -eq "FilePath") {
			$Body = Get-Content $FilePath -Raw
		}

		Invoke-RestMethod -Uri "$Url/api/dashboard" -Headers @{ "x-ud-update-token" = $UpdateToken } -Body $Body -Method Post
	}
}

function Set-UDCacheData {
	param(
		[Parameter(Mandatory = $true)]
		[String]$Key,
		[Parameter(Mandatory = $true)]
		$Value
	)

	if ($MemoryCache -eq $null) {
		throw "MemoryCache is not defined."
	}

	[Microsoft.Extensions.Caching.Memory.CacheExtensions]::Set($MemoryCache, $Key, $Value)
}

function Get-UDCacheData {
	param(
		[Parameter(Mandatory = $true)]
		[String]$Key
	)

	if ($MemoryCache -eq $null) {
		throw "MemoryCache is not defined."
	}

	[Microsoft.Extensions.Caching.Memory.CacheExtensions]::Get($MemoryCache, $Key)
}

function Publish-UDDashboard {
	[CmdletBinding(DefaultParameterSetName = 'Service')]
	param(
		[Parameter(ParameterSetName = 'Service')]
		[Switch]$Manual,
		[Parameter(Mandatory = $true)]
		[string]$DashboardFile,
		[Parameter()]
		[string]$TargetPath = $PSScriptRoot
	)

	$DashboardFile = Resolve-Path $DashboardFile

	if (-not (Test-Path $DashboardFile)) {
		throw "$DashboardFile does not exist"
	}

	if ((Get-Item $DashboardFile).Name -ne "dashboard.ps1") {
		throw "DashboardFile must be named dashboard.ps1"
	}

	$TargetDashboardFile = $DashboardFile

	if ($PSBoundParameters.ContainsKey("TargetPath")) {
		if (-not (Test-Path $TargetPath)) {
			Write-Verbose "Directory $TargetPath does not exist. Creating target directory."

			New-Item $TargetPath -Type Directory | Out-Null
		}

		$SourcePath = $PSScriptRoot

		Write-Verbose "Copying Universal Dashboard module from $SourcePath -> $TargetPath"
		Get-ChildItem $SourcePath | ForEach-Object {
			Copy-Item $_.FullName $TargetPath -Recurse -Force
		}

		$DashboardFileName = Split-Path $DashboardFile -Leaf
		$TargetDashboardFile = Join-Path $TargetPath $DashboardFileName
	}
	else
	{
		$ModulePath = Split-Path (Get-Module UniversalDashboard.Community).Path
		$TargetDashboardFile = [IO.Path]::Combine($ModulePath, "dashboard.ps1")
	}

	Write-Verbose "Copying dashboard file from $DashboardFile -> $TargetPath"
	Copy-Item $DashboardFile $TargetDashboardFile -Force

	if ($PSCmdlet.ParameterSetName -eq 'Service') {

		$ServiceStart = 'auto'
		if ($Manual) {
			$ServiceStart = 'demand'
		}

		if ((Get-Service -Name UniversalDashboard -ErrorAction SilentlyContinue) -ne $null) {
			Write-Verbose "Removing dashboard service"
			sc.exe delete UniversalDashboard
		}

		Write-Verbose "Creating service UniversalDashboard"

		$binPath = [System.IO.Path]::Combine($TargetPath, "bin", "UniversalDashboard.Server.exe")

		sc.exe create UniversalDashboard DisplayName="PowerShell Universal Dashboard" binPath="$binPath --run-as-service" start="$ServiceStart"

		Write-Verbose "Starting service UniversalDashboard"
		sc.exe start UniversalDashboard
	}
}