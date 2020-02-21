function New-UDTreeView {
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