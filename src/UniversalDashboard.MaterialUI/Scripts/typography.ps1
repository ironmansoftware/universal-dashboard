function New-UDTypography {
    [CmdletBinding(DefaultParameterSetName = "text")]
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),

        [Parameter()]
        [ValidateSet ("h1", "h2", "h3", "h4", "h5", "h6", "subtitle1", "subtitle2", "body1", "body2", "caption", "button", "overline", "srOnly", "inherit", "display4", "display3", "display2", "display1", "headline", "title", "subheading")]
		[string]$Variant,

		[Parameter(ParameterSetName = "text", Position = 0)]
		[string]$Text,

        [Parameter(ParameterSetName = "endpoint")]
		[scriptblock]$Content,

		[Parameter()]
		[Hashtable]$Style,

		[Parameter()]
		[string]$ClassName,

        [Parameter()]
        [ValidateSet ("inherit", "left", "center", "right", "justify")]
		[string]$Align,

        [Parameter()]
		[switch]$IsEndPoint,

		[Parameter()]
		[Switch]$GutterBottom,

        [Parameter()]
		[Switch]$NoWrap,

        [Parameter()]
		[Switch]$Paragraph
        
    )

    End {
        $MUTypography = @{
            #This needs to match what is in the register function call of chips.jsx
            type = "mu-typography"
            #Eventually everything will be a plugin so we wont need this.
            isPlugin = $true
            #This was set in the UniversalDashboard.MaterialUI.psm1 file
            assetId = $MUAssetId

            id = $Id
            className = $ClassName
            variant = $Variant
            noWrap = $NoWrap.IsPresent
            isParagraph = $Paragraph.IsPresent
            text = $Text
            style = $Style
            align = $Align
            content = $TextContent 
            gutterBottom = $GutterBottom.IsPresent
        }

        $MUTypography.PSTypeNames.Insert(0, 'UniversalDashboard.MaterialUI.Typography') | Out-Null

        $MUTypography
    }
}