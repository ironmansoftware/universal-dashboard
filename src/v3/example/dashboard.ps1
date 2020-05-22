$DebugPreference = 'Continue'
function New-ComponentPage {
    param(
        [Parameter(Mandatory)]
        [string]$Description, 
        [Parameter(Mandatory)]
        [string]$Title, 
        [Parameter()]
        [string]$SecondDescription, 
        [Parameter(Mandatory)]
        [ScriptBlock]$Content,
        [Parameter(Mandatory)] 
        [string[]]$Cmdlet
        ) 

    New-UDPage -Name $Title -Content {
        New-UDContainer {
            New-AppBar -Title $title
            
            New-UDElement -tag 'div' -Attributes @{ style = @{ marginTop = '20px' }} -Content {
                New-UDTypography -Text $Title -Variant 'h2' 
            }
        
            New-UDElement -tag 'div' -Attributes @{ style = @{ marginTop = '20px' }} -Content {
                New-UDTypography -Text $Description -Variant 'h4'
            }

            New-UDElement -tag 'div' -Attributes @{ style = @{ marginTop = '20px' }} -Content {
                New-UDElement -Tag 'div' -Content { $SecondDescription }
            }
    
            Invoke-Expression $Content.ToString()
    
            $Columns = @(
                New-UDTableColumn -Title 'Name' -Property 'name' 
                New-UDTableColumn -Title 'Type' -Property 'type' 
                New-UDTableColumn -Title 'Description' -Property 'description'
                New-UDTableColumn -Title 'Required' -Property 'required' 
            )
    
            New-UDElement -Tag 'div' -Attributes @{ style = @{ marginTop = "20px"; marginBottom = "20px"}} -Content {
                New-UDTypography -Text 'Parameters' -Variant h4
            }
    
            foreach($item in $Cmdlet)
            {
                $Parameters = (Get-Command $item).Parameters.GetEnumerator() | ForEach-Object {
                    
                    $Parameter = $_.Key

                    $Help = Get-Help -Name $item -Parameter $Parameter -ErrorAction SilentlyContinue
                    
                    if ($null -ne $Help)
                    {
                        @{
                            name = $Help.name 
                            type = $Help.type.name
                            description = $Help.description.text
                            required = $Help.required
                        }
                    }
                }
                 
                if ($Parameters)
                {
                    New-UDTable -Title $item -Data $Parameters -Columns $Columns
                }
            }
        }
    }
}

function New-Example {
    param($Title, $Description, [ScriptBlock]$Example)

    New-UDElement -tag 'div' -Attributes @{ style = @{ marginTop = '20px' }} -Content { }

    New-UDTypography -Text $Title -Variant 'h4'
    New-UDElement -Tag 'div' -Content { $Description }

    New-UDCard -Content {
        New-UDElement -tag 'div' -Attributes @{
            style = @{
                minHeight = '100px'
                width = '100%'
            }
        } -Content $Example
    }

    New-UDCard -Content {
        New-UDElement -Tag 'pre' -Content { $Example.ToString().Trim() }
    }
}

