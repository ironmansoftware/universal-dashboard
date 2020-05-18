function New-UDSpan {
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        $Content
    )

    New-UDElement -Id $Id -Tag "span" -Content {
        $Content
    }
}