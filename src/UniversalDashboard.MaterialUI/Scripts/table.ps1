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
                New-UDTableColumn -Field $member
            }
        }
        else 
        {
            $Columns = foreach($member in $item.PSObject.Properties)
            {
                New-UDTableColumn -Field $member.Name
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
        [string]$Field, 
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
        $Title = $Field
    }

    if ($Render)
    {
        $Render.Register($Id, $PSCmdlet)
    }

    @{
        id = $Id 
        field = $Field.ToLower()
        title = $Title 
        sort  = $Sort 
        filter = $Filter 
        search = $Search
        render = $Render.Name
    }
}

function New-UDTableCell {
    param(
        [Parameter(Mandatory)]
        [ScriptBlock]$Content
    )
    
    @{
        type = 'mu-table-cell'
        content = $Content.Invoke()
    }
}

function New-UDTableHeader {
    param(
        [Parameter(Mandatory)]
        [ScriptBlock]$Headers
    )

    @{
        type = 'mu-table-header'
        headers = $Headers.Invoke()
    }
}

function New-UDTableBody {
    param(
        [Parameter(Mandatory)]
        [ScriptBlock]$Rows
    )

    @{
        type = 'mu-table-body'
        rows = $Rows.Invoke()
    }
}
function New-UDTableRow {
    param(
        [Parameter(Mandatory)]
        [ScriptBlock]$Cells
    )

    @{
        type = 'mu-table-row'
        cells = $Cells.Invoke()
    }
}

function Out-UDTableContent {
    param(
        [Parameter(ValueFromPipeline = $true)]
        [object]$Data
    )

    Begin {
        $Headers = $null
        $TableRows = @()
    }

    Process 
    {
        if ($null -eq $Headers)
        {
            $item = $Data | Select-Object -First 1
            $Headers = New-UDTableHeader -Headers {
                foreach($member in $item.PSObject.Properties)
                {
                    New-UDTableCell -Content { $member.Name }
                }
            }
        }

        foreach($item in $Data)
        {
            $TableRows += New-UDTableRow -Cells {
                foreach($member in $item.PSObject.Properties)
                {
                    New-UDTableCell -Content { 
                        if ($null -eq $member.value)
                        {
                            ""
                        }
                        else 
                        {
                            $member.value.ToString() 
                        }
                    }
                }
            }
        }
    }

    End {
        $Headers 
        New-UDTableBody -Rows { 
            $TableRows
        }
    }
}