function New-AppBar {
    param($title, [Switch]$NoPadding)

    $Drawer = New-UDDrawer -Children {
        New-UDList -Children {
            New-UDListItem -Label "Home" -OnClick { Invoke-UDRedirect -Url "/powershell-universal-dashboard" }
            New-UDListItem -Label "Layout" -Children {
                <#New-UDListItem -Label "Container" -OnClick { Invoke-UDRedirect -Url '/container' }#>
                New-UDListItem -Label "Grid" -OnClick { Invoke-UDRedirect -Url '/grid' }
            }
            New-UDListItem -Label "Inputs" -Children {
                New-UDListItem -Label "Autocomplete" -OnClick { Invoke-UDRedirect -Url '/autocomplete' } 
                New-UDListItem -Label "Button" -OnClick { Invoke-UDRedirect -Url "/button" }
                New-UDListItem -Label "Checkbox" -OnClick { Invoke-UDRedirect -Url '/checkbox' }
                New-UDListItem -Label "Date Picker" -OnClick { Invoke-UDRedirect -Url '/date-picker' }
                New-UDListItem -Label "Floating Action Button" -OnClick { Invoke-UDRedirect -Url '/floating-action-button' }
                New-UDListItem -Label "Form" -OnClick { Invoke-UDRedirect -Url '/form' }
                New-UDListItem -Label "Icon Button" -OnClick {}
                New-UDListItem -Label "Radio" -OnClick { Invoke-UDRedirect -Url '/radio' }
                New-UDListItem -Label "Select" -OnClick { Invoke-UDRedirect -Url '/select'}
                New-UDListItem -Label "Slider" -OnClick { Invoke-UDRedirect -Url '/slider'}
                New-UDListItem -Label "Switch" -OnClick { Invoke-UDRedirect -Url '/switch'}
                New-UDListItem -Label "Textbox" -OnClick { Invoke-UDRedirect -Url '/textbox' }
                New-UDListItem -Label "Time Picker" -OnClick { Invoke-UDRedirect -Url '/time-picker' }
            }
            New-UDListItem -Label "Navigation" -Children {
                New-UDListItem -Label "Drawer" -OnClick {}
                New-UDListItem -Label "Link" -OnClick {}
                New-UDListItem -Label "Stepper" -OnClick { Invoke-UDRedirect -Url '/stepper' }
                New-UDListItem -Label "Tabs" -OnClick { Invoke-UDRedirect -Url '/tabs' }
            }
            New-UDListItem -Label "Surfaces" -Children {
                New-UDListItem -Label "AppBar" -OnClick { Invoke-UDRedirect -Url "/appbar" }
                New-UDListItem -Label "Card" -OnClick { Invoke-UDRedirect -Url '/card' }
                New-UDListItem -Label "Paper" -OnClick { Invoke-UDRedirect -Url '/paper' }
                New-UDListItem -Label "Expansion Panel" -OnClick { Invoke-UDRedirect -Url '/expansion-panel' }
            }
            New-UDListItem -Label "Feedback" -Children {
                New-UDListItem -Label "Modal" -OnClick { Invoke-UDRedirect -Url '/modal' }
                New-UDListItem -Label "Progress" -OnClick { Invoke-UDRedirect -Url '/progress' }
                #TODO: toast
            }
            New-UDListItem -Label "Data Display" -Children {
                New-UDListItem -Label "Avatar" -OnClick { Invoke-UDRedirect -Url '/avatar' } 
                New-UDListItem -Label "Chips" -OnClick {  Invoke-UDRedirect -Url '/chips'  }
                New-UDListItem -Label "Icons" -OnClick { Invoke-UDRedirect -Url '/icons' }
                New-UDListItem -Label "List" -OnClick { Invoke-UDRedirect -Url '/list' }
                New-UDListItem -Label "Table" -OnClick { Invoke-UDRedirect -Url '/table' }
                New-UDListItem -Label "Tree View" -OnClick { Invoke-UDRedirect -Url '/tree-view' }
                New-UDListItem -Label "Typography" -OnClick { Invoke-UDRedirect -Url '/typography' }
            }
            New-UDListItem -Label "Data Visualization" -Children {
                New-UDListItem -Label 'Nivo' -Children {
                    New-UDListItem -Label "Overview" -OnClick { Invoke-UDRedirect -Url '/nivo' }
                    New-UDListItem -Label "Bar" -OnClick { Invoke-UDRedirect -Url '/nivo-bar' }
                    New-UDListItem -Label "Calendar" -OnClick { Invoke-UDRedirect -Url '/nivo-calendar' }
                    New-UDListItem -Label "Heatmap" -OnClick { Invoke-UDRedirect -Url '/nivo-heatmap' }
                    New-UDListItem -Label "Line" -OnClick { Invoke-UDRedirect -Url '/nivo-line' }
                    New-UDListItem -Label "Stream" -OnClick { Invoke-UDRedirect -Url '/nivo-stream' }
                    New-UDListItem -Label "Treemap" -OnClick { Invoke-UDRedirect -Url '/nivo-treemap' }
                }
                New-UDListItem -Label "Sparklines" -OnClick { Invoke-UDRedirect -Url '/sparklines' }
            }
        }
    }
    
    New-UDAppbar -Children {
        New-UDElement -Tag 'div' -Content {$title}
    } -Drawer $Drawer

    if (-not $NoPadding) {
        New-UDElement -Tag 'div' -Attributes @{ style = @{ paddingTop = '20px'}} -Content {}
    }   
}

