$Data = @(
    @{
        state = "idaho"
        population = 1720000
    }
    @{
        state = "wisconsin"
        population = 5800000
    }
    @{
        state = "montana"
        population = 1050000
    }
    @{
        state = "illinois"
        population = 12800000
    }
)

Describe "Bar Chart" {

    Context "Tabs" {
        Set-TestDashboard {
            $Parameters = @{
                Data = $Data
                Keys = 'population'
                IndexBy = 'state'
            }

            New-UDTabContainer -Tabs {
                New-UDTab -Text "Test" -Content {
                    New-UDNivoChart -Bar @Parameters
                }
            }
        } 

        It "has a chart" {
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq '1720000' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq '5800000' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq '1050000' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq '12800000' } | Should not be $null

            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq 'idaho' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq 'wisconsin' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq 'montana' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq 'illinois' } | Should not be $null
        }
    }


    Context "Basic Chart" {
        Set-TestDashboard {
            $Parameters = @{
                Data = $Data
                Keys = 'population'
                IndexBy = 'state'
            }

            New-UDNivoChart -Bar @Parameters
        } 

        It "has a chart" {
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq '1720000' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq '5800000' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq '1050000' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq '12800000' } | Should not be $null

            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq 'idaho' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq 'wisconsin' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq 'montana' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq 'illinois' } | Should not be $null
        }

        It "has sane defaults" {
            Find-SeElement -By TagName -Tag 'svg' -Driver $Driver | Get-SeElementCssValue -Name 'height' | Should be '500px'
        }
    }

    Context "Responsive" {
        Set-TestDashboard {
            $Parameters = @{
                Data = $Data
                Keys = 'population'
                IndexBy = 'state'
                MarginTop = 50
                MarginRight = 130
                MarginBottom = 50
                MarginLeft = 60
                Padding = 0.3
                Height = 500
            }

            New-UDRow -Columns {
                New-UDColumn -SmallSize 12 {
                    New-UDCard -Title "Test" -Content {
                        New-UDNivoChart -Bar -Responsive @Parameters
                    }
                }
            }
        } 

        It "is expanded" {
            Find-SeElement -By TagName -Tag 'svg' -Driver $Driver | Get-SeElementCssValue -Name 'width' | Should not be '0px'
        }
    }

    Context "Label Color" {
        Set-TestDashboard {
            $Parameters = @{
                Data = $Data
                Keys = 'population'
                IndexBy = 'state'
                Height = 500
                Width = 1000
                MarginTop = 50
                MarginRight = 130
                MarginBottom = 50
                MarginLeft = 60
                Padding = 0.3
                LabelTextColor = 'green'
            }

            New-UDNivoChart -Bar @Parameters
        } 

        It "has label colors" {
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq '1720000' } | Get-SeElementCssValue -Name 'fill' | should be "rgb(0, 128, 0)"
        }
    }

    Context "Theme Colors" {
        Set-TestDashboard {

            $Theme = New-UDNivoTheme -TickTextColor 'red'

            $Parameters = @{
                Data = $Data
                Keys = 'population'
                IndexBy = 'state'
                Height = 500
                Width = 1000
                MarginTop = 50
                MarginRight = 130
                MarginBottom = 50
                MarginLeft = 60
                Padding = 0.3
                LabelTextColor = 'green'
                Theme = $Theme
            }

            New-UDNivoChart -Bar @Parameters
        } 

        It "has label colors" {
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq 'wisconsin' } | Get-SeElementCssValue -Name 'fill' | should be "rgb(255, 0, 0)"
        }
    }

    Context "OnClick" {
        Set-TestDashboard {
            $Parameters = @{
                Data = $Data
                Keys = 'population'
                IndexBy = 'state'
                OnClick = {
                    Set-TestData -Data 'Clicked'
                }
            }

            New-UDNivoChart -Bar @Parameters
        } 

        It "was clicked" {
            #$Element = Find-SeElement -Tag 'g' -Driver $Driver | Where-Object { ($_ | Get-SeElementAttribute -Attribute 'transform') -eq 'translate(331, 219)' }
            #Invoke-SeClick -Element $Element  -Driver $Driver -JavaScriptClick
            #Get-TestData | Should be 'Click'
        }
    }
}

