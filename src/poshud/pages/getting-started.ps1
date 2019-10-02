New-UDPage -Name "Getting Started" -Content {
    New-UDElement -Tag div -Attributes @{ style = @{ paddingLeft = "20px" }} -Content {
        New-UDRow -Columns {
            New-UDColumn -Size 12 -Content {
                New-UDHeading -Size 3 -Text "Getting Started"
                New-UDParagraph -Text "Universal Dashboard is a PowerShell module that you can install from the PowerShell Gallery."
                New-UDHeading -Size 4 -Text "1. Install the Module"
                New-UDParagraph -Text "The first step is to install the Universal Dashboard module. You can either install the Community Edition or the Enterprise edition."
                New-UDHeading -Size 5 -Text "Enterprise Edition"
                New-UDElement -Tag 'pre' -Content {
                    "Install-Module UniversalDashboard -Scope CurrentUser -AcceptLicense -Force"
                } -Attributes @{ style = @{ backgroundColor = "#f8f8f8"; padding = '30px'}}
                New-UDHeading -Size 5 -Text "Community Edition"
                New-UDElement -Tag 'pre' -Content {
                    "Install-Module UniversalDashboard.Community -Scope CurrentUser -AcceptLicense -Force"
                } -Attributes @{ style = @{ backgroundColor = "#f8f8f8";  padding = '30px'}}
                New-UDHeading -Size 4 -Text "2. Create your first dashboard"
                New-UDParagraph -Text "You can use the New-UDDashboard command to create your first dashboard."
                New-UDElement -Tag 'pre' -Content {
                    '$Dashboard = New-UDDashboard -Title "Hello, World!" -Content { New-UDHeading -Text "Hello, World!" -Size 1 } '
                } -Attributes @{ style = @{ backgroundColor = "#f8f8f8";  padding = '30px'}}
                New-UDHeading -Size 4 -Text "3. Start your dashboard"
                New-UDParagraph -Text "You can use the Start-UDDashboard command to start the web server in PowerShell."
                New-UDElement -Tag 'pre' -Content {
                    'Start-UDDashboard -Dashboard $Dashboard -Port 10001'
                } -Attributes @{ style = @{ backgroundColor = "#f8f8f8";  padding = '30px'}}
            }
        }
    }
}
