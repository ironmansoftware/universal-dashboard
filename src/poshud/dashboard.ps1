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
        [string[]]$Cmdlet) 

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

        foreach($item in $Cmdlet)
        {
            $Parameters = (Get-Command $item).Parameters.GetEnumerator() | ForEach-Object {
                $Parameter = $_.Key
    
                $Help = Get-Help -Name $item -Parameter $Parameter
    
                @{
                    name = $Help.name 
                    type = $Help.type.name
                    description = $Help.description.text
                    required = $Help.required
                }
            }

            New-UDTable -Title $item -Data $Parameters -Columns $Columns
        }   
    }
}

function New-Example {
    param($Title, $Description, [ScriptBlock]$Example)

    New-UDElement -tag 'div' -Attributes @{ style = @{ marginTop = '20px' }} -Content { }

    New-UDTypography -Text $Title -Variant 'h4'
    New-UDElement -Tag 'div' -Content { $Description }

    New-UDPaper -Children {
        & $Example 
    } -Elevation 2

    New-UDPaper -Children {
        New-UDElement -Tag 'pre' -Content { $Example.ToString().Trim() }
    } -Elevation 2
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
                New-UDListItem -Label "AppBar" -OnClick { Invoke-UDRedirect -Url "/appbar" }
                New-UDListItem -Label "Avatar" -OnClick { Invoke-UDRedirect -Url '/avatar' } 
                New-UDListItem -Label "Button" -OnClick { Invoke-UDRedirect -Url "/button" }
                New-UDListItem -Label "Card" -OnClick { Invoke-UDRedirect -Url '/card' }
                New-UDListItem -Label "Checkbox" -OnClick { Invoke-UDRedirect -Url '/checkbox' }
                New-UDListItem -Label "Chips" -OnClick {  Invoke-UDRedirect -Url '/chips'  }
                New-UDListItem -Label "Date Picker" -OnClick { Invoke-UDRedirect -Url '/date-picker' }
                New-UDListItem -Label "Drawer" -OnClick { Invoke-UDRedirect -Url '/appbar' }
                New-UDListItem -Label "Expansion Panel" -OnClick { Invoke-UDRedirect -Url '/expansion-panel' }
                New-UDListItem -Label "Floating Action Button" -OnClick { Invoke-UDRedirect -Url '/floating-action-button' }
                New-UDListItem -Label "Form" -OnClick { Invoke-UDRedirect -Url '/form' }
                New-UDListItem -Label "Grid" -OnClick { Invoke-UDRedirect -Url '/grid' }
                New-UDListItem -Label "Icons" -OnClick { Invoke-UDRedirect -Url '/icons' }
                New-UDListItem -Label "Icon Button" -OnClick { Invoke-UDRedirect -Url '/icon-button' }
                New-UDListItem -Label "Link" -OnClick { Invoke-UDRedirect -Url '/link' }
                New-UDListItem -Label "List" -OnClick { Invoke-UDRedirect -Url '/list' }
                New-UDListItem -Label "Monitor" -OnClick { Invoke-UDRedirect -Url '/monitor' }
                New-UDListItem -Label "Paper" -OnClick { Invoke-UDRedirect -Url '/paper' }
                New-UDListItem -Label "Progress" -OnClick { Invoke-UDRedirect -Url '/progress' }
                New-UDListItem -Label "Radio" -OnClick { Invoke-UDRedirect -Url '/radio' }
                New-UDListItem -Label "Select" -OnClick { Invoke-UDRedirect -Url '/select'}
                New-UDListItem -Label "Switch" -OnClick { Invoke-UDRedirect -Url '/switch'}
                New-UDListItem -Label "Table" -OnClick { Invoke-UDRedirect -Url '/table' }
                New-UDListItem -Label "Tabs" -OnClick { Invoke-UDRedirect -Url '/tabs' }
                New-UDListItem -Label "Textbox" -OnClick { Invoke-UDRedirect -Url '/textbox' }
                New-UDListItem -Label "Time Picker" -OnClick { Invoke-UDRedirect -Url '/time-picker' }
                New-UDListItem -Label "Tree View" -OnClick { Invoke-UDRedirect -Url '/tree-view' }
                New-UDListItem -Label "Typography" -OnClick { Invoke-UDRedirect -Url '/typography' }
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
        New-UDTypography -Text $title -Variant h4
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
                New-UDTypography -Text "Universal Dashboard can be installed from the PowerShell Gallery" 
                New-UDElement -Tag pre -Content { "Install-Module UniversalDashboard" }
            } 
        }

        New-UDGrid -Item -SmallSize 6 -Content {
            New-UDCard -Title "Usage" -Content {
                New-UDTypography -Text "To start Universal Dashboard, you can just use the Start-UDDashboard cmdlet."
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

$Pages += New-ComponentPage -Title 'Avatar' `
    -Description 'Avatars are found throughout material design with uses in everything from tables to dialog menus.' `
    -SecondDescription "" -Content {

    New-Example -Title 'Avatar' -Example {
        New-UDAvatar -Image 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4' -Alt 'alon gvili avatar' -Id 'avatarContent' -Variant small

        New-UDAvatar -Image 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4' -Alt 'alon gvili avatar' -Id 'avatarStyle' -Variant medium

        $AvatarProps = @{
            Image = 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4'
            Alt = 'alon gvili avatar'
            Id = 'avatarSquare'
            variant = 'large'
        }
        New-UDAvatar @AvatarProps 
    }
} -Cmdlet 'New-UDAvatar'

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


$Pages += New-ComponentPage -Title 'Card' -Description 'Cards contain content and actions about a single subject.' -SecondDescription "Cards are surfaces that display content and actions on a single topic.

They should be easy to scan for relevant and actionable information. Elements, like text and images, should be placed on them in a way that clearly indicates hierarchy." -Content {
    New-Example -Title 'Simple Card' -Description 'Although cards can support multiple actions, UI controls, and an overflow menu, use restraint and remember that cards are entry points to more complex and detailed information.' -Example {
New-UDCard -Title 'Simple Card' -Content {
    "This is some content"
} 
    }
} -Cmdlet "New-UDCard"

$Pages += New-ComponentPage -Title 'Checkbox' -Description 'Checkboxes allow the user to select one or more items from a set.' -SecondDescription "Checkboxes can be used to turn an option on or off.

If you have multiple options appearing in a list, you can preserve space by using checkboxes instead of on/off switches. If you have a single option, avoid using a checkbox and use an on/off switch instead." -Content {
    New-Example -Title 'Checkboxes' -Description "Checkboxes can be disabled and checked by default" -Example {
New-UDCheckBox

New-UDCheckBox -Disabled

New-UDCheckBox -Checked $true

New-UDCheckBox -Checked $true -Disabled
    }

    New-Example -Title 'Checkboxes with custom icon' -Description "Create checkboxes that use any icon and style." -Example {
$Icon = New-UDIcon -Icon angry -Size lg -Regular
$CheckedIcon = New-UDIcon -Icon angry -Size lg
New-UDCheckBox -Icon $Icon -CheckedIcon $CheckedIcon -Style @{color = '#2196f3'}
    }

    New-Example -Title 'Checkboxes with onChange script block' -Description "Create checkboxes that fire script blocks when changed." -Example {
New-UDCheckBox -OnChange {
    Show-UDToast -Title 'Checkbox' -Message $Body
}    
    }

    New-Example -Title 'Checkbox with custom label placement' -Description "You can adjust where the label for the checkbox is placed." -Example {
New-UDCheckBox -Label 'Demo' -LabelPlacement start
New-UDCheckBox -Label 'Demo' -LabelPlacement top
New-UDCheckBox -Label 'Demo' -LabelPlacement bottom
New-UDCheckBox -Label 'Demo' -LabelPlacement end
    }
} -Cmdlet "New-UDCheckbox"


