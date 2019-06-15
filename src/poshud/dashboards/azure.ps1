New-UDPage -Name "Azure" -Content {
    New-UDLayout -Columns 4  -Content {
        New-UDChart -Type Line -Title "Unique Sessions and Users" -Endpoint {
            $Data = 1..30 | ForEach-Object {
                [PSCustomObject]@{ time = $_; sessions = [Math]::Round(1000 / $_); users = [Math]::Round(75 / $_) }
            }

            $Data | Out-UDChartData -LabelProperty "time" -Dataset @(
                New-UDChartDataset -DataProperty "users" -Label "Users" -BackgroundColor @("#FFD880")
                New-UDChartDataset -DataProperty "sessions" -Label "Sessions" -BackgroundColor @("#9336B3")
            )
        }

        New-UDChart -Type Pie -Title "Subscription Spent" -Endpoint {
            $Data = @(
                [PSCustomObject]@{ resource = "poshud_db"; amount = 134.93 }
                [PSCustomObject]@{ resource = "poshud_app"; amount = 21.22 }
                [PSCustomObject]@{ resource = "poshud_app_insights"; amount = 219.32 }
                [PSCustomObject]@{ resource = "poshud_vault"; amount = 12.46 }
            )

            $Data | Out-UDChartData -LabelProperty "resource" -DataProperty "amount" -BackgroundColor @("#9336B3", "#FFD880", "blue", "#D966FF")
        }

        New-UDChart -Type HorizontalBar -Title "Uptime" -Endpoint {
            $Data = @(
                [PSCustomObject]@{ resource = "poshud_db"; amount = 100.0 }
                [PSCustomObject]@{ resource = "poshud_app"; amount = 87.00 }
                [PSCustomObject]@{ resource = "poshud_app_insights"; amount = 93.00 }
                [PSCustomObject]@{ resource = "poshud_vault"; amount = 100.00 }
            )

            $Data | Out-UDChartData -LabelProperty "resource" -DataProperty "amount" -BackgroundColor @("#9336B3", "#FFD880", "blue", "#D966FF")
        }

        New-UDRow -Columns {
            New-UDColumn -Content {
                New-UDCounter -Title "Users" -Icon user -Endpoint {
                    158 
                }
                New-UDCounter -Title "Sessions" -Icon desktop -Endpoint {
                    1321
                }
            }
        }

    } 



    New-UDTable -Title "Recent Resources" -Headers @(" ", "Name", "Type", "Last Viewed") -Endpoint {
        @(
            [PSCustomObject]@{ Icon = New-UDIcon -Icon database; Name = "poshud_db"; Type = "SQL server"; LastViewed = "3 hr ago"  }
            [PSCustomObject]@{ Icon = New-UDIcon -Icon globe; Name = "poshud_app"; Type = "App Services"; LastViewed = "1 wk ago"  }
            [PSCustomObject]@{ Icon = New-UDIcon -Icon lightbulb; Name = "poshud_app_insights"; Type = "Application Insights"; LastViewed = "2 mo ago"  }
            [PSCustomObject]@{ Icon = New-UDIcon -Icon key; Name = "poshud_vault"; Type = "Key vault"; LastViewed = "42 yr ago"  }
        ) | Out-UDTableData -Property @("Icon", "Name", "Type", "LastViewed")
    }
}