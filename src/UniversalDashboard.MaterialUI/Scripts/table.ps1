function New-UDTable {
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid().ToString(),
        [Parameter()]
        [string]$Title = "",
        [Parameter(Mandatory, ParameterSetName = "Static")]
        [object[]]$Data,
        [Parameter(Mandatory, ParameterSetName = "Dynamic")]
        [Endpoint]$LoadData,
        [Parameter(ParameterSetName = "Static")]
        [Parameter(Mandatory, ParameterSetName = "Dynamic")]
        [Hashtable[]]$Columns,
        [Parameter()]
        [Switch]$Sort,
        [Parameter()]
        [Switch]$Filter,
        [Parameter()]
        [Switch]$Search,
        [Parameter()]
        [Switch]$Export
    )

    if ($null -eq $Columns)
    {
        $item = $Data | Select-Object -First 1

        if ($item -is [Hashtable])
        {
            $Columns = foreach($member in $item.Keys)
            {
                New-UDTableColumn -Property $member
            }
        }
        else 
        {
            $Columns = foreach($member in $item.PSObject.Properties)
            {
                New-UDTableColumn -Property $member.Name
            }
        }
    }

    if ($LoadData) {
        $LoadData.Register($Id, $PSCmdlet)
    }

    @{
        id = $Id 
        assetId = $MUAssetId 
        isPlugin = $true 
        type = "mu-table"

        title = $Title
        columns = $Columns
        data = $Data #| ConvertTo-Json -Depth 1 | ConvertFrom-Json
        sort = $Sort.IsPresent
        filter = $Filter.IsPresent
        search = $Search.IsPresent
        export = $Export.IsPresent 
        loadData = $LoadData
    }
}

function New-UDTableColumn 
{
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid().ToString(),
        [Parameter(Mandatory)]
        [string]$Property, 
        [Parameter()]
        [string]$Title,
        [Parameter()]
        [Endpoint]$Render,
        [Parameter()]
        [bool]$Sort = $true,
        [Parameter()]
        [bool]$Filter = $true,
        [Parameter()]
        [bool]$Search = $true
    )

    if ($null -eq $Title -or $Title -eq '')
    {
        $Title = $Property
    }

    if ($Render)
    {
        $Render.Register($Id, $PSCmdlet)
    }

    @{
        id = $Id 
        field = $Property.ToLower()
        title = $Title 
        sort  = $Sort 
        filter = $Filter 
        search = $Search
        render = $Render.Name
    }
}
function Out-UDTableData {
    param(
        [Parameter(ValueFromPipeline = $true, Mandatory)]
        [object]$Data,
        [Parameter(Mandatory)]
        [int]$Page,
        [Parameter(Mandatory)]
        [int]$TotalCount,
        [Parameter(Mandatory)]
        [string[]]$Properties
    )

    Begin {
        $DataPage = @{
            data = @() 
            page = $Page 
            totalCount = $TotalCount
        }
    }

    Process 
    {
        $item = @{}
        foreach($property in $Properties) {
            $item[$property] = $Data[$property]
        }
        $DataPage.data += $item
    }

    End {
        $DataPage
    }
}