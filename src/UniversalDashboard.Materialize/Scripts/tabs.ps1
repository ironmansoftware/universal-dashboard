function New-UDTabContainer {
    param(
        [Parameter(Mandatory, ParameterSetName = "Static")]
        [ScriptBlock]$Tabs,
        [Parameter()]
        [string]$Id = (New-Guid).ToString()
    )

    End {
        @{
            isPlugin = $true
            assetId = $AssetId
            type = "tab-container"
            tabs = $Tabs.Invoke()
            id = $id
        }
    }
}

function New-UDTab {
    param(
        [Parameter(Mandatory)]
        [string]$Text,
        [Parameter(Mandatory, ParameterSetName = "static")]
        [ScriptBlock]$Content,
        [Parameter()]
        [string]$Id = (New-Guid).ToString()
    )

    End {
        @{
            isPlugin = $true
            assetId = $AssetId
            type = "tab"
            text = $Text
            content = $Content.Invoke()
            id = $Id
        }
    }
}