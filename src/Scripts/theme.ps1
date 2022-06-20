
class ThemeColors {
    [string]$primary
    [string]$secondary
    [string]$background
    [string]$text
    [string]$muted

    ThemeColors() { 
    }

    ThemeColors([string]$primary, [string]$secondary) {
        $this.primary = $primary
        $this.secondary = $secondary
    }

    ThemeColors([string]$primary, [string]$secondary, [string]$background, [string]$text, [string]$muted) {
        $this.Primary = $Primary
        $this.Secondary = $Secondary
        $this.Background = $Background
        $this.Text = $Text
        $this.Muted = $Muted
    }

}

class ThemeColorModes {
    [ThemeColors]$Dark

    ThemeColorModes() {
    }

    ThemeColorModes([ThemeColors]$Dark) {
        $this.Dark = $Dark
    }
}

function New-UDTheme {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$name,
        [Parameter()]
        [ThemeColors]$Colors,
        [Parameter()]
        [ThemeColorModes]$ColorModes,
        [Parameter()]
        [hashtable]$Variants
    )
    end {
        $theme = [ordered]@{
            name     = $Name
            colors   = if ($Colors) {
                $Colors 
            }
            else {
                [ThemeColors]::new() 
            }
            modes    = if ($ColorModes) {
                $ColorModes 
            }
            else {
                [ThemeColorModes]::new([ThemeColors]::new()) 
            }
            variants = $Variants
        }
        $Result = $theme | ConvertTo-Json -Depth 10 
        $Result
    }
}

$AntDesign = @{
    palette    = @{
        primary    = @{
            light = '#69696a'
            main  = '#1890ff'
            dark  = '#1e1e1f'
        }
        secondary  = @{
            light = '#1890ff'
            main  = '#1890ff'
            dark  = '#e62958'
        }
        warning    = @{
            main = '#ffc071'
            dark = '#ffb25e'
        }
        error      = @{
            xLight = '#ffebee'
            main   = '#f44336'
            dark   = '#d32f2f'
        }
        success    = @{
            xLight = '#e8f5e9'
            main   = '#4caf50'
            dark   = '#388e3c'
        }
        background = @{
            default = "#f0f2f5"
        }
    }
    typography = @{
        body1 = @{
            fontSize = 14
        }
        h6    = @{
            fontSize   = 14
            fontWeight = 400
        }
    }
    overrides  = @{
        MuiAppBar         = @{
            colorPrimary = @{
                color           = '#000'
                backgroundColor = '#fff'
            }
        }
        MuiButton         = @{
            contained = @{
                color           = "#fff"
                lineHeight      = 1.5715
                fontWeight      = 400
                backgroundColor = "#1890ff"
                borderColor     = "#1890ff"
                borderRadius    = 0
                boxShadow       = $null
                transition      = "all .3s cubic-bezier(.645,.045,.355,1)"
                textTransform   = 'none'
                '&:hover'       = @{
                    backgroundColor = '#40a9ff'
                    borderColor     = '#40a9ff'
                    color           = '#fff'
                    boxShadow       = $null
                }
            }
        }
        MuiDrawer         = @{
            paperAnchorDockedLeft = @{
                borderRight = $null
            }
        }
        MuiExpansionPanel = @{
            rounded = @{
                "&:first-child" = @{
                    borderTopLeftRadius  = 0
                    borderTopRightRadius = 0
                }
                "&:last-child"  = @{
                    borderBottomLeftRadius  = 0
                    borderBottomRightRadius = 0
                }
                
                
            }
        }
        MuiIconButton     = @{
            root = @{
                borderRadius = 0
                fontSize     = 14
                padding      = "4px 12px"
            }
        }
        MuiInput          = @{
            root      = @{
                lineHeight = 1.5715
            }
            underline = @{
                "&:before" = @{
                    borderBottom = $null
                }
                "&:after"  = @{
                    borderBottom = $null
                }
                "&:hover"  = @{
                    "&:before" = @{
                        borderBottom = "0 !important"
                    }
                }
            }
        }
        MuiInputBase      = @{
            input = @{
                border       = '1px solid #d9d9d9'
                borderRadius = '2px'
                padding      = '4px 11px'
                color        = "rgba(0,0,0,.85)"
                lineHeight   = 1.5715
                fontSize     = 14
                "&:hover"    = @{
                    borderColor = "#40a9ff"
                }
                "&:focus"    = @{
                    borderColor = '#40a9ff'
                    boxShadow   = "0 0 0 2px rgb(24 144 255 / 20%)"
                }
            }
        }

        MuiListItem       = @{
            root   = @{
                transition = "opacity .3s cubic-bezier(.645,.045,.355,1),width .3s cubic-bezier(.645,.045,.355,1),color .3s"
                cursor     = 'pointer'
                "&:hover"  = @{
                    color = '#1890ff !important'
                }
            }
            button = @{
                "&:hover" = @{
                    color           = '#1890ff'
                    backgroundColor = "#fff"
                }
            }
            
        }
        MuiListItemIcon   = @{
            root = @{
                minWidth  = '25px'
                "&:hover" = @{
                    color = '#1890ff'
                }
            }
        }
        MuiListItemText   = @{
            multiline = @{
                marginTop    = 0
                marginBottom = 0
               
            }

        }
        MuiPaper          = @{
            rounded    = @{
                borderRadius = 0
            }
            elevation1 = @{
                boxShadow = $null
            }
            elevation4 = @{
                boxShadow = $null
            }
        }
        MuiSvgIcon        = @{
            colorPrimary = @{
                color = "#000"
            }
        }
        MuiTab            = @{
            root      = @{
                minHeight     = 0
                textTransform = 'none'
            }
            labelIcon = @{
                minHeight = 0
            }
        }
        
    }
}

