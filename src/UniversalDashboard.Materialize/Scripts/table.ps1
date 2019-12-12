function New-UDTable {
	param(
		[Parameter()]
	    [string]$Id = ([Guid]::NewGuid()),
		[Parameter()]
	    [string]$Title,
	    [Parameter(Mandatory = $true)]
	    [string[]]$Headers,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor]$BackgroundColor,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor]$FontColor,
		[Parameter()]
		[ValidateSet("bordered", "striped", "highlight", "centered", "responsive-table")]
		[string]$Style,
	    [Parameter()]
		[Hashtable[]] $Links,
		[Parameter(Mandatory = $true, ParameterSetName = 'endpoint')]
		[object]$Endpoint,
		[Parameter(ParameterSetName = 'endpoint')]
		[Switch]$AutoRefresh,
		[Parameter(ParameterSetName = 'endpoint')]
		[int]$RefreshInterval = 5,
		[Parameter()]
		[object[]]$ArgumentList,
		[Parameter(ParameterSetName = 'content')]
		[ScriptBlock]$Content
	)

	Begin {
        if ($null -ne $Links) {
            $hasActions = $true
        }

        if ($null -ne $Endpoint) {
            if ($Endpoint -is [scriptblock]) {
                $Endpoint = New-UDEndpoint -Endpoint $Endpoint -Id $Id
            }
            elseif ($Endpoint -isnot [UniversalDashboard.Models.Endpoint]) {
                throw "Endpoint must be a script block or UDEndpoint"
            }
        }
    }

    Process {
        
    }

    End {
        @{
            type = 'ud-table'
            isPlugin = $true
            assetId = $assetId

            id = $Id
            hasAction = $hasActions
            links = $Links
            title = $Title
            backgroundColor = $BackgroundColor.HtmlColor
            fontColor = $FontColor.HtmlColor

            header = $Headers
            content = $Content
            endpoint = $Endpoint.Name
            autoRefresh = $AutoRefresh.IsPresent
            refreshInterval = $RefreshInterval
            argumentList = $ArgumentList
        }
    }
}