$Pages += New-ComponentPage -Title 'Chips' -Description 'Chips are compact elements that represent an input, attribute, or action.' -SecondDescription "Chips allow users to enter information, make selections, filter content, or trigger actions.

While included here as a standalone component, the most common use will be in some form of input, so some of the behaviour demonstrated here is not shown in context." -Content {
    New-Example -Title 'Basic Chips' -Description '' -Example {
        New-UDChip -Label 'Basic'
    }

    New-Example -Title 'With Icon' -Description '' -Example {
        New-UDChip -Label 'Basic' -Icon (New-UDIcon -Icon 'user')
    }

    New-Example -Title 'OnClick' -Description '' -Example {
        New-UDChip -Label 'OnClick' -OnClick {
            Show-UDToast -Message 'Hello!'
        }
    }

    New-Example -Title 'OnDelete' -Description '' -Example {
        New-UDChip -Label 'OnDelete' -OnClick {
            Show-UDToast -Message 'Goodbye!'
        }
    }
} -Cmdlet "New-UDCard"

$Pages += New-ComponentPage -Title 'Date Picker' -Description 'Date pickers pickers provide a simple way to select a single value from a pre-determined set.' -SecondDescription "" -Content {
    New-Example -Title 'Date Picker' -Description '' -Example {
        New-UDDatePicker 
    }
} -Cmdlet "New-UDDatePicker"

