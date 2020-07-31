function New-UDUpload {
    <#
    .SYNOPSIS
    Upload files
    
    .DESCRIPTION
    Upload files. This component works with UDForm and UDStepper.
    
    .PARAMETER Id
    The ID of the uploader.
    
    .PARAMETER Accept
    The type of files to accept. By default, this component accepts all files. 
    
    .PARAMETER OnUpload
    A script block to execute when a file is uploaded. This $body parameter will contain JSON in the following format: 

    {
        data: 'base64 encoded string of file data',
        name: 'filename',
        type: 'type of file, if known'
    }
    
    .PARAMETER Text
    The text to display on the upload button.
    
    .PARAMETER Variant
    The variant of button
    
    .PARAMETER Color
    The color of the button. 

    .EXAMPLE
    A file uploader 

    New-UDDashboard -Title "Hello, World!" -Content {
        New-UDUpload -Text "Upload" -OnUpload {
            Show-UDToast $Body
        }
    }
    
    .EXAMPLE
    A file uploader in a form 

    New-UDDashboard -Title "Hello, World!" -Content {
        New-UDForm -Content {
            New-UDUpload -Text "Upload" 
        } -OnSubmit {
            Show-UDToast $Body
        }
    }
    #>
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter()]
        [string]$Accept = "*",
        [Parameter()]
        [Endpoint]$OnUpload,
        [Parameter()]
        [string]$Text,
        [Parameter()]
        [ValidateSet("text", "outlined", "contained")]
        [string]$Variant = 'contained',
        [Parameter()]
        [string]$Color = "primary"
    )

    if ($OnUpload)
    {
        $OnUpload.Register($Id, $PSCmdlet)
    }

    @{
        type = "mu-upload"
        isPlugin = $true
        assetId = $MUAssetId
        id = $id

        accept = $Accept 
        onUpload = $OnUpload
        text = $Text
        variant = $Variant
        color = $Color
    }
}