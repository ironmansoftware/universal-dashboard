@{
    Name = "Azure"
    Definition = @{
        UDDashboard = @{
            BackgroundColor = "#333333"
            FontColor = "#FFFFF"
        }
        UDNavBar = @{
            BackgroundColor = "#1c1c1c"
            FontColor = "#55b3ff"
        }
        UDCard = @{
            BackgroundColor = "#252525"
            FontColor = "#FFFFFF"
            'border-radius'    = "12px"
        }
        UDChart = @{
            BackgroundColor = "#252525"
            FontColor = "#FFFFFF"
            'border-radius'    = "12px"
        }
        UDMonitor = @{
            BackgroundColor = "#252525"
            FontColor = "#FFFFFF"
            'border-radius'    = "12px"
        }
        UDTable = @{
            BackgroundColor = "#252525"
            FontColor = "#FFFFFF"
            'border-radius'    = "12px"
        }
        UDGrid = @{
            BackgroundColor = "#252525"
            FontColor = "#FFFFFF"
            'border-radius'    = "12px"
        }
        UDCounter = @{
            BackgroundColor = "#252525"
            FontColor = "#FFFFFF"
            'border-radius'    = "12px"
        }
        UDInput = @{
            BackgroundColor = "#252525"
            FontColor = "#FFFFFF"

        }
        UDFooter = @{
            BackgroundColor = "#1c1c1c"
            FontColor = "#55b3ff"
            "margin-top" = "20px"
        }
        '.tabs'                                                                                                                    = @{
            'color' = "#55b3ff"
            'margin-top' = "64px"
            'background-color' = "#333333"
            'z-index' = "9998"
        }
        '.tabs .tab' = @{
            'color' = "#252525"
            }

            '.tabs .tab a:hover'                                                                                                            = @{
                'background-color' = "#252525"
                'color'            = "#55b3ff"
            }

            '.tabs .tab a.active'                                                                                                           = @{
                'background-color' = "#1c1c1c"
                'color'            = "#55b3ff"
            }
            '.tabs .tab a:focus.active'                                                                                                     = @{

            'background-color' = "#252525"
            'color' = "#55b3ff"
            }
            '.tabs .indicator' = @{
            'background-color' = "#55b3ff"
            }
            '.tabs .tab a' = @{
            'color' = "#FFFFFF"
            }

            '[type="radio"]:checked + span::after' = @{

                'background-color' =  "#55b3ff"

            }
            '.pagination li a' = @{
                color = "#55b3ff !important"
            }
            ".ud-navbar"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          = @{
                'width'    = "100%"
                'position' = "fixed"
                'z-index'  = "9999"
            }
            'nav'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 = @{
                'left'  = "0"
                'right' = "0"

            }
            'input:not([type]), input[type="date"]:not(.browser-default), input[type="datetime-local"]:not(.browser-default), input[type="datetime"]:not(.browser-default), input[type="email"]:not(.browser-default), input[type="number"]:not(.browser-default), input[type="password"]:not(.browser-default), input[type="search"]:not(.browser-default), input[type="tel"]:not(.browser-default), input[type="text"]:not(.browser-default), input[type="time"]:not(.browser-default), input[type="url"]:not(.browser-default), textarea.materialize-textarea' = @{
                'border-bottom' = "1px solid #55b3ff"
                'color'         = "#FFFFFF"
            }
            '.select-wrapper input.select-dropdown'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               = @{
                'color'                  = "#ffffff"
                'border-bottom'          = "1px solid #55b3ff"
                'border-block-end-color' = "#55b3ff"
            }
            '.dropdown-content'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   = @{
                'background-color' = "#333333"
            }
            '.btn'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                = @{
                'color'            = "#ffffff"
                'background-color' = "#1c1c1c"
                'border-radius'    = "8px"
            }
            '.btn:hover'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          = @{
                'color'            = "#ffffff"
                'background-color' = "#55b3ff"
            }
            '.btn-floating' = @{
                'color'            = "#ffffff"
                'background-color' = "#1c1c1c"
            }
            '.select-dropdown li span'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            = @{
                'color' = "#ffffff"
            }

            '.sidenav'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            = @{
                'background-color' = "#1c1c1c"
                'margin-top'       = "75px"
                'height'           = "77%"
                'border-radius'    = "8px"
                'box-shadow'       = "none"
                'z-index'          = "0"
                'color' = "#fff"
            }

            '.sidenav a:hover'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    = @{
                'background-color' = "#1e353f"
                'color'            = "#e16036"
            }
            '.sidenav li > a'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     = @{
                'color'     = "#f1f1f1"
                'font-size' = "18px"
            }
            'li'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  = @{
                'color' = "#55b3ff"
            }
            '.collapsible-header'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 = @{
                'background-color' = "#252525"
                'border-bottom'    = "1px solid #55b3ff"
            }
            '.collapsible' = @{
                "border-top" = "1px solid #55b3ff"
                "border-right" = "1px solid #55b3ff"
                "border-left" = "1px solid #55b3ff"
                'margin' = ".5rem 0 1rem"
            }
            'h' = @{
                "color" = "#fff !important"
            }
            '.collapsible-body' = @{
                "background-color" = "#252525"
                "border-bottom" = "1px solid #fff"
            }
            '[type="checkbox"]:checked + span:not(.lever)::before' = @{
                "border-right" = "2px solid #55b3ff"
                "border-bottom" = "2px solid #55b3ff"
            }
            '.collection .collection-item' = @{
                'background-color' = "#252525"
            }
            'img'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 = @{
                'border-radius' = "8px"
                'float' ="left"
            }
    }
}