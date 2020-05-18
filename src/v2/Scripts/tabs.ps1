function New-UDTabContainer {
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
            assetId         = $AssetId
            type            = "tab-container"
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
        [Alias('IsEndpoint')]
        [switch]$Dynamic,
        [Parameter()]
        [object]$Icon,
        [Parameter()]
        [switch]$RefreshWhenActive,
        [Parameter()]
        [switch]$Stacked
    )

    End {

        if ($null -ne $Content) {
            if ($IsEndpoint) {
                $TabEndpoint = New-UDEndpoint -Id $Id -Endpoint $Content 
            }
        }

        @{
            isPlugin = $true
            assetId  = $AssetId
            type     = "tab"
            label     = $Text
            icon = $Icon
            content  = $Content.Invoke()
            id       = $Id
            stacked = $Stacked.IsPresent
            refreshWhenActive = $RefreshWhenActive.IsPresent
            dynamic = $Dynamic.IsPresent
        }
    }
}