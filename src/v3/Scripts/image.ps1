function New-UDImage {
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
        [Hashtable]$Attributes = @{}
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
    if ($PSBoundParameters.ContainsKey('Height')) {
        $Attributes.'height' = $Height
    }
    if ($PSBoundParameters.ContainsKey('Width')) {
        $Attributes.'width' = $Width
    }

    $Attributes["id"] = $Id

    New-UDElement -Tag 'img' -Attributes $Attributes
}
