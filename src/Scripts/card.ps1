function New-UDCard {
    <#
    .SYNOPSIS
    Creates a new card.
    
    .DESCRIPTION
    Creates a new card. Cards are used to display related content.
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER ClassName
    A CSS class to assign to this card. 
    
    .PARAMETER ShowToolBar
    Whether to show the toolbar for this card. 
    
    .PARAMETER ToolBar
    The toolbar for this card. Use New-UDCardToolbar to create a toolbar. 
    
    .PARAMETER Header
    The header for this card. The header typically contains a title for the card. Use New-UDCardHeader to create a header.
    
    .PARAMETER Body
    The body for this card. This is the main content for the card. Use New-UDCardHeader to create a body. 
    
    .PARAMETER Expand
    Th expand content for this card. Expand content is show when the user clicks the expansion button. Use New-UDCardExpand to create an expand.
    
    .PARAMETER Footer
    The footer for this card. Footer contents typically contain actions that are relavent to the card. Use New-UDCardFooter to create a footer. 
    
    .PARAMETER Style
    Styles to apply to the card. 
    
    .PARAMETER Elevation
    The amount of elevation to provide the card. The more elevation, the more it will appear the card is floating off the page. 
    
    .PARAMETER Title
    A title for the card. 
    
    .PARAMETER TitleAlignment
    The alignment for the title. 
    
    .PARAMETER Content
    The content of the card. 
    
    .PARAMETER Image
    An image to show in the card. 
    
    .EXAMPLE
    Shows a card with a title, image and content. 

    New-UDCard -Id 'SimpleCard' -Title "Alon" -Content { 
        "Content" 
    } -Image 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4'
    #>
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),

        [Parameter()]
        [string]$ClassName,

        [Parameter()]
        [switch]$ShowToolBar,
     
        [Parameter (ParameterSetName = "Advanced")]
        [PSTypeName('UniversalDashboard.MaterialUI.CardToolbar')]$ToolBar,

        [Parameter(ParameterSetName = "Advanced")]
        [PSTypeName('UniversalDashboard.MaterialUI.CardHeader')]$Header,

        [Parameter(ParameterSetName = "Advanced")]
        [PSTypeName('UniversalDashboard.MaterialUI.CardBody')]$Body,

        [Parameter(ParameterSetName = "Advanced")]
        [PSTypeName('UniversalDashboard.MaterialUI.CardExpand')]$Expand,

        [Parameter(ParameterSetName = "Advanced")]
        [PSTypeName('UniversalDashboard.MaterialUI.CardFooter')]$Footer,

        [Parameter(ParameterSetName = "Advanced")]
        [PSTypeName('UniversalDashboard.MaterialUI.CardMedia')]$Media,

        [Parameter()]
        [Hashtable]$Style,

        [Parameter()]
        [ValidateSet("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24")]
        [int]$Elevation,

        [Parameter(ParameterSetName = "Simple")]
        [Parameter(ParameterSetName = "Text")]
        [String]$Title,
        [Parameter(ParameterSetName = "Simple")]
        [Parameter(ParameterSetName = "Text")]
        [ValidateSet('left', 'center', 'right')]
        [String]$TitleAlignment = 'left',
        [Parameter(ParameterSetName = "Simple")]
        [ScriptBlock]$Content,
        [Parameter(ParameterSetName = "Simple")]
        [string]$Image,
        [Parameter(ParameterSetName = "Text")]
        [string]$Text
    )

    End {

        if ($PSCMdlet.ParameterSetName -eq 'Advanced') {
            # Card toolbar checks
            if ($null -ne $ToolBar) {
                if ($ToolBar.psobject.typenames -notcontains "UniversalDashboard.MaterialUI.CardToolbar") {
                    throw "ToolBar must be a UniversalDashboard.MaterialUI.CardToolbar object, please use New-UDCardToolBar command."
                }
            }

            # Card Media checks 
            if ($null -ne $Media) {
                if ($Media.psobject.typenames -notcontains "UniversalDashboard.MaterialUI.CardMedia") {
                    throw "Media must be a UniversalDashboard.MaterialUI.CardMedia object, please use New-UDCardMedia command."
                }
            }

            # Card header checks 
            if ($null -ne $Header) {
                if ($Header.psobject.typenames -notcontains "UniversalDashboard.MaterialUI.CardHeader") {
                    throw "Header must be a UniversalDashboard.MaterialUI.CardHeader object, please use New-UDCardHeader command."
                }
            }

            # Card Content checks 
            if ($null -ne $Content) {
                if ($Content.psobject.typenames -notcontains "UniversalDashboard.MaterialUI.CardBody") {
                    throw "Body must be a UniversalDashboard.MaterialUI.CardBody object, please use New-UDCardBody command."
                }
            }

            # Card Expand checks 
            if ($null -ne $Expand) {
                if ($Expand.psobject.typenames -notcontains "UniversalDashboard.MaterialUI.CardExpand") {
                    throw "Expand must be a UniversalDashboard.MaterialUI.CardExpand object, please use New-UDCardExpand command."
                }
            }

            # Card footer checks 
            if ($null -ne $Footer) {
                if ($Footer.psobject.typenames -notcontains "UniversalDashboard.MaterialUI.CardFooter") {
                    throw "Footer must be a UniversalDashboard.MaterialUI.CardFooter object, please use New-UDCardFooter command."
                }
            }
            
            $Parts = @{
                toolbar = $ToolBar
                header  = $Header
                body    = $Body
                expand  = $Expand
                footer  = $Footer
            }
            $Content = { $Parts }
        }
        else {
            $Header = New-UDCardHeader -Title $Title -TitleAlignment $TitleAlignment

            if ($Image) {
                $Media = New-UDCardMedia -Height 120 -Image $Image
            }

            if ($PSCmdlet.ParameterSetName -eq 'Text') {
                $Element = New-UDElement -Tag div -Content {
                    $Text -split "`r`n" | ForEach-Object {
                        $_
                        New-UDElement -Tag "br"
                    }
                }
                $Content = { $Element }
            }

            $Body = New-UDCardBody -Content $Content

            $Parts = @{
                toolbar = $ToolBar
                header  = $Header
                body    = $Body
                expand  = $Expand
                footer  = $Footer
            }
            $Content = { $Parts }
        }

        $Card = @{
            type        = "mu-card"
            isPlugin    = $true
            assetId     = $MUAssetId
            id          = $Id
            className   = $ClassName
            showToolBar = $ShowToolBar.IsPresent
            media       = $Media
            toolbar     = $ToolBar
            header      = $Header
            body        = $Body
            expand      = $Expand
            footer      = $Footer
            style       = $Style
            elevation   = $Elevation

        }

        $Card.PSTypeNames.Insert(0, "UniversalDashboard.MaterialUI.Card") | Out-Null
        $Card
    }
}


