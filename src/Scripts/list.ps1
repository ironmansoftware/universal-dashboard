function New-UDList {
    <#
    .SYNOPSIS
    Creates a list. 
    
    .DESCRIPTION
    Creates a list. Use New-UDListItem to add new items to the list. Lists are good for links in UDDrawers.
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Children
    The items in the list.
    
    .PARAMETER SubHeader
    Text to show within the sub header. 
    
    .EXAMPLE
    Creates a new list with two items and nested list items.

    New-UDList -Id 'listContent' -Content {

        New-UDListItem -Id 'listContentItem' -AvatarType Avatar -Source 'https://pbs.twimg.com/profile_images/1065243723217416193/tg3XGcVR_400x400.jpg' -Label 'Adam Driscoll' -Content {

            New-UDListItem -Id 'list-item-security' -Label 'username and passwords'
            New-UDListItem -Id 'list-item-api' -Label 'api keys'

        } 
    }
    #>
    param(
        [Parameter ()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter ()]
        [Alias("Content")]
        [scriptblock]$Children,
        [Parameter ()]
        [string]$SubHeader,
        [Parameter()]
        [string]$ClassName
    )
    End {
        try {
            $c = & $Children
        }
        catch {
            $c = New-UDError -Message $_
        }

        @{
            type      = 'mu-list'
            isPlugin  = $true
            assetId   = $MUAssetId

            id        = $Id
            children  = $c
            subHeader = $SubHeader
            style     = $Style
            className = $ClassName
        }
    }
}

function New-UDListItem {
    <#
    .SYNOPSIS
    Creates a new list item.
    
    .DESCRIPTION
    Creates a new list item. List items are used with New-UDList. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER AvatarType
    The type of avatar to show within the list item. 
    
    .PARAMETER OnClick
    A script block to execute when the list item is clicked. 
    
    .PARAMETER Label
    The label to show within the list item. 
    
    .PARAMETER Children
    Nested list items to show underneath this list item. 
    
    .PARAMETER SubTitle
    The subtitle to show within the list item. 
    
    .PARAMETER Icon
    The icon to show within the list item. 
    
    .PARAMETER Source
    Parameter description
    
    .PARAMETER SecondaryAction
    The secondary action to issue with this list item. 
    
    .EXAMPLE
    Creates a new list with two items and nested list items.

    New-UDList -Id 'listContent' -Content {

        New-UDListItem -Id 'listContentItem' -AvatarType Avatar -Source 'https://pbs.twimg.com/profile_images/1065243723217416193/tg3XGcVR_400x400.jpg' -Label 'Adam Driscoll' -Content {

            New-UDListItem -Id 'list-item-security' -Label 'username and passwords'
            New-UDListItem -Id 'list-item-api' -Label 'api keys'

        } 
    }
    #>
    [CmdletBinding()]
    param(
        [Parameter ()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter ()]
        [ValidateSet("Icon", "Avatar")][string]$AvatarType = 'Icon',
        [Parameter ()]
        [Endpoint]$OnClick, 
        [Parameter ()]
        [string]$Label, 
        [Parameter ()]
        [Alias("Content")]
        [scriptblock]$Children, 
        [Parameter ()]
        [string]$SubTitle,
        [Parameter ()]
        $Icon,
        [Parameter ()]
        [string]$Source,
        [Parameter ()]
        [scriptblock]$SecondaryAction,
        [Parameter()]
        [string]$ClassName,
        [Parameter()]
        [Switch]$Open,
        [Parameter()]
        [Switch]$Nested
    )
    begin {}
    Process {}
    End {
        if ($OnClick) {
            $OnClick.Register($Id, $PSCmdlet)
        }

        if ($null -ne $Children) {
            try {
                $CardContent = & $Children    
            }
            catch {
                $CardContent = New-UDError -Message $_
            }
            
        }
        else {
            $CardContent = $null
        }

        if ($null -ne $SecondaryAction) {
            $Action = $SecondaryAction.Invoke()
        }
        else {
            $Action = $null
        }
        
        @{
            type            = 'mu-list-item'
            isPlugin        = $true
            assetId         = $MUAssetId

            id              = $Id
            subTitle        = $SubTitle
            label           = $Label
            onClick         = $OnClick
            children        = $CardContent
            secondaryAction = $Action
            icon            = $Icon
            source          = $Source
            avatarType      = $AvatarType
            labelStyle      = $LabelStyle
            style           = $Style
            className       = $ClassName
            open            = $Open.IsPresent
            nested          = $Nested.IsPresent
        }
    }
}