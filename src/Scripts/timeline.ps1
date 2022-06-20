function New-UDTimeline {
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter()]
        [Alias("Content")]
        [scriptblock]$Children,
        [Parameter()]
        [ValidateSet("right", 'left', 'alternate')]
        [string]$Position = "right"
    )

    @{
        isPlugin = $true
        assetId  = $MUAssetId
        type     = "mu-timeline"
        id       = $id

        children = & $Children
        position = $Position.ToLower()
    }
}

function New-UDTimelineItem {
    param(
        [Parameter()]
        [ScriptBlock]$Content = {},
        [Parameter()]
        [ScriptBlock]$OppositeContent = {},
        [Parameter()]
        [Hashtable]$Icon,
        [Parameter()]
        [ValidateSet("error", 'grey', 'info', 'inherit', 'primary', 'secondary', 'success', 'warning')]
        [string]$Color = 'grey',
        [Parameter()]
        [ValidateSet('filled', 'outlined')]
        [string]$Variant = 'filled'
    )

    @{
        content         = & $Content
        oppositeContent = & $OppositeContent
        icon            = $icon 
        color           = $Color.ToLower()
        variant         = $Variant.ToLower()
    }
}

<#

New-UDTimeline -Children {
            New-UDTimelineItem -Content {
                'Breakfast'
            } -OppositeContent {
                '7:45 AM'
            } 
            New-UDTimelineItem -Content {
                'Welcome Message'
            } -OppositeContent {
                '9:00 AM'
            }
            New-UDTimelineItem -Content {
                'State of the Shell'
            } -OppositeContent {
                '9:30 AM'
            }
            New-UDTimelineItem -Content {
                'General Session'
            } -OppositeContent {
                '11:00 AM'
            }
        }

#>