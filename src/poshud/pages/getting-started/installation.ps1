New-UDPage @AdditionalParameters -Name 'Installation' -Content {

    New-AppBar -Title "Installation"

    New-UDContainer -Content {
        New-UDTypography -Text "Installation" -Variant h3

        New-UDTypography -Text "You can install Universal Dashboard from the PowerShell Gallery using Install-Module"
    
        New-UDPaper -Content {
            New-UDElement -Tag 'pre' -Content { "Install-Module UniversalDashboard -AllowPrerelease" }
        }
    }
}