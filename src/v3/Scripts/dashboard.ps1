function New-UDDashboard
{
    param(
        [Parameter()]
        [string]$Title = "PowerShell Universal Dashboard",
        [Parameter(ParameterSetName = "Content", Mandatory)]
        [Endpoint]$Content,
        [Parameter(ParameterSetName = "Pages", Mandatory)]
        [Hashtable[]]$Pages = @(),
        [Parameter()]
        [Hashtable]$Theme = @{}
    )    

    if ($PSCmdlet.ParameterSetName -eq 'Content')
    {
        $Pages += New-UDPage -Name 'Home' -Content $Content
    }

    @{
        title = $Title 
        pages = $Pages
        theme = $Theme
    }
}