$Pages += New-ComponentPage -Title 'Expansion Panel' -Description 'Expansion panels contain creation flows and allow lightweight editing of an element.' -SecondDescription "An expansion panel is a lightweight container that may either stand alone or be connected to a larger surface, such as a card." -Content {
    New-Example -Title 'Simple Expansion Panel' -Description '' -Example {
        New-UDExpansionPanelGroup -Children {
            New-UDExpansionPanel -Title "Hello" -Children {}

            New-UDExpansionPanel -Title "Hello" -Id 'expContent' -Children {
                New-UDElement -Tag 'div' -Content { "Hello" }
            }
        }
    }
} -Cmdlet "New-UDExpansionPanel"

$Pages += New-ComponentPage -Title 'Floating Action Button' -Description 'A floating action button (FAB) performs the primary, or most common, action on a screen.' -SecondDescription "A floating action button appears in front of all screen content, typically as a circular shape with an icon in its center. FABs come in two types: regular, and extended.

Only use a FAB if it is the most suitable way to present a screen’s primary action.

Only one floating action button is recommended per screen to represent the most common action." -Content {
    New-Example -Title 'Floating Action Button' -Description '' -Example {
        New-UDFloatingActionButton -Icon (New-UDIcon -Icon user) -Size Small
        New-UDFloatingActionButton -Icon (New-UDIcon -Icon user) -Size Medium
        New-UDFloatingActionButton -Icon (New-UDIcon -Icon user) -Size Large
    }

    New-Example -Title 'OnClick' -Description '' -Example {
        New-UDFloatingActionButton -Icon (New-UDIcon Icon user) -OnClick {
            Show-UDToast -Message "Hello!"
        }
    }
} -Cmdlet "New-UDFloatingActionButton"

$Pages += New-ComponentPage -Title 'Form' -Description 'Forms provide a way to collect data from users.' -SecondDescription "Forms can include any type of control you want. This allows you to customize the look and feel and use any input controls. 

Data entered via the input controls will be sent back to the the OnSubmit script block when the form is submitted. " -Content {
    New-Example -Title 'Simple Form' -Description 'Simple forms can use inputs like text boxes and checkboxes.' -Example {
New-UDForm -Content {
    New-UDTextbox -Id 'txtTextfield'
    New-UDCheckbox -Id 'chkCheckbox'
} -OnSubmit {
    Show-UDToast -Message $Body
}
    }

    New-Example -Title 'Formatting a Form' -Description 'Since forms can use any component, you can use standard formatting components within the form.' -Example {
New-UDForm -Content {

    New-UDRow -Columns {
        New-UDColumn -SmallSize 6 -LargeSize 6 -Content {
            New-UDTextbox -Id 'txtTextfield' -Label 'First Name' 
        }
        New-UDColumn -SmallSize 6 -LargeSize 6 -Content {
            New-UDTextbox -Id 'txtTextfield' -Label 'Last Name'
        }
    }

    New-UDTextbox -Id 'txtAddress' -Label 'Address'

    New-UDRow -Columns {
        New-UDColumn -SmallSize 6 -LargeSize 6  -Content {
            New-UDTextbox -Id 'txtState' -Label 'State'
        }
        New-UDColumn -SmallSize 6 -LargeSize 6  -Content {
            New-UDTextbox -Id 'txtZipCode' -Label 'ZIP Code'
        }
    }

} -OnSubmit {
    Show-UDToast -Message $Body
}
            }

} -Cmdlet "New-UDForm"

