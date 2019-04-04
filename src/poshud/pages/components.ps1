$Components = New-UDPage -Name Components -Icon chart_area -Content {
    New-UDHtml -Markup '<link rel="stylesheet"
    href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/agate.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js"></script><script>hljs.initHighlightingOnLoad();</script>'
 

    New-UDRow {
        New-UDColumn -Size 3 {
            New-UDCard @AlternateColors -Title "Grids" -Text "Display data in a table that supports client and server side paging."
        }
        New-UDColumn -Size 9 {
            New-UDCard @ScriptColors -Language "PowerShell" -Text 'New-UDGrid -Title "Customer Locations" @Colors -Headers @("Country", "Customers", "First Purchase Date") -Properties @("Country", "Customers", "FirstPurchaseDate") -AutoRefresh -RefreshInterval 20 -Endpoint {
                Invoke-RestMethod http://myserver/api/myendpoint | Out-UDGridData
} ' -Title "PowerShell"
        }
    }
    New-UDRow {
        New-UDColumn -Size 12 {
            New-UDGrid -Title "Customer Locations" @Colors -Headers @("Country", "Customers", "First Purchase Date") -Properties @("Country", "Customers", "FirstPurchaseDate") -AutoRefresh -RefreshInterval 20 -Endpoint {
                
                                     @(
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
                
                                             )  | Out-UDGridData
                                }
        }
    }
    New-UDRow {
        New-UDColumn -Size 3 {
            New-UDCard @AlternateColors -Title "Tables" -Text "Display static table data. Refresh on a customizable interval."
        }
        New-UDColumn -Size 9 {
            New-UDCard @ScriptColors -Language "PowerShell" -Text 'New-UDTable -Title "Top GitHub Issues" -Headers @("Id", "Title", "Description", "Comments") @Colors -Endpoint {
    $issues = @();
    $issues += [PSCustomObject]@{ "ID" = (Get-Random -Minimum 10 -Maximum 10000);  "Title" = "Product is too awesome...";  "Description" = "Universal Desktop is just too awesome."; Comments = (Get-Random -Minimum 10 -Maximum 10000) }
    $issues += [PSCustomObject]@{ "ID" = (Get-Random -Minimum 10 -Maximum 10000);  "Title" = "Support for running on a PS4";  "Description" = "A dashboard on a PS4 would be pretty cool."; Comments = (Get-Random -Minimum 10 -Maximum 10000) }
    $issues += [PSCustomObject]@{ "ID" = (Get-Random -Minimum 10 -Maximum 10000);  "Title" = "Bug in the flux capacitor";  "Description" = "The flux capacitor is constantly crashing."; Comments = (Get-Random -Minimum 10 -Maximum 10000) }
    $issues += [PSCustomObject]@{ "ID" = (Get-Random -Minimum 10 -Maximum 10000);  "Title" = "Feature Request - Hypnotoad Widget";  "Description" = "Every dashboard needs more hypnotoad"; Comments = (Get-Random -Minimum 10 -Maximum 10000) }
    
    $issues | Out-UDTableData -Property @("ID", "Title", "Description", "Comments") 
}' -Title "PowerShell"
        }

    }
    New-UDRow {
        New-UDColumn -Size 12 {
            New-UDTable -Title "Top GitHub Issues" -Headers @("Id", "Title", "Description", "Comments") @Colors -Endpoint {
                $issues = @();
                $issues += [PSCustomObject]@{ "ID" = (Get-Random -Minimum 10 -Maximum 10000);  "Title" = "Product is too awesome...";  "Description" = "Universal Desktop is just too awesome."; Comments = (Get-Random -Minimum 10 -Maximum 10000) }
                $issues += [PSCustomObject]@{ "ID" = (Get-Random -Minimum 10 -Maximum 10000);  "Title" = "Support for running on a PS4";  "Description" = "A dashboard on a PS4 would be pretty cool."; Comments = (Get-Random -Minimum 10 -Maximum 10000) }
                $issues += [PSCustomObject]@{ "ID" = (Get-Random -Minimum 10 -Maximum 10000);  "Title" = "Bug in the flux capacitor";  "Description" = "The flux capacitor is constantly crashing."; Comments = (Get-Random -Minimum 10 -Maximum 10000) }
                $issues += [PSCustomObject]@{ "ID" = (Get-Random -Minimum 10 -Maximum 10000);  "Title" = "Feature Request - Hypnotoad Widget";  "Description" = "Every dashboard needs more hypnotoad"; Comments = (Get-Random -Minimum 10 -Maximum 10000) }
                
                $issues | Out-UDTableData -Property @("ID", "Title", "Description", "Comments") 
            }
        }
    }
    New-UDRow {
        New-UDColumn -Size 3 {
            New-UDCard @AlternateColors -Title "Images" -Text "Display images from the web or from disk. Refresh images on the fly and generate them from endpoints."
        }
        New-UDColumn -Size 9 {
            New-UDCard @ScriptColors -Language "PowerShell" -Text 'New-UDImage -Url https://poshtools.com/wp-content/uploads/2017/04/PoshToolsLogo-2.png -Height 100 -Width 100' -Title "PowerShell"
        }
    }
    New-UDRow {
        New-UDColumn -Size 3 {
            New-UDImage -Url https://poshtools.com/wp-content/uploads/2017/04/PoshToolsLogo-2.png -Height 75 -Width 300
        }
        New-UDColumn -Size 3 {
            New-UDImage -Url https://poshtools.com/wp-content/uploads/2017/04/PoshToolsLogo-2.png -Height 75 -Width 300
        }
        New-UDColumn -Size 3 {
            New-UDImage -Url https://poshtools.com/wp-content/uploads/2017/04/PoshToolsLogo-2.png -Height 75 -Width 300
        }
        New-UDColumn -Size 3 {
            New-UDImage -Url https://poshtools.com/wp-content/uploads/2017/04/PoshToolsLogo-2.png -Height 75 -Width 300
        }
    }
}