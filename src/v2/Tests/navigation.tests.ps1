Describe "Navigation" {
    Context "Named Dynamic Pages" {
        $Page1 = New-UDPage -Name 'Page1' -Endpoint { New-UDHeading -Id 'page1' -Text 'Page1' }
        $Page2 = New-UDPage -Name 'Page2' -Endpoint { New-UDHeading -Id 'page2' -Text 'Page2' }

        Set-TestDashboard -Dashboard (
            New-UDDashboard -Title 'test' -Pages @($Page1, $Page2)
        )

        It "should navigate between pages" {
            Start-Sleep 1

            $Element = Find-SeElement -Id "sidenavtrigger" -Driver $Driver
            Invoke-SeClick $Element -JavaScriptClick -Driver $Driver

            Start-Sleep 1

            $Element = Find-SeElement -LinkText "Page2" -Driver $Driver
            Invoke-SeClick $Element -JavaScriptClick -Driver $Driver

            Start-Sleep 1

            Find-SeElement -Id "page2" -Driver $Driver | Should not be $null
        }
    }
}