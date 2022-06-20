function New-UDLink {
    <#
    .SYNOPSIS
    Short description
    
    .DESCRIPTION
    Long description
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Url
    The URL of the link.
    
    .PARAMETER Underline
    Whether to underline the link.
    
    .PARAMETER Style
    A custom style to apply to the link. 
    
    .PARAMETER Variant
    The theme variant to apply to the link. 
    
    .PARAMETER ClassName
    The CSS class to apply to the link.
    
    .PARAMETER OpenInNewWindow
    Opens the link in a new window. 
    
    .PARAMETER Children
    The components to link. 
    
    .PARAMETER Text
    Text to include in the link.
    
    .PARAMETER OnClick
    A script block to invoke when clicked.

    .EXAMPLE
    An example
    
    .NOTES
    General notes
    #>
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter()]
        [string]$url,
        [Parameter()]
        [ValidateSet('none','hover','always')]
        [string]$Underline = "none",
        [Parameter()]
        [hashtable]$Style,
        [Parameter()]
        [ValidateSet('h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'subtitle1', 'subtitle2', 'body1', 'body2', 'caption', 'button', 'overline', 'srOnly', 'inherit')]
        [string]$Variant,
        [Parameter ()]
        [string]$ClassName,
        [Parameter()]
        [switch]$OpenInNewWindow,
        [Parameter(ParameterSetName = 'content')]
        [Alias("Content")]
        [scriptblock]$Children,
        [Parameter(ParameterSetName = 'text')]
        [string]$Text,
        [Parameter()]
        [Endpoint]$OnClick
    )
    End {
        if ($OnClick)
        {
            $OnClick.Register($Id, $PSCmdlet)
        }

        if($null -ne $Children)
        {
            $Object = & $Children
        }
        else
        {
            $Object = $null
        }

        @{
            type            = 'mu-link'
            isPlugin        = $true
            assetId         = $MUAssetId

            id              = $Id
            url             = $url
            underline       = $underline
            style           = $style
            variant         = $variant
            className       = $ClassName
            openInNewWindow = $openInNewWindow.IsPresent
            content         = $Object
            text            = $text
            onClick         = $OnClick
        }
    }
}