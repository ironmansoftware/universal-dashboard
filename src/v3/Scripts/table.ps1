function New-UDTable {
    <#
    .SYNOPSIS
    Creates a table. 
    
    .DESCRIPTION
    Creates a table. Tables are used to show both static and dyanmic data. You can define columns and data to show within the table. The columns can be used to render custom components based on row data. You can also enable paging, filtering, sorting and even server-side processing.
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Title
    The title to show at the top of the table's card. 
    
    .PARAMETER Data
    The data to put into the table. 
    
    .PARAMETER LoadData
    When using dynamic tables, this script block is called. The $Body parameter will contain a hashtable the following options: 
 
    filters: @()
    orderBy: string
    orderDirection: string
    page: int
    pageSize: int
    properties: @()
    search: string
    totalCount: int

    You can use these values to perform server-side processing, like SQL queries, to improve the performance of large grids. 

    After processing the data with these values, output the data via Out-UDTableData.  
            
    .PARAMETER Columns
    Defines the columns to show within the table. Use New-UDTableColumn to define these columns. If this parameter isn't specified, the properties of the data that you pass in will become the columns.
    
    .PARAMETER Sort
    Whether sorting is enabled in the table. 
    
    .PARAMETER Filter
    Whether filtering is enabled in the table. 
    
    .PARAMETER Search
    Whether search is enabled in the table. 
    
    .PARAMETER Export
    Whether exporting is enabled within the table. 
    
    .EXAMPLE
    Creates a static table whether the columns of the table are the properties of the data specified. 

    $Data = @(
        @{Dessert = 'Frozen yoghurt'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
        @{Dessert = 'Ice cream sandwich'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
        @{Dessert = 'Eclair'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
        @{Dessert = 'Cupcake'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
        @{Dessert = 'Gingerbread'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0}
    ) 

    New-UDTable -Id 'defaultTable' -Data $Data

    .EXAMPLE 
    Creates a table where there are custom columns defined for that table. 

     $Columns = @(
        New-UDTableColumn -Property Dessert -Title "A Dessert"
        New-UDTableColumn -Property Calories -Title Calories 
        New-UDTableColumn -Property Fat -Title Fat 
        New-UDTableColumn -Property Carbs -Title Carbs 
        New-UDTableColumn -Property Protein -Title Protein 
    )

    New-UDTable -Id 'customColumnsTable' -Data $Data -Columns $Columns

    .EXAMPLE
    Creates a table where the table has custom rendering for one of the columns and an export button. 

    $Columns = @(
        New-UDTableColumn -Property Dessert -Title Dessert -Render { 
            $Item = $Body | ConvertFrom-Json 
            New-UDButton -Id "btn$($Item.Dessert)" -Text "Click for Dessert!" -OnClick { Show-UDToast -Message $Item.Dessert } 
        }
        New-UDTableColumn -Property Calories -Title Calories 
        New-UDTableColumn -Property Fat -Title Fat 
        New-UDTableColumn -Property Carbs -Title Carbs 
        New-UDTableColumn -Property Protein -Title Protein 
    )

    New-UDTable -Id 'customColumnsTableRender' -Data $Data -Columns $Columns -Sort -Export

    .EXAMPLE
    Creates a table within a New-UDDynamic that refreshes automatically on an interval. 

    New-UDDynamic -Content {
        $DynamicData = @(
            @{Dessert = 'Frozen yoghurt'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
            @{Dessert = 'Ice cream sandwich'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
            @{Dessert = 'Eclair'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
            @{Dessert = 'Cupcake'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
            @{Dessert = 'Gingerbread'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
        ) 

        New-UDTable -Id 'dynamicTable' -Data $DynamicData
    } -AutoRefresh -AutoRefreshInterval 2

    .EXAMPLE
    Creates a table that uses the LoadData script block to load data dynamically. 
    
    New-UDTable -Id 'loadDataTable' -Columns $Columns -LoadData {
    $Query = $Body | ConvertFrom-Json

    @(
        @{Dessert = 'Frozen yoghurt'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
        @{Dessert = 'Ice cream sandwich'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
        @{Dessert = 'Eclair'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
        @{Dessert = 'Cupcake'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
        @{Dessert = 'Gingerbread'; Calories = (Get-Random); Fat = 6.0; Carbs = 24; Protein = 4.0}
    ) | Out-UDTableData -Page 0 -TotalCount 5 -Properties $Query.Properties 
    
    .NOTES
    General notes
    #>
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid().ToString(),
        [Parameter()]
        [string]$Title = "",
        [Parameter(Mandatory, ParameterSetName = "Static")]
        [AllowNull()]
        [object[]]$Data = @(),
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

    if ($null -eq $Columns -and $null -ne $Data)
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
    <#
    .SYNOPSIS
    Defines a table column.
    
    .DESCRIPTION
    Defines a table column. Use this cmdlet in conjunction with New-UDTable's -Column property. Table columns can be used to control many aspects of the columns within a table. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Property
    The property to select from the data. 
    
    .PARAMETER Title
    The title of the column to show at the top of the table. 
    
    .PARAMETER Render
    How to render this table. Use this parameter instead of property to render custom content within a column. The $Body variable will contain the current row being rendered. 
    
    .PARAMETER Sort
    Whether this column supports sorting.
    
    .PARAMETER Filter
    Whether this column supports filtering.
    
    .PARAMETER Search
    Whether this column supports searching.
    
    .EXAMPLE
    See New-UDTable for examples. 
    #>
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
    <#
    .SYNOPSIS
    Formats data to be output from New-UDTable's -LoadData script block. 
    
    .DESCRIPTION
    Formats data to be output from New-UDTable's -LoadData script block. 
    
    .PARAMETER Data
    The data to return from LoadData. 
    
    .PARAMETER Page
    The current page we are on within the table. 
    
    .PARAMETER TotalCount
    The total count of items within the data set. 
    
    .PARAMETER Properties
    The properties that are currently passed from the table. You can return the array from the $EventData.Properties array. 
    
    .EXAMPLE
    See New-UDTable for examples. 
    #>
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