New-UDPage @AdditionalParameters -Name 'Usage' -Content {

    New-AppBar -Title "Usage"

    New-UDContainer -Content {
        New-UDTypography -Text "Usage" -Variant h3

        New-UDTypography -Text "1. Create a dashboard" -Variant h4

        New-UDPaper -Content {
            New-UDElement -Tag 'pre' -Content { "`$Dashboard = New-UDDashboard -Title `"Hello, World!`" -Content {
                New-UDHeading -Text `"Hello, World!`" -Size 1
            }" }
        }

        New-UDTypography -Text "2. Start a dashboard" -Variant h4

        New-UDPaper -Content {
            New-UDElement -Tag 'pre' -Content { "Start-UDDashboard -Dashboard `$Dashboard -Port 10001" }
        }
    }
}