$Cache:GridData =     @(
    @{
            Country = "MAURITANIA"
            Customers = 262
            FirstPurchaseDate = "5/30/2017"
        },
    @{
            Country = "NAURU"
            Customers = 649
            FirstPurchaseDate = "9/11/2017"
        },
    @{
            Country = "POLAND"
            Customers = 92
            FirstPurchaseDate = "8/8/2017"
        },
    @{
            Country = "SWITZERLAND"
            Customers = 830
            FirstPurchaseDate = "5/8/2017"
        },
    @{
            Country = "ISLE OF MAN"
            Customers = 641
            FirstPurchaseDate = "7/13/2017"
        },
    @{
            Country = "KYRGYZSTAN"
            Customers = 857
            FirstPurchaseDate = "7/30/2017"
        }
     )




$Basic = {
    New-UDTable -Title "Customers" -Headers @("Country", "Customers", "First Purchase Date") -FontColor "black" -Endpoint {
        $Cache:GridData | Out-UDTableData -Property @("Country", "Customers", "FirstPurchaseDate")
    }
}

New-UDPage -Name "Tables" -Icon table -Content {
    New-UDPageHeader -Title "Tables" -Icon "table" -Description "Display data in a static table." -DocLink "https://docs.universaldashboard.io/components/tables"
    New-UDExample -Title "Basic Table" -Description "Display data in a table." -Script $Basic
}