function New-UDCardToolbar {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),

        [Parameter()]
        [string]$ClassName,

        [Parameter(Mandatory)]
        [scriptblock]$Content,

        [Parameter ()]
        [PSTypeName("UniversalDashboard.MaterialUI.Icon")]$Icon,
        
        [Parameter()]
        [object]$Title,


        [Parameter()]
        [Switch]$ShowButtons,

        [Parameter()]
        [Hashtable]$Style

    )
    End {

        $CardToolbar = @{
            type        = "mu-card-toolbar"
            isPlugin    = $true
            assetId     = $MUAssetId
            id          = $Id
            className   = $ClassName
            content     = & $Content
            title       = $Title
            style       = $Style
            icon        = $Icon
            showButtons = $ShowButtons.IsPresent
            # PSTypeName  = "UniversalDashboard.MaterialUI.CardToolbar"
        }
        $CardToolbar.PSTypeNames.Insert(0, "UniversalDashboard.MaterialUI.CardToolbar") | Out-Null
        $CardToolbar
    }
}
function New-UDCardHeader {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter()]
        [string]$Title,
        [Parameter()]
        [string]$SubHeader,
        [Parameter()]
        [ValidateSet('inherit', 'left', 'justify', 'right', 'center')]
        [string]$TitleAlignment = 'inherit',
        [Parameter()]
        [ValidateSet('inherit', 'left', 'justify', 'right', 'center')]
        [string]$SubHeaderAlignment = 'inherit'

    )
    End {
        $Header = @{
            type               = "mu-card-header"
            isPlugin           = $true
            assetId            = $MUAssetId
            id                 = $Id
            title              = $Title
            subheader          = $SubHeader
            subHeaderAlignment = $SubHeaderAlignment
            titleAlignment     = $TitleAlignment.ToLower()

        }
        $Header.PSTypeNames.Insert(0, "UniversalDashboard.MaterialUI.CardHeader") | Out-Null
        $Header
    }
}