$Pages += New-ComponentPage -Title 'Grid' -Description 'The responsive layout grid adapts to screen size and orientation, ensuring consistency across layouts.' -SecondDescription "The grid creates visual consistency between layouts while allowing flexibility across a wide variety of designs. Material Design’s responsive UI is based on a 12-column grid layout." -Content {

    New-Example -Title 'Basic grid' -Description "The column widths apply at all breakpoints (i.e. xs and up)." -Example {
New-UDGrid -Container -Content {
    New-UDGrid -Item -ExtraSmallSize 12 -Content {
        New-UDPaper -Content { "xs-12" } -Elevation 2
    }
    New-UDGrid -Item -ExtraSmallSize 6 -Content {
        New-UDPaper -Content { "xs-6" } -Elevation 2
    }
    New-UDGrid -Item -ExtraSmallSize 6 -Content {
        New-UDPaper -Content { "xs-6" } -Elevation 2
    }
    New-UDGrid -Item -ExtraSmallSize 3 -Content {
        New-UDPaper -Content { "xs-3" } -Elevation 2
    }
    New-UDGrid -Item -ExtraSmallSize 3 -Content {
        New-UDPaper -Content { "xs-3" } -Elevation 2
    }
    New-UDGrid -Item -ExtraSmallSize 3 -Content {
        New-UDPaper -Content { "xs-3" } -Elevation 2
    }
    New-UDGrid -Item -ExtraSmallSize 3 -Content {
        New-UDPaper -Content { "xs-3" } -Elevation 2
    }
}
    }

    New-Example -Title 'Spacing' -Description "Adjust the spacing between items in the grid" -Example {

New-UDDynamic -Id 'spacingGrid' -Content {
    $Spacing = (Get-UDElement -Id 'spacingSelect').value

    New-UDGrid -Spacing $Spacing -Container -Content {
        New-UDGrid -Item -ExtraSmallSize 3 -Content {
            New-UDPaper -Content { "xs-3" } -Elevation 2
        }
        New-UDGrid -Item -ExtraSmallSize 3 -Content {
            New-UDPaper -Content { "xs-3" } -Elevation 2
        }
        New-UDGrid -Item -ExtraSmallSize 3 -Content {
            New-UDPaper -Content { "xs-3" } -Elevation 2
        }
        New-UDGrid -Item -ExtraSmallSize 3 -Content {
            New-UDPaper -Content { "xs-3" } -Elevation 2
        }
    }
}

New-UDSelect -Id 'spacingSelect' -Label Spacing -Option {
    0..10 | ForEach-Object { New-UDSelectOption -Name $_ -Value $_ }
} -OnChange { Sync-UDElement -Id 'spacingGrid' } -DefaultValue 3

    }
} -Cmdlet "New-UDGrid"


$Pages += New-ComponentPage -Title 'Icons' -Description 'FontAwesome icons to include in your dashboard.' -SecondDescription "" -Content {

    New-UDTextbox -Id 'txtIconSearch' -Label 'Search' 
    New-UDButton -Text 'Search' -OnClick {
        Sync-UDElement -Id 'icons'
    }

    New-UDElement -tag 'p' -Content {}

    New-UDDynamic -Id 'icons' -Content {
        $Icons = [Enum]::GetNames([UniversalDashboard.Models.FontAwesomeIcons])
        $IconSearch = (Get-UDElement -Id 'txtIconSearch').value
        if ($null -ne $IconSearch -and $IconSearch -ne '')
        {
            $Icons = $Icons.where({ $_ -match $IconSearch})
        }

        foreach($icon in $icons) {
            New-UDIcon -Icon $icon -Size lg
        }
    }
} -Cmdlet "New-UDIcon"

