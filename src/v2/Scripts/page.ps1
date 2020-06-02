function New-UDPage 
{
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
		[Parameter(Position = 0, Mandatory = $true)]
		[string]$Name,
	    [Parameter(Position = 1)]
		[string]$Icon, 
	    [Parameter(Position = 2, ParameterSetName = "content")]
		[ScriptBlock]$Content,
		[Parameter(Position = 5)]
		[string]$Url,
		[Parameter(Position = 3)]
		[Switch]$DefaultHomePage,
		[Parameter(Position = 4)]
        [string]$Title,
        [Parameter(Position = 2, ParameterSetName = "endpoint")]
        [Endpoint]$Endpoint
    )

    if ($Endpoint)
    {
        $Endpoint.Register($Id, $PSCmdlet)    
    }

    if (-not [string]::IsNullOrEmpty($Url) -and -not $Url.StartsWith("/"))
    {
        $Url = "/" + $Url
    }

    if ([string]::IsNullOrEmpty($Url) -and $null -ne $Name)
    {
        $Url = "/" + $Name.Replace(' ', '-');
    }

    [array]$c = @()
    if ($Content) { 
        try 
        {
            [array]$c = . $Content
        }
        catch 
        {
            [array]$c = New-UDError -Message $_ 
        }
    }

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