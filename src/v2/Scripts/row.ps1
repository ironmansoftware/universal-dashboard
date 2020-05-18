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

    if ($PSCmdlet.ParameterSetName -eq 'static') {
        New-UDElement -Tag 'div' -Attributes @{
            className = 'row'
        } -Content $Columns
    }
    else {
        New-UDElement -Tag 'div' -Attributes @{
            className = 'row'
        } -Endpoint $Endpoint -AutoRefresh:$AutoRefresh -RefreshInterval $RefreshInterval 
    }
}