$Pages += New-ComponentPage -Title 'List' -Description 'Lists are continuous, vertical indexes of text or images.' -SecondDescription "Lists are a continuous group of text or images. They are composed of items containing primary and supplemental actions, which are represented by icons and text." -Content {

    New-Example -Title 'List' -Description '' -Example {
        New-UDList -Content {
            New-UDListItem -Label 'Inbox' -Icon (New-UDIcon -Icon envelope -Size 3x) -SubTitle 'New Stuff'
            New-UDListItem -Label 'Drafts' -Icon (New-UDIcon -Icon edit -Size 3x) -SubTitle "Stuff I'm working on "
            New-UDListItem -Label 'Trash' -Icon (New-UDIcon -Icon trash -Size 3x) -SubTitle 'Stuff I deleted'
            New-UDListItem -Label 'Spam' -Icon (New-UDIcon -Icon bug -Size 3x) -SubTitle "Stuff I didn't want"
        }
    }
} -Cmdlet @("New-UDList", "New-UDListItem")

$Pages += New-ComponentPage -Title 'Link' -Description 'Link to other pages.' -SecondDescription "" -Content {
    New-Example -Title 'Link' -Description '' -Example {
        New-UDLink -Url 'https://www.google.com' -Text Google
    }
} -Cmdlet @("New-UDLink")

$Pages += New-ComponentPage -Title 'Monitor' -Description 'Monitors show a stream of continuous data in a chart.' -SecondDescription "" -Content {
    New-Example -Title 'Monitor' -Description '' -Example {
        New-UDMonitor -Content {
            @{
                used     = Get-Random -Min 1 -Max 10000
                resource = 'processor'
            } 
            @{
                used     = Get-Random -Min 1 -Max 10000
                resource = 'user'
            } 
        } -Fields @('used') -ColorBy 'resource'
    }
    
} -Cmdlet @("New-UDMonitor")

$Pages += New-ComponentPage -Title 'Paper' -Description 'In Material Design, the physical properties of paper are translated to the screen.' -SecondDescription "The background of an application resembles the flat, opaque texture of a sheet of paper, and an application’s behavior mimics paper’s ability to be re-sized, shuffled, and bound together in multiple sheets." -Content {
    New-Example -Title 'Paper' -Description '' -Example {
New-UDPaper -Elevation 0 -Content {} 
New-UDPaper -Elevation 1 -Content {} 
New-UDPaper -Elevation 3 -Content {} 
    }
} -Cmdlet "New-UDPaper"

$Pages += New-ComponentPage -Title 'Progress' -Description 'Progress indicators commonly known as spinners, express an unspecified wait time or display the length of a process.' -SecondDescription "Progress indicators inform users about the status of ongoing processes, such as loading an app, submitting a form, or saving updates. They communicate an app’s state and indicate available actions, such as whether users can navigate away from the current screen.

Determinate indicators display how long an operation will take.

Indeterminate indicators visualize an unspecified wait time." -Content {
    New-Example -Title 'Circular Progress' -Description '' -Example {
New-UDProgress -Circular -Color Red
New-UDProgress -Circular -Color Green 
New-UDProgress -Circular -Color Blue 
New-UDProgress -Circular -Size Small
New-UDProgress -Circular -Size Medium 
New-UDProgress -Circular -Size Large
    }

    New-Example -Title 'Linear Indeterminate' -Description '' -Example {
New-UDProgress 
    }

    New-Example -Title 'Linear Determinate' -Description '' -Example {
New-UDProgress -PercentComplete 75
    }

} -Cmdlet "New-UDProgress"


$Pages += New-ComponentPage -Title 'Radio' -Description 'Radio buttons allow the user to select one option from a set.' -SecondDescription "Use radio buttons when the user needs to see all available options. If available options can be collapsed, consider using a dropdown menu because it uses less space.

