Import-Module UniversalDashboard
Add-Type -AssemblyName 'System.Web'
$Dashboard = New-UDDashboard -Title "Create new user" -Content {
    New-UDInput -Title "Create new user" -Endpoint {
        param(
            [Parameter(Mandatory)]
            [string]$FirstName,
            [Parameter(Mandatory)]
            [string]$LastName,
            [Parameter(Mandatory)]
            [string]$UserName,
            [Parameter(Mandatory)]
            [ValidateSet("IT", "HR", "Accounting", "Development")]
            [string]$Group
        )

        $password = [System.Web.Security.Membership]::GeneratePassword((Get-Random -Minimum 20 -Maximum 32), 3)
        $securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force

        $NewAdUserParameters = @{
            GivenName = $FirstName
            Surname = $LastName 
            Name = $UserName 
            AccountPassword = $securePassword
        }

        New-AdUser @NewAdUserParameters
        Add-AdGroupMember -Identity $Group -Members $userName

        New-UDInputAction -Content {
            New-UDCard -Title "Temporary Password" -Text $Password
        }
    } -Validate
}

Start-UDDashboard -Dashboard $Dashboard -Port 10000