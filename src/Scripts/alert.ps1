function New-UDAlert {
    <#
    .SYNOPSIS
    Creates an alert.
    
    .DESCRIPTION
    Creates an alert.
    
    .PARAMETER Id
    The ID of this component.
    
    .PARAMETER Severity
    The severity of this alert. 
    
    .PARAMETER Children
    Content of the alert.

    .PARAMETER Text
    Text for the body of the alert.
    
    .PARAMETER Title
    A title for this alert.
    #>
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter()]
        [ValidateSet("success", "error", "warning", "info")]
        [string]$Severity = "success",
        [Parameter(ParameterSetName = "Content")]
        [Alias("Content")]
        [scriptblock]$Children,
        [Parameter(ParameterSetName = "Text")]
        [string]$Text,
        [Parameter()]
        [string]$Title,
        [Parameter()]
        [string]$ClassName
    )

    if ($PSCmdlet.ParameterSetName -eq 'Text') {
        $Children = { $Text }
    }

    @{
        type      = "mu-alert"
        id        = $id 
        isPlugin  = $true 
        assetId   = $MUAssetId 

        severity  = $Severity.ToLower()
        children  = & $Children
        title     = $Title
        className = $ClassName
    }
}