Radio buttons should have the most commonly used option selected by default." -Content {
    New-Example -Title 'Simple Radio' -Description '' -Example {
New-UDRadioGroup -Label "Day" -Content {
    New-UDRadio -Label Monday -Value 'monday'
    New-UDRadio -Label Tuesday -Value 'tuesday'
    New-UDRadio -Label Wednesday -Value 'wednesday'
    New-UDRadio -Label Thursday -Value 'thursday'
    New-UDRadio -Label Friday  -Value 'friday'
    New-UDRadio -Label Saturday -Value 'saturday'
    New-UDRadio -Label Sunday -Value 'sunday'
}
    }

    New-Example -Title 'OnChange' -Description '' -Example {
New-UDRadioGroup -Label "Day" -Content {
    New-UDRadio -Label Monday -Value 'monday'
    New-UDRadio -Label Tuesday -Value 'tuesday'
    New-UDRadio -Label Wednesday -Value 'wednesday'
    New-UDRadio -Label Thursday -Value 'thursday'
    New-UDRadio -Label Friday  -Value 'friday'
    New-UDRadio -Label Saturday -Value 'saturday'
    New-UDRadio -Label Sunday -Value 'sunday'
} -OnChange { Show-UDToast -Message $Body }
    }
} -Cmdlet "New-UDRadio"

$Pages += New-ComponentPage -Title 'Select' -Description 'Select components are used for collecting user provided information from a list of options.' -SecondDescription "" -Content {
    New-Example -Title 'Simple Select' -Description '' -Example {
New-UDSelect -Option {
    New-UDSelectOption -Name 'One' -Value 1
    New-UDSelectOption -Name 'Two' -Value 2
    New-UDSelectOption -Name 'Three' -Value 3
}
    }

    New-Example -Title 'Grouped Select' -Description '' -Example {
New-UDSelect -Option {
    New-UDSelectGroup -Name 'Group One' -Option {
        New-UDSelectOption -Name 'One' -Value 1
        New-UDSelectOption -Name 'Two' -Value 2
        New-UDSelectOption -Name 'Three' -Value 3
    }
    New-UDSelectGroup -Name 'Group Two' -Option {
        New-UDSelectOption -Name 'Four' -Value 4
        New-UDSelectOption -Name 'Five' -Value 5
        New-UDSelectOption -Name 'Size' -Value 6
    }
}
    }

    New-Example -Title 'OnChange' -Description '' -Example {
New-UDSelect -Option {
    New-UDSelectOption -Name 'One' -Value 1
    New-UDSelectOption -Name 'Two' -Value 2
    New-UDSelectOption -Name 'Three' -Value 3
} -OnChange { Show-UDToast -Message $Body }
    }

} -Cmdlet "New-UDSelect"

$Pages += New-ComponentPage -Title 'Switch' -Description 'Switches toggle the state of a single setting on or off.' -SecondDescription "Switches are the preferred way to adjust settings on mobile. The option that the switch controls, as well as the state it’s in, should be made clear from the corresponding inline label." -Content {
    New-Example -Title 'Switch' -Description '' -Example {
New-UDSwitch -Checked $true 
New-UDSwitch -Checked $true -Disabled
    }

    New-Example -Title 'OnChange Event' -Description '' -Example {
New-UDSwitch -OnChange { Show-UDToast -Message $Body }
    }

} -Cmdlet "New-UDSwitch"

