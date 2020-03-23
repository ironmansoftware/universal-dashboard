function New-UDTreeView {
    <#
    .SYNOPSIS
    Creates a new tree view.
    
    .DESCRIPTION
    Creates a new tree view.
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Node
    A collection of root nodes to show within the tree view. 
    
    .PARAMETER OnNodeClicked
    A script block that is called when a node is clicked. $EventData will contain the node that was clicked. 
    
    .EXAMPLE
    Creates a basic tree view. 

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
    #>
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter(Mandatory)]
        [ScriptBlock]$Node,
        [Parameter()]
        [object]$OnNodeClicked
    )

    End {
        if ($null -ne $OnNodeClicked) {
            if ($OnNodeClicked -is [scriptblock]) {
                $OnNodeClicked = New-UDEndpoint -Endpoint $OnNodeClicked -Id $Id
            }
            elseif ($OnNodeClicked -isnot [UniversalDashboard.Models.Endpoint]) {
                throw "OnNodeClicked must be a script block or UDEndpoint"
            }
        }

        
        @{
            assetId = $AssetId 
            isPlugin = $true 
            id = $Id 
            type = 'mu-treeview'

            node = & $Node 
            hasCallback = $null -ne $OnNodeClicked
        }
    }
}

function New-UDTreeNode {
    <#
    .SYNOPSIS
    Creates a tree node.
    
    .DESCRIPTION
    Creates a tree node. This cmdlet should be used with New-UDTreeView. 
    
    .PARAMETER Name
    The name of the node. This is displayed within the UI. 
    
    .PARAMETER Id
    The ID of the node. This is passed to the $EventData property when the OnNodeClicked script block is set. 
    
    .PARAMETER Children
    The children of this node. This should be a collection of New-UDTreeNodes. 
    
    .EXAMPLE
    See New-UDTreeView for examples. 
    #>
    param(
        [Parameter(Mandatory, Position = 1)]
		[string]$Name,
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter()]
		[ScriptBlock]$Children
    )

    End {
        $ChildrenArray = $null
        if ($PSBoundParameters.ContainsKey("Children"))
        {
            $ChildrenArray = & $Children
        }
        
        @{
            name = $Name 
            id = $Id 
            children = $ChildrenArray 
            icon = $IconName 
            expandedIcon = $ExpandedIconName
        }
    }
}