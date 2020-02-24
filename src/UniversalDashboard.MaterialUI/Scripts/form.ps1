function New-UDForm 
{
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid().ToString(),
        [Parameter(Mandatory)]
        [ScriptBlock]$Content,
        [Parameter(Mandatory)]
        [Endpoint]$OnSubmit,
        [Parameter()]
        [Endpoint]$OnValidate
    )

    $OnSubmit.Register($id, $PSCmdlet)

    @{
        id = $Id 
        assetId = $MUAssetId 
        isPlugin = $true 
        type = "mu-form"

        onSubmit = $onSubmit 
        onValidate = $onValidate
        content = & $Content
    }
}