$Pages += New-ComponentPage -Title 'Tabs' -Description 'Tabs make it easy to explore and switch between different views.' -SecondDescription "Tabs organize and allow navigation between groups of content that are related and at the same level of hierarchy." -Content {
    New-Example -Title 'Simple Tables' -Description 'A simple example with no frills.' -Example {
New-UDTabs -Tabs {
    New-UDTab -Text 'Item One' -Content { New-UDTypography -Text 'Item One' -Variant 'h2' }
    New-UDTab -Text 'Item Two' -Content { New-UDTypography -Text 'Item Two' -Variant 'h2' }
    New-UDTab -Text 'Item Three' -Content { New-UDTypography -Text 'Item Three' -Variant 'h2' }
}
    }

    New-Example -Title 'Vertical Tables' -Description 'Vertical tabs' -Example {
New-UDTabs -Tabs {
    New-UDTab -Text 'Item One' -Content { New-UDTypography -Text 'Item One' -Variant 'h2' }
    New-UDTab -Text 'Item Two' -Content { New-UDTypography -Text 'Item Two' -Variant 'h2' }
    New-UDTab -Text 'Item Three' -Content { New-UDTypography -Text 'Item Three' -Variant 'h2' }
} -Orientation vertical
            }
    
} -Cmdlet @("New-UDTabs", "New-UDTab")

