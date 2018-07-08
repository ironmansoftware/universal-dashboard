function New-UDIFrame {
    param(
        [Parameter()]
        [String]$Id = (New-Guid),
        [Parameter()]
        $Uri
    )

    New-UDElement -Id $Id -Tag "iframe" -Attributes @{
        src = $Uri
    }
}