function New-UDCardBody {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),

        [Parameter()]
        [string]$ClassName,

        [Parameter()]
        [scriptblock]$Content,

        [Parameter()]
        [Hashtable]$Style
    )
    End {

        $cContent = @{
            type      = "mu-card-body"
            isPlugin  = $true
            assetId   = $MUAssetId
            id        = $Id
            className = $ClassName
            content   = New-UDErrorBoundary -Content $Content
            style     = $Style
            # PSTypeName      = "UniversalDashboard.MaterialUI.CardContent"

        }
        $cContent.PSTypeNames.Insert(0, "UniversalDashboard.MaterialUI.CardBody") | Out-Null
        $cContent
    }
}


function New-UDCardExpand {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),

        [Parameter()]
        [string]$ClassName,

        [Parameter()]
        [scriptblock]$Content,

        [Parameter()]
        [Hashtable]$Style
    )
    End {
        $Expand = @{
            type            = "mu-card-expand"
            isPlugin        = $true
            assetId         = $MUAssetId
            id              = $Id
            className       = $ClassName
            content         = New-UDErrorBoundary -Content $Content
            style           = $Style
            isEndpoint      = $isEndPoint.IsPresent
            refreshInterval = $RefreshInterval
            autoRefresh     = $AutoRefresh.IsPresent
            # PSTypeName      = "UniversalDashboard.MaterialUI.CardExpand"
        }
        $Expand.PSTypeNames.Insert(0, "UniversalDashboard.MaterialUI.CardExpand") | Out-Null
        $Expand
    }
}


function New-UDCardFooter {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),

        [Parameter()]
        [string]$ClassName,

        [Parameter()]
        [scriptblock]$Content,

        [Parameter()]
        [Hashtable]$Style
    )
    End {
        $Footer = @{
            type            = "mu-card-footer"
            isPlugin        = $true
            assetId         = $MUAssetId
            id              = $Id
            className       = $ClassName
            content         = New-UDErrorBoundary -Content $Content
            style           = $Style
            isEndpoint      = $isEndPoint.IsPresent
            refreshInterval = $RefreshInterval
            autoRefresh     = $AutoRefresh.IsPresent
            # PSTypeName      = "UniversalDashboard.MaterialUI.CardFooter"
        }
        $Footer.PSTypeNames.Insert(0, "UniversalDashboard.MaterialUI.CardFooter") | Out-Null
        $Footer
    }
}
function New-UDCardMedia {
    [CmdletBinding()]
    [OutputType([Hashtable])]
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),

        [Parameter()]
        [ValidateSet("img", "video", "audio")]       
        [string]$Component = "img",

        [Parameter()]
        [string]$Alt,

        [Parameter()]
        [string]$Height,

        [Parameter (ParameterSetName = 'image')]
        [string]$Image,

        [Parameter()]
        [string]$Title,

        [Parameter(ParameterSetName = 'media')]
        [string]$Source

    )
    End {
        $CardMedia = @{
            type      = "mu-card-media"
            isPlugin  = $true
            assetId   = $MUAssetId
            id        = $Id
            component = $Component
            alt       = $Alt
            height    = $Height
            image     = $Image
            title     = $Title
            source    = $Source
            # PSTypeName = "UniversalDashboard.MaterialUI.CardMedia"
        }
        $CardMedia.PSTypeNames.Insert(0, "UniversalDashboard.MaterialUI.CardMedia") | Out-Null
        $CardMedia
    }
}