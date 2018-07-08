function New-UDImage {
    param(
        [Parameter()]
        [String]$Id = (New-Guid),
        [Parameter()]
        [Alias("Path")]
        [String]$Url,
        [Parameter()]
        [int]$Height,
        [Parameter()]
        [int]$Width,
        [Parameter()]
        [Hashtable]$Attributes = @{}
    )

    $Attributes.src = $Url
    $Attributes.height = $Height
    $Attributes.width = $Width
    
    New-UDElement -Tag 'img' -Attributes $Attributes
}