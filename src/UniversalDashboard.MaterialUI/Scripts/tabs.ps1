function New-UDTabs {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ScriptBlock]$Tabs,
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter()]
        [Switch]$RenderOnActive
    )

    End {
        @{
            isPlugin        = $true
            assetId         = $MUAssetId
            type            = "mu-tabs"
            tabs            = $Tabs.Invoke()
            id              = $id
            renderOnClick   = $RenderOnActive.IsPresent
        }
    }
}

function New-UDTab {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Text,
        [Parameter(Mandatory)]
        [ScriptBlock]$Content,
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter()]
        [switch]$Dynamic,
        [Parameter()]
        [object]$Icon,
        [Parameter()]
        [switch]$Stacked
    )

    End {

        if ($null -ne $Content -and $Dynamic) {
            New-UDEndpoint -Id $Id -Endpoint $Content | Out-Null
        }

        @{
            isPlugin = $true
            assetId  = $MUAssetId
            type     = "mu-tab"
            label     = $Text
            icon = $Icon
            content  = $Content.Invoke()
            id       = $Id
            stacked = $Stacked.IsPresent
            dynamic = $Dynamic.IsPresent
        }
    }
}