$TAType = [psobject].Assembly.GetType('System.Management.Automation.TypeAccelerators')
$TAtype::Add('DashboardColor', 'UniversalDashboard.Models.DashboardColor')
$TAtype::Add('Endpoint', 'UniversalDashboard.Models.Endpoint')
$TAtype::Add('FontAwesomeIcons', 'UniversalDashboard.Models.FontAwesomeIcons')

function New-UDRow {
    [CmdletBinding(DefaultParameterSetName = 'static')]
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter(ParameterSetName = "static", Position = 0)]
        [ScriptBlock]$Columns,
        [Parameter(ParameterSetName = "dynamic")]
        [object]$Endpoint,
        [Parameter(ParameterSetName = "dynamic")]
        [Switch]$AutoRefresh,
        [Parameter(ParameterSetName = "dynamic")]
        [int]$RefreshInterval = 5
    )

    End 
    {
        # if ($PSCmdlet.ParameterSetName -eq 'dynamic')
        # {
        #     throw "dynamic parameterset not yet supported"
        # }

        New-UDGrid -Container -Content {
            & $Columns 
        }
    }
}

function New-UDColumn {
    [CmdletBinding(DefaultParameterSetName = 'content')]
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),

        [Parameter()]
        [Alias('Size')]
        [ValidateRange(1,12)]
        [int]$SmallSize = 12,
        [Parameter()]
        [ValidateRange(1,12)]
        [int]$LargeSize = 12,
        [Parameter()]
        [ValidateRange(1,12)]
        [int]$MediumSize = 12,

        [Parameter()]
        [ValidateRange(1,12)]
        [int]$SmallOffset = 1,
        [Parameter()]
        [ValidateRange(1,12)]
        [int]$MediumOffset = 1,
        [Parameter()]
        [ValidateRange(1,12)]
        [int]$LargeOffset = 1,

        [Parameter(ParameterSetName = 'content', Position = 1)]
        [ScriptBlock]$Content,

        [Parameter(ParameterSetName = "endpoint")]
        [object]$Endpoint,
        [Parameter(ParameterSetName = "endpoint")]
        [Switch]$AutoRefresh,
        [Parameter(ParameterSetName = "endpoint")]
        [int]$RefreshInterval = 5
    )
    
    if ($PSCmdlet.ParameterSetName -eq 'content') {
        $GridContent = $Content
        New-UDGrid -Item -SmallSize $SmallSize -MediumSize $MediumSize -LargeSize $LargeSize -Content {
            & $GridContent 
        }
    } else {
        throw "endpoint not yet supported"
    }
}

