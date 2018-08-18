function New-UDCard {
    [CmdletBinding(DefaultParameterSetName = 'text')]
    param(
        [Parameter()]
        [String]$Id = (New-Guid),
        [Parameter()]
        [String]$Title,
        [Parameter(ParameterSetName = 'content')]
        [ScriptBlock]$Content,
        [Parameter(ParameterSetName = 'endpoint')]
        [object]$Endpoint,
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
        [Parameter()]
        [ValidateSet('Small', 'Medium', 'Large')]
        [String]$TextSize = 'Small',
        [Parameter()]
        [UniversalDashboard.Models.FontAwesomeIcons]$Watermark
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

            if ($PSBoundParameters.Keys.Contains("Watermark")) {
                New-UDElement -Tag "i" -Attributes @{
                    className = "fa fa-" + $Watermark.ToString().Replace("_", "-")
                    style = @{ 
                        opacity = 0.05
                        float= 'left'
                        marginLeft = '70px'
                        fontSize = '6em'
                        position = 'absolute'
                        top = '20px'
                        color = $FontColor.HtmlColor
                    }
                }
            }

            $ParameterSet = $PSCmdlet.ParameterSetName 
            if ($ParameterSet -eq 'endpoint') {
                New-UDElement -Tag "div" -Attributes @{ className = "$TextAlignment-align" } -Endpoint $Endpoint
            } else {
                New-UDElement -Tag "div" -Attributes @{ className = "$TextAlignment-align" } -Content {
                    $TextContent = {
                        if ($ParameterSet -eq 'content') {
                            $Content.Invoke()
                        } elseif ($ParameterSet -eq 'text') {
                            $Text -split "`r`n" | ForEach-Object {
                                $_
                                New-UDElement -Tag "br"
                            }
                        } 
                    }
    
                    switch($TextSize) {
                        "Small" { $TextContent.Invoke() }
                        "Medium" { New-UDHeading -Size 5 -Content $TextContent }
                        "Large" { New-UDHeading -Size 3 -Content $TextContent }
                    }
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