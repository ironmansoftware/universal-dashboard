function New-UDHidden {
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter(ParameterSetName = 'Down')]
        [ValidateSet('xs', 'sm', 'md', 'lg', 'xl')]
        [string]$Down,
        [Parameter(ParameterSetName = 'Up')]
        [ValidateSet('xs', 'sm', 'md', 'lg', 'xl')]
        [string]$Up,
        [Parameter(ParameterSetName = 'Only')]
        [ValidateSet('xs', 'sm', 'md', 'lg', 'xl')]
        [string[]]$Only,
        [Parameter()]
        [ScriptBlock]$Content
    )

    $Component = @{
        type = 'mu-hidden'
        id = $Id
        isPlugin = $true 

        children = & $Content
    }

    if ($PSCmdlet.ParameterSetName -eq 'Only')
    {
        $Component['only'] = $Only 
    }

    if ($PSCmdlet.ParameterSetName -eq 'Down')
    {
        $Component["$($Down.ToLower())Down"] = $true 
    }

    if ($PSCmdlet.ParameterSetName -eq 'Up')
    {
        $Component["$($Up.ToLower())Up"] = $true 
    }

    $Component 
} 