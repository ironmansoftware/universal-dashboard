function New-UDTransferList {
    <#
    .SYNOPSIS
    Creates a transfer list component.
    
    .DESCRIPTION
    A transfer list (or "shuttle") enables the user to move one or more list items between lists.
    
    .PARAMETER Id
    The ID of this component.
    
    .PARAMETER Item
    A list of items that can be transferred between lists. Use New-UDTransferListItem to create an item.
    
    .PARAMETER SelectedItem
    A list of selected items. Use the value of item to transfer items between lists.
    
    .PARAMETER OnChange
    A script block that is executed when the user changes the selected items.
    
    .EXAMPLE
    New-UDTransferList -Item {
        New-UDTransferListItem -Name 'test1' -Value 1
        New-UDTransferListItem -Name 'test2' -Value 2
        New-UDTransferListItem -Name 'test3' -Value 3
        New-UDTransferListItem -Name 'test4' -Value 4
        New-UDTransferListItem -Name 'test5' -Value 5
    } 

    Creates a basic transfer list.
    
    .EXAMPLE
    New-UDTransferList -Item {
        New-UDTransferListItem -Name 'test1' -Value 1
        New-UDTransferListItem -Name 'test2' -Value 2
        New-UDTransferListItem -Name 'test3' -Value 3
        New-UDTransferListItem -Name 'test4' -Value 4
        New-UDTransferListItem -Name 'test5' -Value 5
    } -OnChange {
        Show-UDToast ($EventData | ConvertTo-Json)
    }

    Creates a basic transfer list that shows a toast when the values are changed. 

    .EXAMPLE
    New-UDForm -Content {
        New-UDTransferList -Item {
            New-UDTransferListItem -Name 'test1' -Value 1
            New-UDTransferListItem -Name 'test2' -Value 2
            New-UDTransferListItem -Name 'test3' -Value 3
            New-UDTransferListItem -Name 'test4' -Value 4
            New-UDTransferListItem -Name 'test5' -Value 5
        }
    } -OnSubmit {
        Show-UDToast ($EventData | ConvertTo-Json)
    }

    Creates a transfer list that is part of a form. 
    #>
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter()]
        [ScriptBlock]$Item,
        [Parameter()]
        [string[]]$SelectedItem = @(),
        [Parameter()]
        [Endpoint]$OnChange,
        [Parameter()]
        [string]$ClassName
    )

    if ($OnChange) {
        $OnChange.Register($Id + "onChange", $PSCmdlet)
    }

    @{
        type         = 'mu-transfer-list'
        assetId      = $MUAssetId
        isPlugin     = $true 

        id           = $id 
        item         = $Item.Invoke()
        selectedItem = $SelectedItem
        onChange     = $OnChange
        className    = $ClassName
    }
}

function New-UDTransferListItem {
    <#
    .SYNOPSIS
    Creates an item for use in a transfer list.
    
    .DESCRIPTION
    Creates an item for use in a transfer list.
    
    .PARAMETER Name
    The display name of the item. 
    
    .PARAMETER Value
    The value of the item. 
    #>
    param(
        [Parameter(Mandatory = $true)]
        [String]$Name,
        [Parameter(Mandatory = $true)]
        [String]$Value
    )

    @{
        name  = $Name 
        value = $Value 
    }
}
