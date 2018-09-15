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

$NavBarLinks = @((New-UDLink -Text "Buy Universal Dashboard" -Url "https://ironmansoftware.com/universal-dashboard/" -Icon heart_o),
                 (New-UDLink -Text "Documentation" -Url "https://www.gitbook.com/book/adamdriscoll/powershell-universal-dashboard/details" -Icon book))

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
                width = "100%"
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

Get-ChildItem (Join-Path $PSScriptRoot "pages") -Exclude "home.ps1" | ForEach-Object {
    $Pages += . $_.FullName
}

New-UDDashboard -NavbarLinks $NavBarLinks -Title "PowerShell Universal Dashboard" -NavBarColor '#FF1c1c1c' -NavBarFontColor "#FF55b3ff" -BackgroundColor "#FF333333" -FontColor "#FFFFFFF" -Pages $Pages -Footer $Footer -FontIconStyle FontAwesome
