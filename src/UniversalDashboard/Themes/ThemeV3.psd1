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
            width       = 250
            height      = 220
            padding     = @(48,48,48,48)
            colors      = @(
                '#f44336'
                '#e91e63'
                '#9c27b0'
                '#3f51b5'
                '#2196f3'
                '#00bcd4'
                '#4caf50'
            )
            defaultColor       = '#e91e63'
            title       = @{
                fontSize      = 32
                fill          = '#4caf50'
                alignWithAxis =  $false
                fontFamily    = 'fantasy'
            }
            description = @{
                fontSize      = 16
                fill          = '#3f51b5'
                alignWithAxis = $false
                fontFamily    = 'fantasy'
            }
            legend      = @{ }
            tooltip     = @{ }
        }
    }
}
