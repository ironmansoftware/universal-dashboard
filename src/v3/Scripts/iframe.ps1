function New-UDIFrame {
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        $Uri
    )

    New-UDElement -Id $Id -Tag "iframe" -Attributes @{
        src = $Uri
    }
}