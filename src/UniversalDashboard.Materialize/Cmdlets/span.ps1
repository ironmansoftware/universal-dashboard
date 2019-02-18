function New-UDSpan {
    param(
        [Parameter()]
        [String]$Id = (New-Guid),
        [Parameter()]
        $Content
    )

    New-UDElement -Id $Id -Tag "span" -Content {
        $Content
    }
}