$Paperbase = @{
    palette    = @{
        primary = @{
            light = '#63ccff'
            main  = '#009be5'
            dark  = '#006db3'
        }
    }
    typography = @{
        h5 = @{
            fontWeight    = 500
            fontSize      = 26
            letterSpacing = 0.5
        }
    }
    shape      = @{
        borderRadius = 8
    }
    mixins     = @{
        toolbar = @{
            minHeight = 48
        }
    }
    overrides  = @{
        MuiDrawer         = @{
            paper = @{
                backgroundColor = '#081627'
            }
        }
        MuiButton         = @{
            label     = @{
                textTransform = 'none'
            }
            contained = @{
                boxShadow  = 'none'
                '&:active' = @{
                    boxShadow = 'none'
                }
            }
        }
        MuiTabs           = @{
            root      = @{
                marginLeft = 1
            }
            indicator = @{
                height               = 3
                borderTopLeftRadius  = 3
                borderTopRightRadius = 3
                backgroundColor      = '#000'
            }
        }
        MuiTab            = @{
            root = @{
                textTransform = 'none'
                margin        = '0 16px'
                minWidth      = 0
                padding       = 0
            }
        }
        MuiIconButton     = @{
            root = @{
                padding = 1
            }
        }
        MuiTooltip        = @{
            tooltip = @{
                borderRadius = 4
            }
        }
        MuiDivider        = @{
            root = @{
                backgroundColor = 'rgb(255,255,255,0.15)'
            }
        }
        MuiListItemButton = @{
            root = @{
                '&.Mui-selected' = @{
                    color = '#4fc3f7'
                }
            }
        }
        MuiListItemText   = @{
            primary = @{
                color      = 'rgba(255, 255, 255, 0.7) '
                fontSize   = 14
                fontWeight = 500
            }
        }
        MuiListItemIcon   = @{
            root = @{
                color       = 'rgba(255, 255, 255, 0.7) '
                minWidth    = 'auto'
                marginRight = 2
                '& svg'     = @{
                    fontSize = 20
                }
            }
        }
        MuiAvatar         = @{
            root = @{
                width  = 32
                height = 32
            }
        }
    }
}

$Sand = @{
    palette = @{
      primary = @{
        light = '#ffe8d6'
        main = '#ddbea9'
        dark = '#cb997e'
      }
      secondary = @{
        light = '#b7b7a4'
        main = '#a5a58d'
        dark = '#6b705c'
      }
    }
  }

  $Compliment = @{
    palette = @{
      primary = @{
        light = '#e9c46a'
        main = '#2a9d8f'
        dark = '#264653'
      }
      secondary = @{
        light = '#e9c46a'
        main = '#f4a261'
        dark = '#e76f51'
      }
    }
  }

  $Themes = @{
    AntDesign = $AntDesign
    Paperbase = $Paperbase 
    Sand = $Sand
    Compliment = $Compliment
  }
  

function Get-UDTheme {
    <#
    .SYNOPSIS
    Returns predefined themes. 
    
    .DESCRIPTION
    Returns predefined themes. 
    
    .PARAMETER Name
    The name of the theme.
    
    .EXAMPLE
    $Theme = Get-UDTheme -Name 'AntDesign'
    
    .NOTES
    General notes
    #>
    param(
        [ValidateSet("AntDesign", 'Paperbase', 'Sand', 'Compliment')]
        [Parameter()]
        $Name
    )

    if ($Name) {
        $Themes[$Name]
    }
    else {
        @($AntDesign, $Paperbase)
    }
}