$Pages += New-ComponentPage -Title 'Table' -Description 'Tables display sets of data. They can be fully customized.' -SecondDescription "Tables display information in a way that’s easy to scan, so that users can look for patterns and insights. They can be embedded in primary content, such as cards." -Content {
    New-Example -Title 'Simple Table' -Description 'A simple example with no frills. Table columns are defined from the data.' -Example {
$Data = @(
    @{Dessert = 'Frozen yoghurt'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
    @{Dessert = 'Ice cream sandwich'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
    @{Dessert = 'Eclair'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
    @{Dessert = 'Cupcake'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
    @{Dessert = 'Gingerbread'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
) 

New-UDTable -Data $Data
    }

    New-Example -Title 'Table with Custom Columns' -Description 'Define custom columns for your table.' -Example {
$Data = @(
    @{Dessert = 'Frozen yoghurt'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
    @{Dessert = 'Ice cream sandwich'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
    @{Dessert = 'Eclair'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
    @{Dessert = 'Cupcake'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
    @{Dessert = 'Gingerbread'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
) 

$Columns = @(
    New-UDTableColumn -Property Dessert -Title "A Dessert"
    New-UDTableColumn -Property Calories -Title Calories 
    New-UDTableColumn -Property Fat -Title Fat 
    New-UDTableColumn -Property Carbs -Title Carbs 
    New-UDTableColumn -Property Protein -Title Protein 
)

New-UDTable -Id 'customColumnsTable' -Data $Data -Columns $Columns
            }

    New-Example -Title 'Table with Custom Column Rendering' -Description 'Define column rendering. Sorting and exporting still work for the table.' -Example {
$Data = @(
    @{Dessert = 'Frozen yoghurt'; Calories = 1; Fat = 6.0; Carbs = 24; Protein = 4.0}
    @{Dessert = 'Ice cream sandwich'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
    @{Dessert = 'Eclair'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
    @{Dessert = 'Cupcake'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
    @{Dessert = 'Gingerbread'; Calories = 200; Fat = 6.0; Carbs = 24; Protein = 4.0}
) 

$Columns = @(
    New-UDTableColumn -Property Dessert -Title Dessert -Render { 
        $Item = $Body | ConvertFrom-Json 
        New-UDButton -Id "btn$($Item.Dessert)" -Text "Click for Dessert!" -OnClick { Show-UDToast -Message $Item.Dessert } 
    }
    New-UDTableColumn -Property Calories -Title Calories 
    New-UDTableColumn -Property Fat -Title Fat 
    New-UDTableColumn -Property Carbs -Title Carbs 
    New-UDTableColumn -Property Protein -Title Protein 
)

New-UDTable -Data $Data -Columns $Columns -Sort -Export
    }

    New-Example -Title 'Table with server-side processing' -Description 'Process data on the server so you can perform paging, filtering, sorting and searching in systems like SQL.' -Example {
$Columns = @(
    New-UDTableColumn -Property Dessert -Title "A Dessert"
    New-UDTableColumn -Property Calories -Title Calories 
    New-UDTableColumn -Property Fat -Title Fat 
    New-UDTableColumn -Property Carbs -Title Carbs 
    New-UDTableColumn -Property Protein -Title Protein 
)

New-UDTable -Columns $Columns -LoadData {
    $Query = $Body | ConvertFrom-Json

    <# Query will contain
        filters: []
        orderBy: undefined
        orderDirection: ""
        page: 0
        pageSize: 5
        properties: (5) ["dessert", "calories", "fat", "carbs", "protein"]
        search: ""
        totalCount: 0
    #>

    @(
        @{Dessert = 'Frozen yoghurt'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
        @{Dessert = 'Ice cream sandwich'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
        @{Dessert = 'Eclair'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
        @{Dessert = 'Cupcake'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
        @{Dessert = 'Gingerbread'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
    ) | Out-UDTableData -Page 0 -TotalCount 5 -Properties $Query.Properties 
}
    }

} -Cmdlet "New-UDTable"

$Pages += New-ComponentPage -Title 'Textbox' -Description 'A textbox lets users enter and edit text.' -SecondDescription "" -Content {
    New-Example -Title 'Textbox' -Description '' -Example {
        New-UDTextbox -Label 'Standard' -Placeholder 'Textbox'
        New-UDTextbox -Label 'Disabled' -Placeholder 'Textbox' -Disabled
        New-UDTextbox -Label 'Textbox' -Value 'With value'
    }

    New-Example -Title 'Password Textbox' -Description '' -Example {
        New-UDTextbox -Label 'Password' -Type password
    }

    New-Example -Title 'Retrieving a textbox value' -Description 'You can use Get-UDElement to get the value of a textbox' -Example {
        New-UDTextbox -Id 'txtExample' 
        New-UDButton -OnClick {
            $Value = (Get-UDElement -Id 'txtExample').value 
            Show-UDToast -Message $Value
        } -Text "Get textbox value"
    }
} -Cmdlet "New-UDTextbox"

$Pages += New-ComponentPage -Title 'Time Picker' -Description 'Time pickers pickers provide a simple way to select a single value from a pre-determined set.' -SecondDescription "" -Content {
    New-Example -Title 'Time Picker' -Description '' -Example {
        New-UDTimePicker
    }
} -Cmdlet "New-UDTimePicker"


$Pages += New-ComponentPage -Title 'Tree View' -Description 'A tree view widget presents a hierarchical list.' -SecondDescription "Tree views can be used to represent a file system navigator displaying folders and files, an item representing a folder can be expanded to reveal the contents of the folder, which may be files, folders, or both." -Content {
    New-Example -Title 'Tree view' -Description '' -Example {
        New-UDTreeView -Node {
            New-UDTreeNode -Id 'Root' -Name 'Root' -Children {
                New-UDTreeNode -Id 'Level1' -Name 'Level 1' -Children {
                    New-UDTreeNode -Id 'Level2' -Name 'Level 2'
                }
                New-UDTreeNode -Name 'Level 1' -Children {
                    New-UDTreeNode -Name 'Level 2'
                }
                New-UDTreeNode -Name 'Level 1' -Children {
                    New-UDTreeNode -Name 'Level 2'
                }   
            }
            New-UDTreeNode -Id 'Root2' -Name 'Root 2'
        }
    }
} -Cmdlet @("New-UDTreeView", "New-UDTreeNode")

$Pages += New-ComponentPage -Title 'Typography' -Description 'Use typography to present your design and content as clearly and efficiently as possible.' -SecondDescription "Too many type sizes and styles at once can spoil any layout. A typographic scale has a limited set of type sizes that work well together along with the layout grid." -Content {
    New-Example -Title 'Variants' -Description '' -Example {
        @("h1", "h2", "h3", "h4", "h5", "h6", "subtitle1", "subtitle2", "body1", "body2", 
        "caption", "button", "overline", "srOnly", "inherit", 
        "display4", "display3", "display2", "display1", "headline", "title", "subheading") | ForEach-Object {
            New-UDTypography -Variant $_ -Text $_ 
            New-UDElement -Tag 'p' -Content {}
        }
    }
} -Cmdlet @("New-UDTypography")


New-UDDashboard -Title "PowerShell Universal Dashboard" -Pages $Pages