$Navigation = @(
    New-UDListItem -Label 'Home' -Icon (New-UDIcon -Icon Home) -OnClick {
        Invoke-UDRedirect -Url '/home'
    }
    New-UDListItem -Label 'Users' -Icon (New-UDIcon -Icon User) -OnClick {
        Invoke-UDRedirect -Url '/users'
    }
    New-UDListItem -Label 'Groups' -Icon (New-UDIcon -Icon Users) -OnClick {
        Invoke-UDRedirect -Url '/groups'
    }
)

$HomePage = New-UDPage -Name 'Home' -Content {
    New-UDTypography -Text 'Home'
}

$Users = New-UDPage -Name 'Users' -Content {
    New-UDTypography -Text 'Users'
}

$Groups = New-UDPage -Name 'Groups' -Content {
    New-UDTypography -Text 'Groups'
}

New-UDDashboard -Title 'PowerShell Universal' -Pages @(
    $HomePage
    $Users 
    $Groups
) -Navigation $Navigation