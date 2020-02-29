function New-UDTypography {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),

        [Parameter()]
        [ValidateSet ("h1", "h2", "h3", "h4", "h5", "h6", "subtitle1", "subtitle2", "body1", "body2", "caption", "button", "overline", "srOnly", "inherit", "display4", "display3", "display2", "display1", "headline", "title", "subheading")]
		[string]$Variant,

        [Parameter()]
		[scriptblock]$Content,

		[Parameter()]
		[Hashtable]$Style,

		[Parameter()]
		[string]$ClassName,

        [Parameter()]
        [ValidateSet ("inherit", "left", "center", "right", "justify")]
		[string]$Align,

        [Parameter()]
		[switch]$IsEndPoint
    )

    End {

        # if($IsEndPoint){
        #     $TextEndpoint = New-UDEndpoint -Endpoint $Content -Id $id
        #     if($null -ne $Content){
        #         $TextContent = $Content.Invoke()
        #     }else{
        #         $TextContent = $null
        #     }
        # }
        
        $MUTypography = @{
            type = "mu-typography"
            isPlugin = $true
            assetId = $MUAssetId
            id = $Id
            className = $ClassName
            variant = $Variant
            # fontSize = $FontSize
            style = $Style
            textAlign = $Align
            content = $Content.Invoke() 
            # isEndpoint = $IsEndPoint.IsPresent
        }

        $MUTypography.PSTypeNames.Insert(0, 'UniversalDashboard.MaterialUI.Typography') | Out-Null

        $MUTypography
    }
}