$Pages = @()
$Pages += New-UDPage @AdditionalParameters -Name "PowerShell Universal Dashboard" -Content {
    
    New-AppBar -Title "PowerShell Universal Dashboard" -NoPadding

    New-UDElement -Tag 'div' -Content {
        New-UDContainer {
            New-UDGrid -Container -Content {
                New-UDGrid -Item -SmallSize 3 -Content {
                    New-UDImage -Url 'https://github.com/ironmansoftware/universal-dashboard/raw/master/images/logo.png' -Height 128
                }
                New-UDGrid -Item -SmallSize 9 -Content { 
                    New-UDTypography -Text 'PowerShell Universal Dashboard' -Variant h2 
                    New-UDTypography -Text "The most popular web framework for PowerShell" -Variant h4
                }
            }
        }
    } -Attributes @{
        style = @{
            width = '100%'
            backgroundColor = 'white'
            paddingBottom = '20px'
            paddingTop = '20px'
        }
    }

    New-UDContainer {
        New-UDElement -Tag 'div' -Content {
        
        } -Attributes @{
            style = @{
                height = '25px'
            }
        }

        New-UDTypography -Text "Get Started" -Variant h2 

        New-UDGrid -Container -Content {
            New-UDGrid -Item -SmallSize 6 -Content {
                New-UDCard -Title "Installation" -Content {
                    New-UDElement -Tag p -Content {
                        New-UDTypography -Text "Universal Dashboard is included with the PowerShell Universal installer" -Paragraph
                    }
                    New-UDElement -Tag p -Content {
                        New-UDButton -Variant outlined -Text "Download" -OnClick { Invoke-UDRedirect -Url "https://www.ironmansoftware.com/downloads" }
                    }
                }
            }

            New-UDGrid -Item -SmallSize 6 -Content {
                New-UDCard -Title "Documentation" -Content {
                    New-UDElement -Tag p -Content {
                        New-UDTypography -Text "Learn how to get up and running witrh PowerShell Universal" -Paragraph
                        New-UDButton -Variant outlined -Text "Learn More" -OnClick { Invoke-UDRedirect -Url "https://docs.ironmansoftware.com/getting-started" }
                    }
                }
            }

            New-UDGrid -Item -SmallSize 6 -Content {
                New-UDCard -Title "Marketplace" -Content {
                    New-UDElement -Tag p -Content {
                        New-UDTypography -Text "Access a huge collection of community contributed controls and dashboards." -Paragraph
                    }
                    New-UDElement -Tag p -Content {
                        New-UDButton -Variant outlined -Text "Learn More" -OnClick { Invoke-UDRedirect -Url "https://marketplace.universaldashboard.io" }
                    }
                }
            }

            New-UDGrid -Item -SmallSize 6 -Content {
                New-UDCard -Title "PowerShell Universal" -Content {
                    New-UDElement -Tag p -Content {
                        New-UDTypography -Text "PowerShell Universal Dashboard is now part of the PowerShell Universal platform. " -Paragraph
                    }
                    New-UDElement -Tag p -Content {
                        New-UDButton -Variant outlined -Text "Learn More" -OnClick { Invoke-UDRedirect -Url "https://ironmansoftware.com/ud-ua-powershell-universal/" }
                    }
                }
            }
        }
    }
}

Get-ChildItem (Join-Path $PSScriptRoot "pages") -Recurse -File | ForEach-Object {
    $Page = . $_.FullName
    $Pages += $Page
}

New-UDDashboard -Title "PowerShell Universal Dashboard" -Pages $Pages