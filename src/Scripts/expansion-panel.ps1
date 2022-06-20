function New-UDExpansionPanelGroup {
    <#
    .SYNOPSIS
    Creates a group of expansion panels. 
    
    .DESCRIPTION
    Creates a group of expansion panels. Use New-UDExpansionPanel to create children for a group. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Children
    Expansion panels to include in this group. 
    
    .PARAMETER Popout
    Creates a popout style expansion panel group.
    
    .PARAMETER Type
    The type of expansion panel group.
    
    .EXAMPLE
    
    Creates an expansion panel group. 

    New-UDExpansionPanelGroup -Items {
        New-UDExpansionPanel -Title "Hello" -Id 'expTitle' -Content {}

        New-UDExpansionPanel -Title "Hello" -Id 'expContent' -Content {
            New-UDElement -Tag 'div' -id 'expContentDiv' -Content { "Hello" }
        }

        New-UDExpansionPanel -Title "Hello" -Id 'expEndpoint' -Endpoint {
            New-UDElement -Tag 'div' -id 'expEndpointDiv' -Content { "Hello" }
        }
    }
    #>
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias("Content")]
        [ScriptBlock]$Children,
        [Parameter()]
        [Switch]$Popout,
        [Parameter()]
        [ValidateSet("Expandable", "Accordion")]
        [String]$Type = 'Expandable',
        [Parameter()]
        [string]$ClassName
    )
    
    $c = New-UDErrorBoundary -Content $Children

    @{
        type      = 'mu-expansion-panel-group'
        isPlugin  = $true
        assetId   = $AssetId

        id        = $id
        children  = $c
        popout    = $Popout.IsPresent
        accordion = $Type -eq 'Accordion'
        className = $ClassName
    }
}

function New-UDExpansionPanel {
    <#
    .SYNOPSIS
    Creates an expansion panel.
    
    .DESCRIPTION
    Creates an expansion panel. An expansion panel can hide content that isn't necessary to view when a page is loaded. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Title
    The title show within the header of the expansion panel. 
    
    .PARAMETER Icon
    An icon to show within the header of the expansion panel. 
    
    .PARAMETER Children
    Children components to put within the expansion panel. 
    
    .PARAMETER Active
    Whether the expansion panel is currently active (open).
    
    .EXAMPLE

    Creates an expansion panel with some content.
    
    New-UDExpansionPanel -Title "Hello" -Id 'expContent' -Content {
        New-UDElement -Tag 'div' -id 'expContentDiv' -Content { "Hello" }
    }
    #>
    [CmdletBinding()]
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        [String]$Title,
        [Parameter()]
        $Icon,
        [Parameter()]
        [Alias("Content")]
        [ScriptBlock]$Children,
        [Parameter()]
        [Switch]$Active,
        [Parameter()]
        [string]$ClassName
    )

    $iconName = $Icon
    if ($PSBoundParameters.ContainsKey("Icon")) {
        if ($Icon -is [string]) {
            $iconName = [UniversalDashboard.Models.FontAwesomeIconsExtensions]::GetIconName($Icon)
        }
    }

    @{
        id        = $Id 
        title     = $Title 
        children  = & $Children
        active    = $Active.IsPresent
        icon      = $iconName
        className = $ClassName

    }
}