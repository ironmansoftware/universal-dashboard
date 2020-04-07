New-UDPage -Name 'Login Pages' -Content {
    New-AppBar -Title "Login Pages"

    

    New-UDContainer -Content {

        New-UDTypography -Variant h3 -Text "Login Pages"

        New-UDButton -Text 'Premium or Enterprise License Required' -Icon (New-UDIcon -Icon Rocket) -Variant 'contained' -OnClick {
            Invoke-UDRedirect -Url "https://www.ironmansoftware.com/powershell-universal-dashboard" -OpenInNewWindow
        }

        New-UDElement -Tag p

        New-UDTypography -Text "Login pages allow you to create dashboards that require authentication to access. You can define your own authentication endpoint to perform the authentication yourself or use a third party OAuth provider to do so. To create your login page, you can use the New-UDLoginPage and LoginPage parameter of New-UDDashboard."

        New-UDPaper -Content {
            New-UDElement -Tag 'pre' -Content { "`$Dashboard = New-UDDashboard -LoginPage `$LoginPage -Page @(
                `$MyDashboardPage
            )" }
        }

        New-UDTypography -Variant h4 -Text "Authentication Methods"

        New-UDTypography -Text "You can use one or more authentication methods for a login page. UD currently supports the following authentication methods." 

        New-UDList -Content {
            New-UDListItem -Label "Forms"
            New-UDListItem -Label "AzureAD"
            New-UDListItem -Label "OpenID Connect v2"
            New-UDListItem -Label "WS-Federation"
            New-UDListItem -Label "Windows"
            New-UDListItem -Label "OAuth"
        }

        New-UDTypography -Text "To specify an authentication method for a login page, use the New-UDAuthenticationMethod cmdlet." 

        New-UDPaper -Content {
            New-UDElement -Tag 'pre' -Content { "`$AuthenticationMethod = New-UDAuthenticationMethod -Endpoint {
                param([PSCredential]`$Credentials)
            
                if (`$Credentials.UserName -eq `"Adam`" -and `$Credentials.GetNetworkCredential().Password -eq `"SuperSecretPassword`") {
                    New-UDAuthenticationResult -Success -UserName `"Adam`"
                }
            
                New-UDAuthenticationResult -ErrorMessage `"You aren't Adam!!!`"
            }
            
            `$LoginPage = New-UDLoginPage -AuthenticationMethod `$AuthenticationMethod" }
        }

        New-UDTypography -Text "To specify multiple authentication methods, just pass an array of authentication methods to the New-UDLoginPage cmdlet." 

        New-UDPaper -Content {
            New-UDElement -Tag 'pre' -Content { "`$AuthenticationMethod = @()
            `$AuthenticationMethod += New-UDAuthenticationMethod -AppId 1234 -AppSecret Abc123 -Provider Facebook
            `$AuthenticationMethod += New-UDAuthenticationMethod -AppId 1234 -AppSecret Abc123 -Provider Twitter
            `$AuthenticationMethod += New-UDAuthenticationMethod -AppId 1234 -AppSecret Abc123 -Provider Google
            `$AuthenticationMethod += New-UDAuthenticationMethod -AppId 1234 -AppSecret Abc123 -Provider Microsoft
            `$AuthenticationMethod += New-UDAuthenticationMethod -Endpoint {
            
            }
            
            `$LoginPage = New-UDLoginPage -AuthenticationMethod `$AuthenticationMethod" }
        }
    }
}