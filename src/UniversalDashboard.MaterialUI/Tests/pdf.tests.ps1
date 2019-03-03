Describe "Pdf" {
    Context "content" {
        Set-TestDashboard {
            New-UDCard -Content {
                New-UDPdf -FilePath "/files/sample.pdf" -Id 'pdf'
            }
        } 

        It 'has content' {
            Find-SeElement -Id 'pdf' -Driver $Driver | should not be $null
        }
    }
}