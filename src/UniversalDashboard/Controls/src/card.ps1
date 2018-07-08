function New-UDCard {
    [CmdletBinding(DefaultParameterSetName = 'text')]
    param(
        [Parameter()]
        [String]$Id = (New-Guid),
        [Parameter()]
        [String]$Title,
        [Parameter(ParameterSetName = 'content')]
        [ScriptBlock]$Content,
        [Parameter()]
        [Parameter(ParameterSetName = 'text')]
        [string]$Text,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$BackgroundColor = 'white',
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$FontColor = 'black',
        [Parameter()]
        [UniversalDashboard.Models.Link[]]$Links,
        [Parameter()]
        [UniversalDashboard.Models.Basics.Element]$Image,
        [Parameter()]
        [ScriptBlock]$Reveal,
        [Parameter()]
        [String]$RevealTitle,
        [Parameter()]
        [ValidateSet('small', 'medium', 'large')]
        [String]$Size,
        [Parameter()]
        [String]$Language,
        [Parameter()]
        [ValidateSet('left', 'center', 'right')]
        [String]$TextAlignment = 'left',
        [ValidateSet('Small', 'Medium', 'Large')]
        [String]$TextSize = 'Small'
        
    )

    $activatorClass = ''
    if ($Reveal -ne $null) {
        $activatorClass = 'activator'
    }

    $sizeClass = ''
    if ($PSBoundParameters.ContainsKey('Size')) {
        $sizeClass = $Size
    }

    $style = @{
        backgroundColor = $BackgroundColor.HtmlColor
        color = $FontColor.HtmlColor
    }

    New-UDElement -Tag "div" -Id $Id -Attributes @{ className = "card $sizeClass"; style = $style  } -Content {
        if ($Image -ne $null) {
            New-UDElement -Tag 'div' -Attributes @{ className = "card-image waves-effect waves-block waves-light" } -Content {
                $Image
            }
        }

        New-UDElement -Tag "div" -Attributes @{ className = 'card-content' } -Content {
            New-UDElement -Tag 'span' -Attributes @{ className = "card-title $activatorClass" } -Content { 
                $Title 

                if ($Reveal -ne $null) {
                    New-UDElement -Tag 'i' -Attributes @{ className = 'fa fa-ellipsis-v right'}
                }
            }

            New-UDElement -Tag "div" -Attributes @{ className = "$TextAlignment-align" } -Content {
                $TextContent = {
                    if ($PSCmdlet.ParameterSetName -eq 'content') {
                        $Content.Invoke()
                    } else {
                        $Text
                    }
                }

                switch($TextSize) {
                    "Small" { $TextContent.Invoke() }
                    "Medium" { New-UDHeading -Size 5 -Content $TextContent }
                    "Largin" { New-UDHeading -Size 3 -Text $TextContent }
                }
            }
        }

        if ($Links -ne $null) {
            New-UDElement -Tag 'div' -Attributes @{ className = 'card-action' } -Content {
                $Links
            }
        }

        if ($Reveal -ne $null) {
            New-UDElement -Tag 'div' -Attributes @{ className = 'card-reveal' } -Content {
                New-UDElement -Tag 'span' -Attributes @{ className = 'card-title' } -Content { 
                    $Title 
                    New-UDElement -Tag 'i' -Attributes @{ className = 'fa fa-times right'}
                }
                $Reveal.Invoke()
            }
        }
    }
}