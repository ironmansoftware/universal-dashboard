function New-UDFab {
    param(
        [Parameter()]
        [string] $Id = (New-Guid),
        [Parameter(Mandatory = $true, Position = 0)]
        [ScriptBlock]$Content,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$ButtonColor,
        [Parameter()]
        [UniversalDashboard.Models.FontAwesomeIcons]$Icon,
        [Parameter()]
        [ValidateSet("Small", "Large")]
        $Size = "Large",
        [Parameter()]
        [Switch]$Horizontal,
        [Parameter()]
        [object]$onClick
    )
    
    if ($Horizontal) {
        $direction = "horizontal"
    }

    New-UDElement -Id $Id -Tag "div" -Attributes @{className = "fixed-action-btn $direction"} -Content {
        New-UDElement -Tag "a" -Attributes @{className = "btn-floating btn-$Size"; onClick = $onClick; style = @{ backgroundColor = $ButtonColor.HtmlColor}} -Content {
            New-UDElement -Tag "i" -Attributes @{className = "fa $Size fa-$icon"}  
        }
        New-UDElement -Tag "ul" -Content $Content
        
    }
}

function New-UDFabButton {
    param(
        [Parameter()]
        [string] $Id = (New-Guid),
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$ButtonColor,
        [Parameter()]
        [UniversalDashboard.Models.FontAwesomeIcons]$Icon,
        [Parameter()]
        [ValidateSet("Small", "Large")]
        $Size = "Large",
        [Parameter()]
        [object]$onClick
    )

    New-UDElement -Id $Id -Tag "li" -Content {
        New-UDElement -Tag "a" -Attributes @{className = "btn-floating btn-$Size"; onClick = $onClick; style = @{ backgroundColor = $ButtonColor.HtmlColor}} -Content {
            New-UDElement -Tag "i" -Attributes @{className = "fa $Size fa-$icon"} 
        }
    }
}