function New-UDPage 
{
    param(
        [Parameter(Position = 0, Mandatory)]
        [string]$Name,
        [Parameter(Position = 2, Mandatory)]
        [Alias("Endpoint")]
        [Endpoint]$Content,
        [Parameter(Position = 0)]
        [string]$Url,
        [Parameter(Position = 3)]
        [Switch]$DefaultHomePage,
        [Parameter(Position = 4)]
        [string]$Title,
        [Parameter()]
        [Switch]$Blank,
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter()]
        [ScriptBlock]$OnLoading
    )

    $Content.Register($Id, $PSCmdlet)

    if (-not [string]::IsNullOrEmpty($Url) -and -not $Url.StartsWith("/"))
    {
        $Url = "/" + $Url
    }

    if ([string]::IsNullOrEmpty($Url) -and $null -ne $Name)
    {
        $Url = "/" + $Name.Replace(' ', '-');
    }

    if ($OnLoading)
    {
        $LoadingContent = & $OnLoading
    }
    

    @{
        name = $Name
        url = $Url
        id = $Id
        defaultHomePage = $DefaultHomePage.IsPresent
        title = $Title
        blank = $Blank.IsPresent
        loading = $LoadingContent
        content = $Content 
    }
}