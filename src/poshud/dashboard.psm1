$Cache:Enterprise = $null -ne (Get-Module UniversalDashboard -ErrorAction SilentlyContinue)
$Cache:Help = @{}
function New-ComponentPage {
    param(
        [Parameter(Mandatory)]
        [string]$Title, 
        [Parameter(Mandatory)]
        [string]$Description, 
        [Parameter()]
        [string]$SecondDescription, 
        [Parameter(Mandatory)]
        [ScriptBlock]$Content,
        [Parameter(Mandatory)] 
        [string[]]$Cmdlet,
        [Parameter()]
        [Switch]$Enterprise
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

            if ($Enterprise)
            {
                New-UDButton -Text 'Premium or Enterprise License Required' -Icon (New-UDIcon -Icon Rocket) -Variant 'contained' -OnClick {
                    Invoke-UDRedirect -Url "https://www.ironmansoftware.com/powershell-universal-dashboard" -OpenInNewWindow
                }
            }
        
            New-UDElement -tag 'div' -Attributes @{ style = @{ marginTop = '20px' }} -Content {
                New-UDElement -Tag 'div' -Content { $SecondDescription }
            }
    
            & $Content
    
            $Columns = @(
                New-UDTableColumn -Title 'Name' -Property 'name' 
                New-UDTableColumn -Title 'Type' -Property 'type' 
                New-UDTableColumn -Title 'Description' -Property 'description' -Render {
                    $Row = $Body | ConvertFrom-Json 
                    if ($Row.description)
                    {
                        New-UDTypography -Text $Row.description
                    }
                    else 
                    {
                        New-UDElement -tag 'div' -Content {}
                    }
                }
                New-UDTableColumn -Title 'Required' -Property 'required' 
            )
    
            New-UDElement -Tag 'div' -Attributes @{ style = @{ marginTop = "20px"; marginBottom = "20px"}} -Content {
                New-UDTypography -Text 'Parameters' -Variant h4
            }
    
            New-UDDynamic -Content {
                foreach($item in $Cmdlet)
                {
                    if ($Cache:Help.ContainsKey($item)) {
                        $Parameters = $Cache:Help[$item]
                    }
                    else 
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
                        $Cache:Help[$item] = $Parameters
                    }
                    
                    if ($Parameters)
                    {
                        New-UDTable -Title $item -Data $Parameters -Columns $Columns
                    }
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

    New-UDPaper -Children {
        New-UDElement -tag 'div' -Attributes @{
            style = @{
                minHeight = '100px'
                width = '100%'
            }
        } -Content {
            & $Example 
        }
    }

    New-UDPaper -Children {
        New-UDElement -Tag 'pre' -Content { $Example.ToString().Trim() }
    }
}

function New-AppBar {
    param($title)

    $Drawer = New-UDDrawer -Children {
        New-UDList -Children {
            New-UDListItem -Label "Home" -OnClick { Invoke-UDRedirect -Url "/powershell-universal-dashboard" }
            New-UDListItem -Label "Getting Started" -Children {
                New-UDListItem -Label "Installation" -OnClick {}
                New-UDListItem -Label "Usage" -OnClick {}
                New-UDListItem -Label "FAQs" -OnClick {}
                New-UDListItem -Label "System Requirements" -OnClick {}
                New-UDListItem -Label "Purchasing" -OnClick {}
            }
            New-UDListItem -Label "Components" -Children {
                New-UDListItem -Label "Layout" -Children {
                    New-UDListItem -Label "Container" -OnClick { Invoke-UDRedirect -Url '/container' }
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
                    if ($Cache:Enterprise)
                    {
                        New-UDListItem -Label 'Nivo' -Children {
                            New-UDListItem -Label "Overview" -OnClick { Invoke-UDRedirect -Url '/nivo' }
                            New-UDListItem -Label "Bar" -OnClick { Invoke-UDRedirect -Url '/nivo-bar' }
                        }
                        New-UDListItem -Label "Sparklines" -OnClick { Invoke-UDRedirect -Url '/sparklines' }
                    }
                }
            }
            New-UDListItem -Label "Security" -Children {
                New-UDListItem -Label "Authorization" -OnClick {} 
                New-UDLIstItem -Label "Authentication" -Children {
                    New-UDListItem -Label "AzureAD" -OnClick {} 
                    New-UDListItem -Label "Forms" -OnClick {} 
                    New-UDListItem -Label "JSON Web Tokens" -OnClick {} 
                    New-UDListItem -Label "OpenID Connect" -OnClick {} 
                    New-UDListItem -Label "OAuth" -OnClick {} 
                    New-UDListItem -Label "Windows" -OnClick {} 
                    New-UDListItem -Label "WS-Federation" -OnClick {} 
                }
                New-UDListItem -Label "Login Pages" -OnClick {} 
            }
            New-UDListItem -Label "Web Server" -Children {
                New-UDListItem -Label "Published Folders" -OnClick {}
                New-UDListItem -Label "Hosting" -Children {
                    New-UDListItem -Label "Azure" -OnClick {}
                    New-UDListItem -Label "IIS" -OnClick {}
                    New-UDListItem -Label "Windows Service" -OnClick {}
                }
                New-UDListItem -Label "REST APIs" -OnClick {}
            }
        }
    }
    
    New-UDAppbar -Children {
        New-UDElement -Tag 'div' -Content {$title}
    } -Drawer $Drawer
}

$Pages = @()
$Pages += New-UDPage -Name "PowerShell Universal Dashboard" -Content {
    New-AppBar -Title "PowerShell Universal Dashboard"
    New-UDElement -Tag 'div' -Attributes @{ style = @{ paddingTop = '20px'}} -Content {}
    New-UDGrid -Container -Content {
        New-UDGrid -Item -SmallSize 3 -Content {
            New-UDImage -Url 'https://github.com/ironmansoftware/universal-dashboard/raw/master/images/logo.png'
        }
        New-UDGrid -Item -SmallSize 9 -Content { 
            New-UDTypography -Text 'PowerShell Universal Dashboard' -Variant h2 
            New-UDTypography -Text "The most popular web framework for PowerShell" -Variant h4
            New-UDButton -Variant outlined -Text "Get Started" -OnClick { Invoke-UDRedirect -Url "/get-started" }
        }
    }

    New-UDGrid -Container -Content {
        New-UDGrid -Item -SmallSize 6 -Content {
            New-UDCard -Title "Installation" -Content {
                New-UDTypography -Text "Universal Dashboard can be installed from the PowerShell Gallery" -Paragraph
                New-UDElement -Tag pre -Content { "Install-Module UniversalDashboard" }
            } 
        }

        New-UDGrid -Item -SmallSize 6 -Content {
            New-UDCard -Title "Usage" -Content {
                New-UDTypography -Text "To start Universal Dashboard, you can just use the Start-UDDashboard cmdlet." -Paragraph
                New-UDElement -tag 'p' -Content {}
                New-UDElement -Tag pre -Content { "Import-Module UniversalDashboard
Start-UDDashboard -Port 10000
Start-Process http://localhost:10000" }
            }
        }
    }
}

Get-ChildItem (Join-Path $PSScriptRoot "pages") -Recurse -File | ForEach-Object {
    $Page = . $_.FullName
    $Pages += $Page
}

function New-DemoDashboard {
    New-UDDashboard -Title "PowerShell Universal Dashboard" -Pages $Pages
}