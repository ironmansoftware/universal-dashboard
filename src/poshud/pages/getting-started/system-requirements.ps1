New-UDPage -Name 'System Requirements' -Content {

    New-AppBar -Title "System Requirements"

    New-UDContainer -Content {
        New-UDTypography -Text "System Requirements" -Variant h3

        New-UDList -Content {
            New-UDListItem -Label "Windows PowerShell v5.1 or greater or PowerShell Core v6.1 or greater"
            New-UDListItem -Label ".NET Framework v4.7.2 (only for Windows PowerShell)"
        }
    }
}