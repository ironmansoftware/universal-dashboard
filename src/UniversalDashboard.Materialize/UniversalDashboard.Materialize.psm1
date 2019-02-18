
$JsFiles = Get-ChildItem "$PSScriptRoot\*.bundle.js"

$Items = @("tabs")

$AssetIds = @{}

foreach($item in $items)
{
    $FilePath = $JsFiles | Where-Object { $_.Name.Contains($item) }
    $AssetIds[$item] = [UniversalDashboard.Services.AssetService]::Instance.RegisterScript($FilePath.FullName)
}

$Styles = Get-ChildItem  "$PSScriptRoot\*.css"
[UniversalDashboard.Services.AssetService]::Instance.RegisterStylesheet($Styles.FullName) | Out-Null

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
            assetId = $AssetIds["tabs"]
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
            assetId = $AssetIds["tabs"]
            type = "tab"
            text = $Text
            content = $Content.Invoke()
            id = $Id
        }
    }
}