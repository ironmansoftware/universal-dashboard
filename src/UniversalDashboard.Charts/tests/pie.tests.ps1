$Data = @(
    @{
        id = "idaho"
        label = "idaho"
        value = 9993
    }
    @{
        id = "wisconsin"
        label = "wisconsin"
        value = 2342
    }
    @{
        id = "montana"
        label = "montana"
        value = 2361
    }
    @{
        id = "colorado"
        label = "colorado"
        value = 9732
    }
)
Describe "Pie" {
    Context "Basic Pie" {
        Set-TestDashboard {
            $Parameters = @{
                Data = $Data
            }

            New-UDNivoChart -Pie @Parameters
        } 

        It "has a chart" {
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq '9993' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq '2342' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq '2361' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq '9732' } | Should not be $null

            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq 'idaho' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq 'wisconsin' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq 'montana' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq 'colorado' } | Should not be $null
        }
    }
}

