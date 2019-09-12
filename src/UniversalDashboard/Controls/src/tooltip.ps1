function New-UDTooltip {
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter()]
        [ValidateSet("top", "bottom", "left", "right")]
        [string]$Place = "top",
        [Parameter()]
        [ValidateSet("dark", "success", "warnign", "error", "info", "light")]
        [string]$Type = "dark",
        [Parameter()]
        [ValidateSet("float", "solid")]
        [string]$Effect,
        [Parameter(Mandatory)]
        [ScriptBlock]$TooltipContent,
        [Parameter(Mandatory)]
        [ScriptBlock]$Content
    )

    @{
        type = "ud-tooltip"
        tooltipType = $Type
        effect = $Effect 
        place = $Place
        id = $Id
        tooltipContent = & $TooltipContent
        content = & $Content
    }
}