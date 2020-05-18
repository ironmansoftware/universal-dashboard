$Data = @(
    @{
        id = 'japan'
        data = @(
            @{
                'x' = 'plane'
                'y' = 290
            }
            @{
                'x' = 'helicopter'
                'y' = 143
            }
            @{
                'x' = 'boat'
                'y' = 282
            }
            @{
                'x' = 'train'
                'y' = 88
            }
        )
    }
)

Describe "Line Chart" {
    Context "Basic Chart" {
        Set-TestDashboard {
            $Parameters = @{
                Data = $Data
                Height = 500
                Width = 1000
                MarginTop = 50
                MarginRight = 130
                MarginBottom = 50
                MarginLeft = 60
            }

            New-UDNivoChart -Line @Parameters
        } 

        It "has a chart" {
            Find-SeElement -By TagName -Tag 'g' -Driver $Driver | Where-Object { ($_ | Get-SeElementAttribute -Attribute 'transform') -eq 'translate(0, 0)'  } | Should not be $null
            Find-SeElement -By TagName -Tag 'g' -Driver $Driver | Where-Object { ($_ | Get-SeElementAttribute -Attribute 'transform') -eq 'translate(270, 203)'  } | Should not be $null
            Find-SeElement -By TagName -Tag 'g' -Driver $Driver | Where-Object { ($_ | Get-SeElementAttribute -Attribute 'transform') -eq 'translate(540, 11)'  } | Should not be $null
            Find-SeElement -By TagName -Tag 'g' -Driver $Driver | Where-Object { ($_ | Get-SeElementAttribute -Attribute 'transform') -eq 'translate(810, 279)'  } | Should not be $null
        }
    }

    Context "Theme Colors" {
        Set-TestDashboard {

            $Theme = New-UDNivoTheme -TickTextColor 'red'

            $Parameters = @{
                Data = $Data
                Height = 500
                Width = 1000
                MarginTop = 50
                MarginRight = 130
                MarginBottom = 50
                MarginLeft = 60
                Theme = $Theme
            }

            New-UDNivoChart -Line @Parameters
        } 

        It "has label colors" {
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq 'helicopter' } | Get-SeElementCssValue -Name 'fill' | should be "rgb(255, 0, 0)"
        }
    }
}

