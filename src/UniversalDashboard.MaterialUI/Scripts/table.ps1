function New-UDTable {
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid().ToString(),
        [Parameter(Mandatory)]
        [ScriptBlock]$Content, 
        [Parameter()]
        [Switch]$Dynamic,
        [Parameter()]
        [ValidateSet("small", "medium")]
        [string]$Size = "medium",
        [Parameter()]
        [Switch]$StickyHeader
    )

    @{
        id = $Id 
        assetId = $MUAssetId 
        isPlugin = $true 
        type = "mu-table"

        content = $Content.Invoke()
        dynamic = $Dynamic.IsPresent
        size = $Size
        stickyHeader = $StickyHeader.IsPresent
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