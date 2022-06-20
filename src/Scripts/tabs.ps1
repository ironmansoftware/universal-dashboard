function New-UDTabs {
    <#
    .SYNOPSIS
    Creates a new set of tabs.
    
    .DESCRIPTION
    Creates a new set of tabs. Tabs can be used to show lots of content on a single page. 
    
    .PARAMETER Tabs
    The tabs to put within this container. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER RenderOnActive
    Whether to render the tabs when they are clicked. Is this value isn't present, all the tabs are rendered, even if they are not shown. 
    
    .PARAMETER Orientation
    The orientation of the tabs. Valid values are horizontal and vertical. 

    .PARAMETER Variant
    The variantion of tabs. Valid values are standard, fullWidth and scrollable. 

    .PARAMETER ScrollButtons
    The behavior of the scrollbuttons. Valid values are on, off, auto and desktop. On will enable scroll buttons no matter what. off will disable all scroll buttons. Auto will show scrollbuttons when necessary. Desktop will show scrollbuttons on medium and large screens. 
    
    .EXAMPLE
    Creates a basic set of tabs. 

    New-UDTabs -Tabs {
        New-UDTab -Text "Tab1" -Id 'Tab1' -Content {
            New-UDElement -Tag div -Id 'tab1Content' -Content { "Tab1Content"}
        }
        New-UDTab -Text "Tab2" -Id 'Tab2' -Content {
            New-UDElement -Tag div -Id 'tab2Content' -Content { "Tab2Content"}
        }
        New-UDTab -Text "Tab3" -Id 'Tab3' -Content {
            New-UDElement -Tag div -Id 'tab3Content' -Content { "Tab3Content"}
        }
    }

    .EXAMPLE
    Creates a set of tabs that only render when they are clicked. 

    New-UDTabs -RenderOnActive -Id 'DynamicTabs' -Tabs {
        New-UDTab -Text "Tab1" -Id 'DynamicTab1' -Dynamic -Content {
            New-UDElement -Tag div -Id 'DynamicTab1Content' -Content { Get-Date } 
        }
        New-UDTab -Text "Tab2" -Id 'DynamicTab2' -Dynamic -Content {
            New-UDElement -Tag div -Id 'DynamicTab2Content' -Content { Get-Date }
        }
        New-UDTab -Text "Tab3" -Id 'DynamicTab2' -Dynamic -Content {
            New-UDElement -Tag div -Id 'DynamicTab3Content' -Content { Get-Date }
        }
    }

    .EXAMPLE
    Creates a vertical set of tabs. 

    New-UDTabs -Id 'verticalTabs' -Orientation 'vertical' -Tabs {
        New-UDTab -Text "Tab1" -Content {
            New-UDElement -Tag div -Content { Get-Date } 
        }
        New-UDTab -Text "Tab2" -Content {
            New-UDElement -Tag div -Content { Get-Date } 
        }
        New-UDTab -Text "Tab3" -Content {
            New-UDElement -Tag div -Content { Get-Date } 
        }
    }
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ScriptBlock]$Tabs,
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter()]
        [Switch]$RenderOnActive,
        [Parameter()]
        [ValidateSet('horizontal', 'vertical')]
        [string]$Orientation = "horizontal",
        [Parameter()]
        [ValidateSet('fullWidth', 'scrollable', 'standard')]
        [string]$Variant = 'standard',
        [Parameter()]
        [ValidateSet('on', 'off', 'auto', 'desktop')]
        [string]$ScrollButtons = 'auto',
        [Parameter()]
        [switch]$Centered,
        [Parameter()]
        [string]$ClassName
    )

    End {

        $c = New-UDErrorBoundary -Content $Tabs

        @{
            isPlugin      = $true
            assetId       = $MUAssetId
            type          = "mu-tabs"
            tabs          = $c
            id            = $id
            renderOnClick = $RenderOnActive.IsPresent
            orientation   = $Orientation
            variant       = $Variant.ToLower()
            scrollButtons = $ScrollButtons.ToLower()
            centered      = $Centered.IsPresent
            className     = $ClassName
        }
    }
}

function New-UDTab {
    <#
    .SYNOPSIS
    Creates a new tab. 
    
    .DESCRIPTION
    Creates a new tab. Use New-UDTabs as a container for tabs. 
    
    .PARAMETER Text
    The text to display for this tab. 
    
    .PARAMETER Content
    The content to display when the tab is selected. 
    
    .PARAMETER Id
    The ID of this component. 
    
    .PARAMETER Dynamic
    Whether this tab is dynamic. Dynamic tabs won't render until they are displayed. 
    
    .PARAMETER Icon
    The Icon to display within the tab header.
    
    .PARAMETER Disabled
    Whether this tab is disabled. 
    #>
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Text,
        [Parameter(Mandatory)]
        [ScriptBlock]$Content,
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter()]
        [switch]$Dynamic,
        [Parameter()]
        [object]$Icon,
        [Parameter()]
        [switch]$Disabled
    )

    End {

        if ($null -ne $Content -and $Dynamic) {
            New-UDEndpoint -Id $Id -Endpoint $Content | Out-Null
        }

        $c = New-UDErrorBoundary -Content $Content

        @{
            isPlugin = $true
            assetId  = $MUAssetId
            type     = "mu-tab"
            label    = $Text
            icon     = $Icon
            content  = $c
            id       = $Id
            dynamic  = $Dynamic.IsPresent
            disabled = $Disabled.IsPresent
        }
    }
}