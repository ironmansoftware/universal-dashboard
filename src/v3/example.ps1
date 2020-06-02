New-UDDashboard -Title "Hello, World!" -Content {
    New-UDTypography -Text "Hello, World!"

    New-UDButton -Text "Learn more about Universal Dashboard" -OnClick {
        Invoke-UDRedirect https://docs.ironmansoftware.com
    }
}