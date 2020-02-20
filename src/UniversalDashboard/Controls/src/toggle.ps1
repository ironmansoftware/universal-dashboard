function New-UDToggleColorMode {
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString()
    )
    @{
        id      = $Id
        type    = "ud-toggle-color-mode"
    }
}