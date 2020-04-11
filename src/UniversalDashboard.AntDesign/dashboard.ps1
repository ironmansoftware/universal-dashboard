# ipmo D:\GPM\github.com\AlonGvili\UniversalDashboard.Antd\src\output\UniversalDashboard.Antd\UniversalDashboard.Antd.psd1 -Force
$Dashboard = New-UDDashboard -Title "Dashboard" -Theme (get-udtheme basic) -Pages @(
    New-UDPage -Name 'Icons' -Content {
        New-UDElement -Tag 'main' -Content {
            (Get-Command -Name New-UDAntdIcon).parameters["Icon"].Attributes.ValidValues.foreach( {
                    New-UDAntdIcon -Icon $_ -Size 4x
                })
        }
    }
    New-UDPage -url '/Badge/colors' -Endpoint {
        
        (Get-Command -Name New-UDAntdBadge).Parameters["PresetColor"].Attributes.ValidValues | % {
            New-UDAntdBadge -PresetColor $_ -Content ( New-UDAntdIcon -Icon BellOutlined -Size 2x )
        }   
           
    }
    New-UDPage -Name 'Form' -Content {
        New-UDAntdNotification -Id "info" -Title "Universal Dashboard" -Description "Notification Description Content" -Preset "info"
        New-UDAntdForm -Id 'demoForm' -Variant small -Content {
            New-UDAntdFormItem -Name 'username' -Content (
                New-UDAntdInput -PlaceHolder 'Enter your user name' -Prefix ( New-UDAntdIcon -Icon UserOutlined )
            ) -Required
            New-UDAntdFormItem -Name 'email' -Content (
                New-UDAntdInput -PlaceHolder 'Enter your email address' -Prefix ( New-UDAntdIcon -Icon MailOutlined  )
            )
        } -Layout vertical -OnSubmit {
            Set-UDElement -Id "info" -Properties @{visible = $true; description = $EventData }
        }
    }
    New-UDPage -Url "/members/:userId/settings/:profileName" -Endpoint {
        param($userId, $profileName)
        New-UDAntdNotification -Id "userInfo" -Title "Universal Dashboard" -Description "The UserID is: $($userId) and its name is:  $($profileName)" -Preset "info"
        New-UDAntdButton -Label Demo -ButtonType primary -OnClick {
            Set-UDElement -Id "userInfo" -Properties @{visible = $true }
        }
    }
    New-UDPage -Url "/counter" -Endpoint {
        New-UDAntdCard -Content {
            1..250 | Get-Random 
        }
    }  -AutoRefresh -RefreshInterval 5000
    New-UDPage -Name "404" -Content {
        New-UDAntdResult -Title "404" -SubTitle "Sorry, the page you visited does not exist."
    }
)
# $Dashboard = New-UDDashboard -Title "Dashboard" -Theme (get-udtheme basic) -Content {
#     New-UDAntdRoute -Path "/Badge" -Exact -Content @(
#         New-UDAntdBadge -PresetColor lime -Content ( New-UDAntdIcon -Icon BellOutlined -Size 2x )
#         New-UDAntdNotification -Id "userInfo" -Title "Universal Dashboard" -Description "Demo using UDRoute" -Preset "info"
#         New-UDAntdButton -Label Demo -ButtonType primary -OnClick {
#             Set-UDElement -Id "userInfo" -Properties @{visible = $true }
#         }
#     )
# }

$Dashboard.FrameworkAssetId = [UniversalDashboard.Services.AssetService]::Instance.Frameworks[“Antd”]
$Dashboard