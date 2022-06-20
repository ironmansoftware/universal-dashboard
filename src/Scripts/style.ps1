function New-UDStyle {
    <#
    .SYNOPSIS
    Style a component with CSS styles.
    
    .DESCRIPTION
    Style a component with CSS styles.
    
    .PARAMETER Id
    The ID of this component. 
    
    .PARAMETER Style
    The CSS style to apply
    
    .PARAMETER Tag
    The outer HTML tag to use.
    
    .PARAMETER Content
    The content of this style.

    .PARAMETER Sx
    A hashtable of theme-aware CSS properties.

    .PARAMETER Component
    The root component to apply the Sx component to.
    
    .EXAMPLE
    
    #>
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter(Mandatory = $true, ParameterSetName = 'Style')]
        [string]$Style,
        [Parameter(Mandatory = $true, ParameterSetName = 'Sx')]
        [Hashtable]$Sx,
        [Parameter(ParameterSetName = 'Sx')]
        [string]$Component,
        [Parameter()]
        [string]$Tag = 'div',
        [Parameter()]
        [ScriptBlock]$Content
    )

    End {

        $Children = $null
        if ($null -ne $Content) {
            $Children = & $Content
        }

        @{
            assetId   = $AssetId 
            isPlugin  = $true 
            type      = "ud-style"
            id        = $Id
            style     = $Style
            tag       = $Tag
            content   = $Children
            sx        = $Sx
            component = $Component
        }
    }
}