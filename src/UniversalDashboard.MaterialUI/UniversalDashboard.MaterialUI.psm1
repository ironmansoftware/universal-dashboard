
if ($args[0])
{
    $MUAssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset("http://localhost:10000/materialui.index.bundle.js")
    [UniversalDashboard.Services.AssetService]::Instance.RegisterFramework("MaterialUI", "http://localhost:10000/materialui.index.bundle.js")
}
else 
{
    $JsFile = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
    $Files = Get-ChildItem "$PSScriptRoot\*.*"
    
    $Files | ForEach-Object {
        [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($_.FullName)
    }
    
    $MUAssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($JSFile.FullName)
    [UniversalDashboard.Services.AssetService]::Instance.RegisterFramework("MaterialUI", $JSFile.FullName)
}

# Load out controls
Get-ChildItem (Join-Path $PSScriptRoot "Scripts") -File -Filter "*.ps1" | ForEach-Object {
    . $_.FullName
} 

function New-UDRow {
    [CmdletBinding(DefaultParameterSetName = 'static')]
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter(ParameterSetName = "static", Position = 0)]
        [ScriptBlock]$Columns,
        [Parameter(ParameterSetName = "dynamic")]
        [object]$Endpoint,
        [Parameter(ParameterSetName = "dynamic")]
        [Switch]$AutoRefresh,
        [Parameter(ParameterSetName = "dynamic")]
        [int]$RefreshInterval = 5
    )

    End 
    {
        if ($PSCmdlet.ParameterSetName -eq 'dynamic')
        {
            throw "dynamic parameterset not yet supported"
        }

        New-UDGrid -Container -Content {
            $Columns.Invoke()
        }
    }
}

function New-UDColumn {
    [CmdletBinding(DefaultParameterSetName = 'content')]
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),

        [Parameter()]
        [Alias('Size')]
        [ValidateRange(1,12)]
        [int]$SmallSize = 12,
        [Parameter()]
        [ValidateRange(1,12)]
        [int]$LargeSize = 12,
        [Parameter()]
        [ValidateRange(1,12)]
        [int]$MediumSize = 12,

        [Parameter()]
        [ValidateRange(1,12)]
        [int]$SmallOffset = 1,
        [Parameter()]
        [ValidateRange(1,12)]
        [int]$MediumOffset = 1,
        [Parameter()]
        [ValidateRange(1,12)]
        [int]$LargeOffset = 1,

        [Parameter(ParameterSetName = 'content', Position = 1)]
        [ScriptBlock]$Content,

        [Parameter(ParameterSetName = "endpoint")]
        [object]$Endpoint,
        [Parameter(ParameterSetName = "endpoint")]
        [Switch]$AutoRefresh,
        [Parameter(ParameterSetName = "endpoint")]
        [int]$RefreshInterval = 5
    )
    
    if ($PSCmdlet.ParameterSetName -eq 'content') {
        $GridContent = $Content
        New-UDGrid -Item -SmallSize $SmallSize -MediumSize $MediumSize -LargeSize $LargeSize -Content {
            $GridContent.Invoke()
        }
    } else {
        throw "endpoint not yet supported"
    }

    
}