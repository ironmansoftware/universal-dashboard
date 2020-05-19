function New-UDPage 
{
    param(
		[Parameter(Position = 0, Mandatory = $true, ParameterSetName = "name")]
		[string]$Name,
	    [Parameter(Position = 1)]
		[string]$Icon, 
	    [Parameter(Position = 2)]
		[ScriptBlock]$Content,
		[Parameter(Position = 0, Mandatory = $true, ParameterSetName = "url")]
		[string]$Url,
		[Parameter(Position = 3)]
		[Switch]$DefaultHomePage,
		[Parameter(Position = 4)]
        [string]$Title,
        [Parameter(Position = 2, ParameterSetName = "endpoint")]
        [Endpoint]$Endpoint
    )

    if ($PSCmdlet.ParameterSetName -eq 'endpoint')
    {
        $Endpoint.Register($Name, $PSCmdlet)    
    }

    if ($null -ne $Url -and -not $Url.StartsWith("/"))
    {
        $Url = "/" + $Url
    }

    if ($Null -eq $Url -and $null -ne $Name)
    {
        $Url = "/" + $Name.Replace(' ', '-');
    }

    [array]$c = @()
    if ($Content) { [array]$c = . $Content}

    @{
        name = $Name
        url = $Url
        id = $Id
        icon = $Icon
        defaultHomePage = $DefaultHomePage.IsPresent
        title = $Title
        content = $c
        dynamic = $Endpoint -ne $null
    }
}