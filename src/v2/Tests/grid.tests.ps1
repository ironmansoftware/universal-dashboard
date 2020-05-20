Describe "Grid" {
    It "should set grid to single item" {
        $Cache:refreshdata =  @([PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"})

        $Button = Find-SeElement -Driver $Driver -Id 'refreshgrid-btn-refresh'
        Invoke-SeClick -Element $Button

        $Element = Find-SeElement -Id "RefreshGrid" -Driver $Driver
        $Element = Find-SeElement -ClassName "griddle-row" -Driver $Element[0] 
        $Element.Length | Should be 1
    }

    It "should set grid to empty" {
        $Cache:refreshdata =  @()

        $Button = Find-SeElement -Driver $Driver -Id 'refreshgrid-btn-refresh'
        Invoke-SeClick -Element $Button

        $Element = Find-SeElement -Id "RefreshGrid" -Driver $Driver
        $Element = Find-SeElement -ClassName "griddle-row" -Driver $Element[0] 
        $Element.Length | Should be 0
    }
    
    It "should set grid to empty if null" {
        $Cache:refreshdata =  $null

        $Button = Find-SeElement -Driver $Driver -Id 'refreshgrid-btn-refresh'
        Invoke-SeClick -Element $Button

        $Element = Find-SeElement -Id "RefreshGrid" -Driver $Driver
        $Element = Find-SeElement -ClassName "griddle-row" -Driver $Element[0] 
        $Element.Length | Should be 0
    }

    It "should not page when NoPaging set" {
        $Element = Find-SeElement -Id "NoPagingGrid" -Driver $Driver
        $Element = Find-SeElement -ClassName "griddle-row" -Driver $Element[0] 
        $Element.Length | Should be 18
    }

    It "should set page size" {
        $Element = Find-SeElement -Id "PageSizeGrid" -Driver $Driver
        $Element = Find-SeElement -ClassName "griddle-row" -Driver $Element[0] 
        $Element.Length | Should be 5
    }

    It "should headings" {
        $Element = Find-SeElement -Id "Grid" -Driver $Driver
        $Element = Find-SeElement -ClassName "griddle-table-heading-cell" -Driver $Element[0]
        $Element.Length | Should be 3
        $Element[0].Text.Contains('day') | should be $true
        $Element[1].Text | should be "jpg"
        $Element[2].Text | should be "mp4"
    }

    It "should have data" {
        $Element = Find-SeElement -ClassName "griddle-row" -Driver $Driver
        $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Element[0] 
        $Element.Length | Should be 3
        $Element[0].Text | should be "1"
        $Element[1].Text | should be "10"
        $Element[2].Text | should be "30"
    }

    It "should sort data" {
        
        $Element = Find-SeElement -ClassName "griddle-table-heading-cell" -Driver $Driver
        $header = $element[0]
        Invoke-SeClick $header

        $Row = Find-SeElement -ClassName "griddle-row" -Driver $Driver
        $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[0] 
        $Element[0].Text | should be "1"
        $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[1] 
        $Element[0].Text | should be "1"
        
        $Element = Find-SeElement -ClassName "griddle-table-heading-cell" -Driver $Driver
        $header = $element[0]
        Invoke-SeClick $header

        $Row = Find-SeElement -ClassName "griddle-row" -Driver $Driver
        $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[0] 
        $Element[0].Text | should be "3"
        $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[1] 
        $Element[0].Text | should be "3"
    }

    It "should have data in single item grid" {
        $Element = Find-SeElement -Id "SingleItemGrid" -Driver $Driver
        $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Element[0] 
        $Element.Length | Should be 3
        $Element[0].Text | should be "1"
        $Element[1].Text | should be "10"
        $Element[2].Text | should be "30"
    }

    It "should filter data" {
        
        $Element = Find-SeElement -Id 'ServerSideGrid' -Target $Driver
        $Element = Find-SeElement -ClassName "griddle-filter" -Target $Element

        Send-SeKeys -Element $Element[0] -Keys "2"
        Start-Sleep 1
        Send-SeKeys -Element $Element[0] -Keys "0"

        $Grid = Find-SeElement -Id "ServerSideGrid" -Driver $Driver
        $Element = Find-SeElement -ClassName "griddle-row" -Target $Grid[0]
        $Element.Length | Should be 6

        $pagination  = Find-SeElement -ClassName "pagination" -Target $Grid[0] | Select-Object -First 1
        $pagination | should be $null
    }

    
    It "should page data" {

        $Element = Find-SeElement -Id 'ServerSideGrid' -Target $Driver
        $Element = Find-SeElement -ClassName "page-right" -Target $Element
        Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver

        Start-Sleep 1

        $Element = Find-SeElement -Id 'ServerSideGrid' -Target $Driver
        $Row = Find-SeElement -ClassName "griddle-row" -Target $Target
        $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[7] 
        $Element[0].Text | should be "3"
    }

    It "should have data" {
        Start-Sleep 1

        $Element = Find-SeElement -Id 'ServerSideGrid' -Target $Driver
        $Element = Find-SeElement -ClassName "griddle-row" -Target $Element
        $Element = Find-SeElement -ClassName "griddle-cell" -Target $Element[0] 
        $Element.Length | Should be 3
        $Element[0].Text | should be "1"
        $Element[1].Text | should be "10"
        $Element[2].Text | should be "30"
    }

    It "should sort data" {
        $Element = Find-SeElement -Id 'ServerSideGrid' -Target $Driver
        $Row = Find-SeElement -ClassName "griddle-row" -Target $Target
        $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[0] 
        $Element[0].Text | should be "1"
        $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[1] 
        $Element[0].Text | should be "1"

        $Element = Find-SeElement -Id 'ServerSideGrid' -Target $Driver
        $Element = Find-SeElement -ClassName "griddle-table-heading-cell" -Target $Element
        $header = $element[0]
        Invoke-SeClick $header

        $Element = Find-SeElement -Id 'ServerSideGrid' -Target $Driver
        $Row = Find-SeElement -ClassName "griddle-row" -Target $Element
        $Element = Find-SeElement -ClassName "griddle-cell" -Target $Row[0] 
        $Element[0].Text | should be "3"
        $Element = Find-SeElement -ClassName "griddle-cell" -Target $Row[1] 
        $Element[0].Text | should be "3"
        
        $Element = Find-SeElement -Id 'ServerSideGrid' -Target $Driver
        $Element = Find-SeElement -ClassName "griddle-table-heading-cell" -Target $Element
        $header = $element[0]
        Invoke-SeClick $header

        $Element = Find-SeElement -Id 'ServerSideGrid' -Target $Driver
        $Row = Find-SeElement -ClassName "griddle-row" -Target $Element
        $Element = Find-SeElement -ClassName "griddle-cell" -Target $Row[0] 
        $Element[0].Text | should be "1"
        $Element = Find-SeElement -ClassName "griddle-cell" -Target $Row[1] 
        $Element[0].Text | should be "1"
    }

    It "should filter data" {
        $Element = Find-SeElement -Id 'ServerSideGrid' -Target $Driver
        $Element = Find-SeElement -ClassName "griddle-filter" -Target $Target

        Send-SeKeys -Element $Element[0] -Keys "2"
        Sleep 1
        Send-SeKeys -Element $Element[0] -Keys "0"

        $Element = Find-SeElement -Id 'ServerSideGrid' -Target $Driver
        $Element = Find-SeElement -ClassName "griddle-row" -Target $Element
        $Element.Length | Should be 6
    }

    It "should refresh" {
        $Element = Find-SeElement -Id 'RefreshFilterGrid' -Target $Driver
        $Element = Find-SeElement -ClassName "griddle-filter" -Target $Element

        Send-SeKeys -Element $Element[0] -Keys "2"
        Start-Sleep 1
        Send-SeKeys -Element $Element[0] -Keys "0"

        $Element = Find-SeElement -Id 'RefreshFilterGrid' -Target $Driver
        $Element = Find-SeElement -ClassName "griddle-row" -Target $Element
        $Element.Length | Should be 6

        Start-Sleep 5 

        $Element = Find-SeElement -Id 'RefreshFilterGrid' -Target $Driver
        $Element = Find-SeElement -ClassName "griddle-row" -Target $Element
        $Element.Length | Should be 6    
    }

    
    It "should have link" {
        $Element = Find-SeElement -Id 'SimpleGrid' -Target $Driver
        Find-SeElement -LinkText "This is text" -Target $Element | Should not be $null
    }

    It "should format date correctly" {
        $Element = Find-SeElement -Id "SimpleGrid" -Driver $Driver
        $Element = Find-SeElement -ClassName "griddle-cell" -Target $Element[0] 
        $Element[5].Text | Should BeLike "Dec 2, 2007*"
    }

    It "should format bool correctly" {
        $Element = Find-SeElement -Id "SimpleGrid" -Driver $Driver
        $Element = Find-SeElement -ClassName "griddle-cell" -Target $Element[0] 
        $Element[7].Text | Should Be 'true'
    } 

    #----

    It "should click button" {
        $Element = Find-SeElement -Id "CustomGrid" -Driver $Driver
        $Button = Find-SeElement -Id "button" -Target $Element 
        Invoke-SeClick -Element $Button 

        Start-Sleep -Seconds 5

        (Find-SeElement -Id "Hey" -Driver $Driver).Text | should be "Hey"
    }


    It "should have link" {
        $Element = Find-SeElement -Id "CustomGrid" -Driver $Driver
        Find-SeElement -LinkText "This is text" -Target $Element | Should not be $null
    }

    It "should have link in footer" {
        $Element = Find-SeElement -Id "CustomGrid" -Driver $Driver
        Find-SeElement -LinkText "OTHER LINK" -Target $Element | Should not be $null
    }

    It "should format date correctly" {
        $Element = Find-SeElement -Id "CustomGrid" -Driver $Driver
        $Element = Find-SeElement -ClassName "griddle-cell" -Target $Element[0] 
        $Element[5].Text | Should BeLike "Dec 2, 2007*"
    }

    It "should format bool correctly" {
        $Element = Find-SeElement -Id "CustomGrid" -Driver $Driver
        $Element = Find-SeElement -ClassName "griddle-cell" -Target $Element[0] 
        $Element[7].Text | Should Be 'true'
    }

    #------

    
    It "should not shown an error with no data" {
        $Element = Find-SeElement -Id "Grid1" -Driver $Driver

        Start-Sleep 2

        $Element.Text.Contains("No results found") | Should be $true
    }

    It "should not shown an error with invalid output" {
        $Element = Find-SeElement -Id "Grid2" -Driver $Driver

        Start-Sleep 2

        $Element.Text.Contains("No results found") | Should be $true
    }

    It "should be able to nest new-udelement in grid" {
        $Element = Find-SeElement -Id "Grid3" -Driver $Driver
        $Element = Find-SeElement -Id "nested-element" -Driver $Driver

        Start-Sleep 2

        $Element.Text.Contains("Stopped") | Should be $true
    }

    It "should not shown an error with no data" {
        $Element = Find-SeElement -Id "ThrowGrid" -Driver $Driver

        Start-Sleep 1

        $Element.Text.Contains("No results found") | Should be $true
    }

    
    It "should have sorted correctly" {
        $Element = Find-SeElement -Id "DefaultSortGrid" -Driver $Driver
        $Element = Find-SeElement -ClassName "griddle-row" -Target $Element
        $Element = Find-SeElement -ClassName "griddle-cell" -Target $Element[0] 
        $Element[1].Text | should be "30"
        
        $Element = Find-SeElement -Id "DefaultSortGrid" -Driver $Driver
        $Element = Find-SeElement -ClassName "griddle-row" -Target $Element
        $Element = Find-SeElement -ClassName "griddle-cell" -Target $Element[1] 
        $Element[1].Text | should be "20"
    }

    It "should refresh" {
        $previousText = ""

        $Element = Find-SeElement -Id "RefreshGrid" -Driver $Driver
        $Element = Find-SeElement -ClassName "griddle-row" -Target $Element
        $Element = Find-SeElement -ClassName "griddle-cell" -Target $Element[0] 
        $text = $Element[2].text 

        Start-Sleep 3

        $Element = Find-SeElement -Id "RefreshGrid" -Driver $Driver
        $NewElement = Find-SeElement -ClassName "griddle-row" -Target $Element
        (Find-SeElement -ClassName "griddle-cell" -Target $NewElement[0])[2].Text | should not be $text     
    }
}