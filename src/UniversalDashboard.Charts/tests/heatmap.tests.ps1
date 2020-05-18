$Data = @(
    @{
        state = "idaho"
        cats = 72307
        dogs = 23429
        moose = 23423
        bears = 784
    }
    @{
        state = "wisconsin"
        cats = 2343342
        dogs = 3453623
        moose = 1
        bears = 23423
    }
    @{
        state = "montana"
        cats = 9234
        dogs = 3973457
        moose = 23472
        bears = 347303
    }
    @{
        state = "colorado"
        cats = 345973789
        dogs = 0237234
        moose = 2302
        bears = 2349772
    }
)
Describe "Heatmap" {
    Context "Basic Heatmap" {
        Set-TestDashboard {
            $Parameters = @{
                Data = $Data
                IndexBy = 'state'
                Keys = @('cats', 'dogs', 'moose', 'bears')
            }

            New-UDNivoChart -Heatmap @Parameters
        } 

        It "has a chart" {
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq '72307' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq '3973457' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq '23472' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq '2349772' } | Should not be $null

            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq 'idaho' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq 'wisconsin' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq 'montana' } | Should not be $null
            Find-SeElement -By TagName -Tag 'text' -Driver $Driver | Where-Object { $_.text -eq 'colorado' } | Should not be $null
        }
    }
}

