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

    $EventData will contain a class with the following properties:

    public string Name { get; set; }
    public string FileName { get; set; }
    public DateTime TimeStamp { get; set; }
    public string ContentType { get; set; }
    public string Type => ContentType;
    
    .PARAMETER Text
    The text to display on the upload button.
    
    .PARAMETER Variant
    The variant of button. Defaults to contained. Valid values: "text", "outlined", "contained"
    
    .PARAMETER Color
    The color of the button. Defaults to 'default'. Valid values: "default", "primary", "secondary", "inherit"

    .PARAMETER ClassName
    A CSS class to apply to the button.

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
        [string]$Variant = "contained",
        [Parameter()]
        [ValidateSet('default', 'inherit', 'primary', 'secondary', 'success', 'error', 'info', 'warning')]
        [string]$Color = "inherit",
        [Parameter()]
        [string]$ClassName
    )

    if ($OnUpload) {
        $OnUpload.Register($Id, $PSCmdlet)
    }

    if ($Color -eq 'default') {
        $Color = 'inherit'
    }

    @{
        type      = "mu-upload"
        isPlugin  = $true
        assetId   = $MUAssetId
        id        = $id

        accept    = $Accept 
        onUpload  = $OnUpload
        text      = $Text
        variant   = $Variant.ToLower()
        color     = $Color.ToLower()
        className = $ClassName
    }
}