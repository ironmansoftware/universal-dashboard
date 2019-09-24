function New-UDMuLink {
    param(
        [Parameter (HelpMessage="Enter id for this object")][string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter (HelpMessage="Enter url, this can be remote or local")][string]$url,
        [Parameter (HelpMessage="Show line under the text or content")]
        [ValidateSet('none','hover','always')][string]$underline = "none",
        [Parameter (HelpMessage="The css propertis for this object")][hashtable]$style,
        [Parameter (HelpMessage="The pre configure style", ParameterSetName = 'text')]
        [ValidateSet('h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'subtitle1', 'subtitle2', 'body1', 'body2', 'caption', 'button', 'overline', 'srOnly', 'inherit')]
        [string]$variant,
        [Parameter (HelpMessage="Set the Html class name")][string]$ClassName,
        [Parameter (HelpMessage="Open the result in new window or in the current window")][switch]$openInNewWindow,
        [Parameter (HelpMessage="The object or object to make as link", ParameterSetName = 'content')][scriptblock]$content,
        [Parameter (HelpMessage="The text to show as link", ParameterSetName = 'text')][string]$text
    )
    End {

        if($null -ne $Content){
            $Object = $content.Invoke()
        }else{$Object = $null}
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
        }
    }
}