$Page = New-UDPage -Url "/script/:id" -Endpoint {
    param($id)

    $PS1File = Invoke-WebRequest -Uri https://raw.githubusercontent.com/PoshCode/poshcode.github.io/data/scripts/$id.ps1

    New-UDCard -Title "Script $Id" -Text $PS1File.Content -Language powershell -Links @(
        New-UDLink -Text "Visit on GitHub" -Url "https://github.com/PoshCode/poshcode.github.io/blob/data/scripts/$Id.ps1"
    )
}

$entry = New-UDPage -Url "/entry/:id" -Endpoint {
    param($id)

    $PS1File = Invoke-WebRequest -Uri https://raw.githubusercontent.com/PoshCode/poshcode.github.io/data/scripts/$id.md

    New-UDCard -Title "Script $Id" -Text $PS1File.Content -Language powershell -Links @(
        New-UDLink -Text "Visit on GitHub" -Url "https://github.com/PoshCode/poshcode.github.io/blob/data/scripts/$Id.md"
        New-UDLink -Text "View Raw Script" -Url "/script/$Id"
    )
}

$HomePage = New-UDPage -Name "Home" -Content {
    New-UDCard -Title "About PoshCode.org Archive" -Text "This dashboard allows you to enter a PoshCode.org document ID and view the contents of it. Enter a value between 1000 and 4198." -Links @(
        New-UDLink -Text "Visit on GitHub" -Url "https://github.com/PoshCode/poshcode.github.io/"
        
    )
    New-UDInput -Title "PoshCode.org Archive" -Endpoint {
        param($Id, [bool]$JustShowScript) 

        if ($Id -lt 1000 -or $Id -gt 4198) {
            New-UDInputAction -Toast "$Id is not a valid PoshCode.org Archive Id!"
        } else {
            if ($JustShowScript) {
                New-UDInputAction -RedirectUrl "/script/$Id"
            }
            else {
                New-UDInputAction -RedirectUrl "/entry/$Id"
            }
        }
    }
}

$Dashboard = New-UDDashboard -Title "PoshCode.org Archive" -Pages @(
    $HomePage,
    $entry
    $Page
)

Start-UDDashboard -Dashboard $Dashboard -Port "10000"
Start-Process http://localhost:10000 
