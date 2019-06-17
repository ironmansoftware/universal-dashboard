. (Join-Path $PSScriptRoot "utils.ps1")

$Colors = @{
    BackgroundColor = "#252525"
    FontColor = "#FFFFFF"
}

$AlternateColors = @{
    BackgroundColor = "#4081C9"
    FontColor = "#FFFFFF"
}

$ScriptColors = @{
    BackgroundColor = "#5A5A5A"
    FontColor = "#FFFFFF"
}

$NavBarLinks = @((New-UDLink -Text "Buy Universal Dashboard" -Url "https://ironmansoftware.com/product/powershell-universal-dashboard/" -Icon heart_o),
                 (New-UDLink -Text "Documentation" -Url "https://docs.universaldashboard.io" -Icon book))

function New-UDElementExample {
    param(
        [ScriptBlock]$Example
    )

    $Example.Invoke()

    New-UDRow -Columns {
        New-UDColumn -MediumSize 6 -SmallSize 12 -Content {
            New-UDElement -Tag "pre" -Content {
                $Example.ToString()
            } -Attributes @{
                style = @{
                    backgroundColor = $ScriptColors.BackgroundColor
                    color = $ScriptColors.FontColor
                    fontFamily = '"SFMono-Regular",Consolas,"Liberation Mono",Menlo,Courier,monospace'
                }
                width = "80vw"
            }
        }
    }
}

function New-UDCodeSnippet {
    param($Code) 
    
    New-UDElement -Tag "pre" -Content {
        $Code
    } -Attributes @{
        className = "white-text"
        style = @{
            backgroundColor = $ScriptColors.BackgroundColor
        }
    }
}

function New-UDHeader {
    param(
          [Parameter(ParameterSetName = "content")]
          [ScriptBlock]$Content, 
          [Parameter(ParameterSetName = "text")]
          [string]$Text,
          [Parameter()]
          [ValidateRange(1,6)]
          $Size, 
          [Parameter()]
          $Color)

    if ($PSCmdlet.ParameterSetName -eq "text") {
        New-UDElement -Tag "h$Size" -Content { $text } -Attributes @{
            style = @{
                color = $Color
            }
        } 
    } else {
        New-UDElement -Tag "h$Size" -Content $Content -Attributes @{
            style = @{
                color = $Color
            }
        } 
    }   
}

function New-UDExample {
    param($Title, $Description, $Script, [Switch]$NoRender) 

    New-UDRow -Columns {
        New-UDColumn -Size 2 {}
        New-UDColumn -Size 6 -Content {
            New-UDHeader -Text $Title -Size 2 -Color "white"
        }
    }

    New-UDRow -Columns {
        New-UDColumn -Size 2 {}
        New-UDColumn -Size 6 -Content {
            New-UDHeader -Text $Description -Size 5 -Color "white"
        }
    }
    
    if (-not $NoRender) {
        New-UDRow -Columns {
            New-UDColumn -Size 3 -Content { }
            New-UDColumn -Size 6 -Content {
                . $Script
            }
        }
    }

    New-UDRow -Columns {
        New-UDColumn -Size 2 -Content { }
        New-UDColumn -Size 8 -Content {
            New-UDCodeSnippet -Code ($Script.ToString())
        }
    }
}

function New-UDPageHeader {
    param($Title, $Icon, $Description, $DocLink)

    New-UDRow -Columns {
        New-UDColumn -Size 2 {}
        New-UDColumn -Size 8 -Content {
            New-UDHeader -Content {
                New-UDElement -Tag "i" -Attributes @{ className = "fa fa-$Icon" }
                "  $Title" 
            } -Size 1 -Color "white"

            New-UDHeader -Text $Description -Size 5 -Color "white"
            New-UDHeader -Content {
                New-UDElement -Tag "a" -Attributes @{ "href" = $DocLink } -Content {
                    New-UDElement -Tag "i" -Attributes @{ className = "fa fa-book" }
                    "  Documentation" 
                }
            } -Size 6 -Color "white"
            
        }
    }
}

$Pages = @()
$Pages += . (Join-Path $PSScriptRoot "pages\home.ps1")
$Pages += . (Join-Path $PSScriptRoot "pages\getting-started.ps1")
$Pages += . (Join-Path $PSScriptRoot "dashboards\azure.ps1")

$Components = @()
@('New-UDButton', 
  'New-UDCard', 
  'New-UDCheckbox', 
  "New-UDChart",
  'New-UDCollapsible',
  'New-UDCollection',
  'New-UDCounter',
  'New-UDElement',
  'New-UDFab',
  'New-UDGrid',
  'New-UDGridLayout',
  'New-UDHeading',
  'New-UDHtml',
  'New-UDIcon',
  'New-UDIFrame',
  'New-UDImage',
  'New-UDImageCarousel',
  'New-UDInput',
  'New-UDLink') | Sort-Object | ForEach-Object {
    $Page = New-UDComponentPage -Command $_
    $Components += New-UDSideNavItem -Text $_.Split('-')[1].Substring(2) -Url $_
    $Pages += $Page
} 

$Navigation = New-UDSideNav -Content {
    New-UDSideNavItem -Text "Home" -Url "Home" -Icon home
    New-UDSideNavItem -SubHeader -Text "Dashboards" -Children {
        New-UDSideNavItem -Text "Azure Resources" -Url "Azure" -Icon cloud
    }
    New-UDSideNavItem -SubHeader -Text "About Universal Dashboard" -Icon question -Children {
        New-UDSideNavItem -Text "Getting Started" -Url "Getting-Started"
        #New-UDSideNavItem -Text "Licensing" -Url "Licensing"
    }
    New-UDSideNavItem -SubHeader -Text "UI Components" -Icon window_maximize -Children {
        $Components 
    }
    # New-UDSideNavItem -SubHeader -Text "Utilities" -Icon wrench -Children {
    #     New-UDSideNavItem -Text "REST APIs" -Url "rest"
    #     New-UDSideNavItem -Text "Scheduled Endpoints" -Url "scheduled-endpoints"
    #     New-UDSideNavItem -Text "Published Folders" -Url "published-folders"
    # }
} -Fixed

$EndpointInitialization = New-UDEndpointInitialization -Function "New-UDComponentExample"

New-UDDashboard -NavbarLinks $NavBarLinks -Title "PowerShell Universal Dashboard" -Pages $Pages -Footer $Footer -Navigation $Navigation -EndpointInitialization $EndpointInitialization
