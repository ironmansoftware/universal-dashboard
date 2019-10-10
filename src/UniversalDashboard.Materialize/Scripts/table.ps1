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

	$Actions = $null
	if ($Links -ne $null) {
		$Actions = New-UDElement -Tag 'div' -Content {
			$Links
		} -Attributes @{
			className = 'card-action'
		}
	}

	New-UDElement -Tag "div" -Id $Id -Attributes @{
		className = 'card ud-table' 
		style = @{
			backgroundColor = $BackgroundColor.HtmlColor
			color = $FontColor.HtmlColor
		}
	} -Content {
		New-UDElement -Tag "div" -Attributes @{
			className = 'card-content'
		} -Content {
			New-UDElement -Tag 'span' -Content { $Title } -Attributes @{ className="card-title"}
			New-UDElement -Tag 'table' -Content {
				New-UDElement -Tag 'thead' -Content {
					New-UDElement -Tag 'tr' -Content {
						foreach($header in $Headers) {
							New-UDElement -Tag 'th' -Content { $header }
						}
					}
				}

				if ($Content -ne $null) {
					New-UDElement -Tag 'tbody' -Content $Content
				}
				else {
					New-UDElement -Tag 'tbody' -Endpoint $Endpoint -AutoRefresh:$AutoRefresh -RefreshInterval $RefreshInterval -ArgumentList $ArgumentList
				}

				
			} -Attributes @{ className = $Style }
		}
		$Actions
	}
}

