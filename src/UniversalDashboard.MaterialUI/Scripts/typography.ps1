function New-UDTypography {
    <#
    .SYNOPSIS
    Creates typography.
    
    .DESCRIPTION
    Creates typography. Typography allows you to configure text within a dashboard. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Variant
    The type of text to display.
    
    .PARAMETER Text
    The text to format. 
    
    .PARAMETER Content
    The content to format. 
    
    .PARAMETER Style
    A set of CSS styles to apply to the typography.
    
    .PARAMETER ClassName
    A CSS className to apply to the typography.
    
    .PARAMETER Align
    How to align the typography.
    
    .PARAMETER GutterBottom
    The gutter bottom. 
    
    .PARAMETER NoWrap
    Disables text wrapping.
    
    .PARAMETER Paragraph
    Whether this typography is a paragraph.
    
    .EXAMPLE
    
    New-UDTypography -Text 'Hello' -Paragraph

    #>
    [CmdletBinding(DefaultParameterSetName = "text")]
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),

        [Parameter()]
        [ValidateSet ("h1", "h2", "h3", "h4", "h5", "h6", "subtitle1", "subtitle2", "body1", "body2", "caption", "button", "overline", "srOnly", "inherit", "display4", "display3", "display2", "display1", "headline", "title", "subheading")]
		[string]$Variant,

        [Parameter(ParameterSetName = "content")]
		[scriptblock]$Content,

		[Parameter()]
		[Hashtable]$Style,

		[Parameter()]
		[string]$ClassName,

        [Parameter()]
        [ValidateSet ("inherit", "left", "center", "right", "justify")]
        [string]$Align,
        
        [Parameter(ParameterSetName = "text")]
        [string]$Text
    )

    End {

        $MUContent = $Text
        if ($PSCmdlet.ParameterSetName -eq 'content')
        {
            $MUContent = & $Content
        }

        $MUTypography = @{
            type = "mu-typography"
            isPlugin = $true
            assetId = $MUAssetId
            id = $Id
            className = $ClassName
            variant = $Variant
            style = $Style
            textAlign = $Align
            content = $MUContent
        }

        $MUTypography.PSTypeNames.Insert(0, 'UniversalDashboard.MaterialUI.Typography') | Out-Null

        $MUTypography
    }
}