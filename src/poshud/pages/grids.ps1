$GridData =     @(
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
        },
    @{
            Country = "GIBRALTAR"
            Customers = 223
            FirstPurchaseDate = "9/3/2017"
        },
    @{
            Country = "BAHRAIN"
            Customers = 912
            FirstPurchaseDate = "9/10/2017"
        },
    @{
            Country = "PAKISTAN"
            Customers = 913
            FirstPurchaseDate = "6/9/2017"
        },
    @{
            Country = "MALAWI"
            Customers = 281
            FirstPurchaseDate = "6/14/2017"
        },
    @{
            Country = "HONG KONG"
            Customers = 255
            FirstPurchaseDate = "8/19/2017"
        },
    @{
            Country = "DOMINICA"
            Customers = 80
            FirstPurchaseDate = "8/3/2017"
        },
    @{
            Country = "GHANA"
            Customers = 275
            FirstPurchaseDate = "4/15/2017"
        },
    @{
            Country = "ISRAEL"
            Customers = 380
            FirstPurchaseDate = "5/11/2017"
        },
    @{
            Country = "FRENCH POLYNESIA"
            Customers = 155
            FirstPurchaseDate = "4/20/2017"
        },
    @{
            Country = "PANAMA"
            Customers = 130
            FirstPurchaseDate = "9/3/2017"
        },
    @{
            Country = "ESTONIA"
            Customers = 468
            FirstPurchaseDate = "8/12/2017"
        },
    @{
            Country = "BANGLADESH"
            Customers = 794
            FirstPurchaseDate = "7/29/2017"
        },
    @{
            Country = "�LAND ISLANDS"
            Customers = 989
            FirstPurchaseDate = "8/20/2017"
        },
    @{
            Country = "ANGOLA"
            Customers = 377
            FirstPurchaseDate = "4/22/2017"
        }

     )


$Basic = {
    New-UDGrid -Title "Customer Locations"  -Headers @("Country", "Customers", "First Purchase Date") -Properties @("Country", "Customers", "FirstPurchaseDate") -Endpoint {
        $GridData | Out-UDGridData
    } -FontColor "black"
}

$AutoRefresh = {
    New-UDGrid -Title "Customer Locations"  -Headers @("Country", "Customers", "First Purchase Date") -Properties @("Country", "Customers", "FirstPurchaseDate") -Endpoint {
        $GridData | Out-UDGridData
    } -AutoRefresh -RefreshInterval 5 -FontColor "black"
}

New-UDPage -Name "Grids" -Icon th_large -Content {
    New-UDPageHeader -Title "Grids" -Icon "th-large" -Description "Display data in a grid that can sort, filter and page." -DocLink "https://docs.universaldashboard.io/components/grids"
    New-UDExample -Title "Basic Grids" -Description "A basic grid that displays data." -Script $Basic
    New-UDExample -Title "Auto Refreshing Grids" -Description "A grid that auto refreshes" -Script $AutoRefresh
}