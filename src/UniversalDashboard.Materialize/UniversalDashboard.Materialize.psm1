
$JsFiles = Get-ChildItem "$PSScriptRoot\*.bundle.js"

$Items = @("tabs")

$AssetIds = @{}

foreach($item in $items)
{
    $FilePath = $JsFiles | Where-Object { $_.Name.Contains($item) }
    $AssetIds[$item] = [UniversalDashboard.Services.AssetService]::Instance.RegisterScript($FilePath.FullName)
}

function New-UDTabContainer {
    param(
        [Parameter(Mandatory, ParameterSetName = "Static")]
        [ScriptBlock]$Tabs 
    )

    End {
        @{
            isPlugin = $true
            assetId = $AssetIds["tabs"]
            type = "tab-container"
            tabs = $Tabs.Invoke()
        }
    }
}

function New-UDTab {
    param(
        [Parameter(Mandatory)]
        [string]$Text,
        [Parameter(Mandatory, ParameterSetName = "static")]
        [ScriptBlock]$Content
    )

    End {
        @{
            isPlugin = $true
            assetId = $AssetIds["tabs"]
            type = "tab"
            text = $Text
            content = $Content.Invoke()
        }
    }
}