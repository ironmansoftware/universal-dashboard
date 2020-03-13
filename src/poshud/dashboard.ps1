function New-ComponentPage {
    param(
        [Parameter(Mandatory)]
        [string]$Title, 
        [Parameter(Mandatory)]
        [string]$Description, 
        [Parameter(Mandatory)]
        [string]$SecondDescription, 
        [Parameter(Mandatory)]
        [ScriptBlock]$Content,
        [Parameter(Mandatory)] 
        [string]$Cmdlet) 

    New-UDPage -Name $Title -Content {
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

        & $Content

        $Parameters = (Get-Command $Cmdlet).Parameters.GetEnumerator() | ForEach-Object {
            $Parameter = $_.Key

            $Help = Get-Help -Name $Cmdlet -Parameter $Parameter

            @{
                name = $Help.name 
                type = $Help.type.name
                description = $Help.description.text
                required = $Help.required
            }
        }

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

        New-UDTable -Title 'Parameters' -Data $Parameters -Columns $Columns
    }
}

function New-Example {
    param($Title, $Description, [ScriptBlock]$Example)

    New-UDElement -tag 'div' -Attributes @{ style = @{ marginTop = '20px' }} -Content { }

    New-UDTypography -Text $Title -Variant 'h4'
    New-UDElement -Tag 'div' -Content { $Description }

    New-UDPaper -Children {
        & $Example 
    }

    New-UDPaper -Children {
        New-UDElement -Tag 'pre' -Content { $Example.ToString().Trim() }
    }
}

function New-AppBar {
    param($title)

    $Drawer = New-UDDrawer -Children {
        New-UDList -Children {
            New-UDListItem -Label "Home"
            New-UDListItem -Label "Getting Started" -Children {
                New-UDListItem -Label "Installation" -OnClick {}
                New-UDListItem -Label "Usage" -OnClick {}
                New-UDListItem -Label "FAQs" -OnClick {}
                New-UDListItem -Label "System Requirements" -OnClick {}
                New-UDListItem -Label "Purchasing" -OnClick {}
            }
            New-UDListItem -Label "Components" -Children {
                New-UDListItem -Label "AppBar" -OnClick { Invoke-UDRedirect -Url "/appbar" }
                New-UDListItem -Label "Avatar" -OnClick {} 
                New-UDListItem -Label "Button" -OnClick { Invoke-UDRedirect -Url "/button" }
                New-UDListItem -Label "Card" -OnClick {}
                New-UDListItem -Label "Checkbox" -OnClick {}
                New-UDListItem -Label "Chips" -OnClick {}
                New-UDListItem -Label "Date Picker" -OnClick {}
                New-UDListItem -Label "Drawer" -OnClick {}
                New-UDListItem -Label "Expansion Panel" -OnClick {}
                New-UDListItem -Label "Floating Action Button" -OnClick {}
                New-UDListItem -Label "Form" -OnClick {}
                New-UDListItem -Label "Grid" -OnClick {}
                New-UDListItem -Label "Icon" -OnClick {}
                New-UDListItem -Label "Icon Button" -OnClick {}
                New-UDListItem -Label "Link" -OnClick {}
                New-UDListItem -Label "List" -OnClick {}
                New-UDListItem -Label "Paper" -OnClick {}
                New-UDListItem -Label "Progress" -OnClick {}
                New-UDListItem -Label "Radio" -OnClick {}
                New-UDListItem -Label "Select" -OnClick {}
                New-UDListItem -Label "Switch" -OnClick {}
                New-UDListItem -Label "Table" -OnClick {}
                New-UDListItem -Label "Tabs" -OnClick {}
                New-UDListItem -Label "Textbox" -OnClick {}
                New-UDListItem -Label "Time Picker" -OnClick {}
                New-UDListItem -Label "Tree View" -OnClick {}
                New-UDListItem -Label "Typography" -OnClick {}
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

$Pages += New-ComponentPage -Title 'AppBar' `
    -Description 'The App Bar displays information and actions relating to the current screen.' `
    -SecondDescription "The top App Bar provides content and actions related to the current screen. It's used for branding, screen titles, navigation, and actions." -Content {

    New-Example -Title 'AppBar with Custom Drawer' -Example {
        $Drawer = New-UDDrawer -Children {
            New-UDList -Children {
                New-UDListItem -Label "Home"
                New-UDListItem -Label "Getting Started" -Children {
                    New-UDListItem -Label "Installation" -OnClick {}
                    New-UDListItem -Label "Usage" -OnClick {}
                    New-UDListItem -Label "FAQs" -OnClick {}
                    New-UDListItem -Label "System Requirements" -OnClick {}
                    New-UDListItem -Label "Purchasing" -OnClick {}
                }
            }
        }

        New-UDAppBar -Position relative -Children { New-UDElement -Tag 'div' -Content { "Title" } } -Drawer $Drawer
    }
} -Cmdlet 'New-UDAppBar'

$Pages += New-ComponentPage -Title 'Button' -Description 'Buttons allow users to take actions, and make choices, with a single tap.' -SecondDescription 'asdfasfas' -Content {
    New-Example -Title 'Contained Button' -Description 'Contained buttons are high-emphasis, distinguished by their use of elevation and fill. They contain actions that are primary to your app.' -Example {
        New-UDButton -Variant 'contained' -Text 'Default'
    }

    New-Example -Title 'Outlined Button' -Description "Outlined buttons are medium-emphasis buttons. They contain actions that are important, but aren’t the primary action in an app.

    Outlined buttons are also a lower emphasis alternative to contained buttons, or a higher emphasis alternative to text buttons." -Example {
        New-UDButton -Variant 'outlined' -Text 'Default' 
    }

    New-Example -Title 'Buttons with icons and label' -Description 'Sometimes you might want to have icons for certain button to enhance the UX of the application as we recognize logos more easily than plain text. For example, if you have a delete button you can label it with a dustbin icon.' -Example {
        New-UDButton -Icon (New-UDIcon -Icon trash) -Text 'Delete'
    }

    New-Example -Title 'Buttons with event handlers' -Description 'You can specify a script block to execute when the button is clicked' -Example {
New-UDButton -Text 'Message Box' -OnClick {
    Show-UDToast -Message 'Hello, world!'
}
    }
} -Cmdlet "New-UDButton"

New-UDDashboard -Title "PowerShell Universal Dashboard" -Pages $Pages