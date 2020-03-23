@{  
    name       = "basic"
    definition = @{
        colors  = @{
            primary    = "#df5656"
            secondary  = "#fdc533"
            background = "#c1c1c1"
            text       = "#333"
            muted      = "#d6d6d6"
        }
        modes   = @{
            dark = @{
                primary    = "#eaa22222"
                secondary  = "#fdc533"
                background = "#333"
                text       = "#fff"
                muted      = "#ccc"
            }
        }
        avatars = @{
            small  = @{
                width        = '24px'
                height       = '24px'
                margin       = '16px'
                borderRadius = '50%'
            }
            medium = @{
                width        = '48px'
                height       = '48px'
                margin       = '16px'
                borderRadius = '50%'
            }
            large  = @{
                width        = '96px'
                height       = '96px'
                margin       = '16px'
                borderRadius = '50%'
            }
        }
        chart   = @{
            width   = 250
            height  = 400
            padding = @(48, 48, 48, 48)
            light   = @{
                colors       = @(
                    "#1890ff",
                    "#1f1f1f",
                    "#bfbfbf",
                    "#f0f0f0",
                    "#d9d9d9",
                    "#8c8c8c",
                    "#595959",
                    "#434343"
                )
                background   = @{
                    fill = "#ffffff"
                }
                defaultColor = "#1890ff"
                title        = @{
                    fontSize      = 32
                    fill          = "#1f1f1f"
                    alignWithAxis = $false
                    fontFamily    = 'fantasy'
                }
                description  = @{
                    fontSize      = 16
                    fill          = "#1f1f1f"
                    alignWithAxis = $false
                    fontFamily    = 'fantasy'
                }
                legend       = @{ }
                tooltip      = @{ }
            }
            dark   = @{
                colors       = @(
                    "#1890ff",
                    "#F7FBFF",
                    "#69c0ff",
                    "#0050b3",
                    "#096dd9",
                    "#40a9ff",
                    "#69c0ff",
                    "#91d5ff"
                )
                background = @{
                    fill = "#333333"
                }
                defaultColor = "#1890ff"
                title        = @{
                    fontSize      = 32
                    fill          = "#797979"
                    alignWithAxis = $false
                    fontFamily    = 'fantasy'
                }
                description  = @{
                    fontSize      = 16
                    fill          = "#797979"
                    alignWithAxis = $false
                    fontFamily    = 'fantasy'
                }
                legend       = @{ }
                tooltip      = @{ }
            }
        }
    }
}
