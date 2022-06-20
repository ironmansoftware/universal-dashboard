function New-UDImage {
    <#
    .SYNOPSIS
    An image component.
    
    .DESCRIPTION
    An image component.
    
    .PARAMETER Id
    The ID of this component.
    
    .PARAMETER Url
    The URL to the image. 
    
    .PARAMETER Path
    The path to a local image.
    
    .PARAMETER Height
    The height in pixels.
    
    .PARAMETER Width
    The width in pixels.
    
    .PARAMETER Attributes
    Additional attributes to apply to the img tag.
    
    .EXAMPLE
    Displays an image. 

    New-UDImage -Url 'https://ironmansoftware.com/logo.png'
    #>
    [CmdletBinding(DefaultParameterSetName = 'url')]
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter(ParameterSetName = 'url')]
        [String]$Url,
        [Parameter(ParameterSetName = 'path')]
        [String]$Path,
        [Parameter()]
        [int]$Height,
        [Parameter()]
        [int]$Width,
        [Parameter()]
        [Hashtable]$Attributes = @{},
        [Parameter()]
        [string]$ClassName
    )

    switch ($PSCmdlet.ParameterSetName) {
        'path' {
            if (-not [String]::IsNullOrEmpty($Path)) {
                if (-not (Test-Path $Path)) {
                    throw "$Path does not exist."
                }
        
                $mimeType = 'data:image/png;base64, '
                if ($Path.EndsWith('jpg') -or $Path.EndsWith('jpeg')) {
                    $mimeType = 'data:image/jpg;base64, '
                }
        
                $base64String = [Convert]::ToBase64String([System.IO.File]::ReadAllBytes($Path))
        
                $Attributes.'src' = "$mimeType $base64String"
            }
        }
        'url' {
            $Attributes.'src' = $Url
        }
    }
    if ($PSBoundParameters.ContainsKey('ClassName')) {
        $Attributes.'className' = $ClassName
    }
    if ($PSBoundParameters.ContainsKey('Height')) {
        $Attributes.'height' = $Height
    }
    if ($PSBoundParameters.ContainsKey('Width')) {
        $Attributes.'width' = $Width
    }

    $Attributes["id"] = $Id

    New-UDElement -Tag 'img' -Attributes $Attributes
}
