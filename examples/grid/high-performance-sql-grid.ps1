<#
    Provides an example of overriding the default filtering, sort and paging mechanism by querying SQL.
#>

Import-Module UniversalDashboard

$Dashboard = New-UDDashboard -Title "Grids - Simple" -Content {
    New-UDGrid -Title "Animals" -Headers @("Animal", "Order") -Properties @("Animal", "Order") -Endpoint {
        #Overrides filtering, sorting and paging. This ensures that SQL does the actions. 
        #All UDGrid endpioints have the following variables: 
        # - $sortAscending - Whether or not the sort is ascending
        # - $sortColumn - The name of the column to sort on 
        # - $filterText - The text to filter the data by
        # - $skip - The number of items to skip (used in paging)
        # - $take - The number of items to return (used in paging)

        $sortOrder = "DESC"
        if ($sortAscending ) {
            $sortOrder = "ASC"
        }

        $TotalItems = (Invoke-SqlCmd -Query "SELECT COUNT(*) as Total FROM animals WHERE Animal LIKE '%$filterText%' ").Total

        $Result = Invoke-SqlCmd -Query "SELECT Animal, Order FROM animals WHERE Animal LIKE '%$filterText%' ORDER BY $sortColumn $sortOrder OFFSET ($skip) ROWS FETCH NEXT ($take) ROWS ONLY " 

        $Result | Out-UDGridData -TotalItems $TotalItems
    } -ServerSideProcessing
}

Start-UDDashboard -Dashboard $Dashboard -Port 8080  
