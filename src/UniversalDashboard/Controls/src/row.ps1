function New-UDRow {
    [CmdletBinding(DefaultParameterSetName = 'static')]
    param(
        [Parameter()]
        [String]$Id = (New-Guid),
        [Parameter(ParameterSetName = "static", Position = 0)]
        [ScriptBlock]$Columns,
        [Parameter(ParameterSetName = "dynamic")]
        [ScriptBlock]$Endpoint,
        [Parameter(ParameterSetName = "dynamic")]
        [Switch]$AutoRefresh,
        [Parameter(ParameterSetName = "dynamic")]
        [int]$RefreshInterval = 5,
        [Parameter(ParameterSetName = "dynamic")]
        [Switch]$DebugEndpoint
    )

    if ($PSCmdlet.ParameterSetName -eq 'static') {
        New-UDElement -Tag 'div' -Attributes @{
            className = 'row'
        } -Content $Columns
    }
    else {
        New-UDElement -Tag 'div' -Attributes @{
            className = 'row'
        } -Endpoint $Endpoint -AutoRefresh:$AutoRefresh -RefreshInterval $RefreshInterval -DebugEndpoint:$DebugEndpoint
    }
}