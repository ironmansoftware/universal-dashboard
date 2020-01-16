# Universal Dashboard Default Theme
# https://material-ui.com/customization/color/

$FontColorDark = "#111111"
$FontColorLight = "#FFFFFF"
$FontFamily = '"Segoe UI",Roboto,Oxygen-Sans,Ubuntu,Cantarell,"Helvetica Neue",sans-serif'

$BackgroundColorPrimary = "#EEEEEE"
$BackgroundColorLighter = "#FAFAFA"
$BackgroundColorDarker = "#BDBDBD"
$BackgroundColorBright = "#FFFFFF"

$PrimaryColor = "#3F51B5"
$PrimaryColorDark = "#2C387E"
$PrimaryColorLight = "#6573C3"
$SecondaryColor = '#dd2c00'
$SecondaryColorLight = '#e35633'
$SecondaryColorDark = '#9a1e00'

$PrimaryFontColor = $FontColorDark
$AlternateFontColor = $FontColorLight
$PrimaryBackgroundColor = $BackgroundColorPrimary
$AlternativeBackgroundColor = $BackgroundColorLighter
$AlternativeBackgroundColor2 = $BackgroundColorDarker
$AlternativeBackgroundColor3 = $BackgroundColorBright

@{
    Name       = "Default"
    Definition = @{

        #UD ELEMENTS
        UDDashboard                            = @{
            BackgroundColor = $PrimaryBackgroundColor
            FontColor       = $PrimaryFontColor
            FontFamily = $FontFamily
        }

        UDNavBar                               = @{
            BackgroundColor = $PrimaryColor
            FontColor       = $AlternateFontColor
        }

        UDFooter                               = @{
            BackgroundColor = $PrimaryColor
            FontColor       = $AlternateFontColor
            "margin-top"    = "20px"
        }

        UDCard                                 = @{
            BackgroundColor = $AlternativeBackgroundColor3
            FontColor       = $PrimaryFontColor 
        }

        UDChart                                = @{
            BackgroundColor = $AlternativeBackgroundColor3
            FontColor       = $PrimaryFontColor 
        }

        UDMonitor                              = @{
            BackgroundColor = $AlternativeBackgroundColor3
            FontColor       = $PrimaryFontColor 
        }

        UDTable                              = @{
            BackgroundColor = $AlternativeBackgroundColor3
            FontColor       = $PrimaryFontColor 
        }

        UDGrid                                 = @{
            BackgroundColor = $AlternativeBackgroundColor3
            FontColor       = $PrimaryFontColor
        }

        UDCounter                              = @{
            BackgroundColor = $AlternativeBackgroundColor3
            FontColor       = $PrimaryFontColor 
        }

        UDInput                                = @{
            BackgroundColor = $AlternativeBackgroundColor3
            FontColor       = $PrimaryFontColor 
        }
    
        UDTabs = @{
            BackgroundColor = $AlternativeBackgroundColor3
            Height = 'auto'
            BoxShadow = 'unset'
            FontFamily = $FontFamily

        }

        UDTab = @{
            FontColor = $PrimaryColor
            FontFamily = $FontFamily
            # No need for backgroundColor it inherit UDTabs backgroundColor
        }

        UDTabActive = @{
            ActiveFontColor = $AlternateFontColor
            ActiveBackgroundColor = $PrimaryColor
        }

        UDTabIcon = @{
            FontColor = $PrimaryColor
            Height = 'auto'
            LineHeight = 'inherit'
        }

        UDTabActiveIcon = @{
            ActiveFontColor = $AlternateFontColor
        }

        UDTabIndicator = @{
            IndicatorColor = $PrimaryColorDark
        }

        UDImageCarouselIndicator = @{
            Width = '10px'
            Height = '10px'
        }
        
        UDImageCarouselIndicatorActive = @{
            BackgroundColor = $PrimaryColor
        }

        #CSS ELEMENTS
        'main'                                 = @{
            'padding-left'   = "50px"
            'padding-right'  = "50px"
            'padding-top'    = "50px"
            'padding-bottom' = "50px"
        }

        '@media screen and (max-width: 600px)' = @{
            'main' = @{
                'padding-left'   = "3px"
                'padding-right'  = "3px"
                'padding-top'    = "3px"
                'padding-bottom' = "3px"
            }
        }

        'p'                                    = @{
            'color' = $PrimaryFontColor
        }

        '.btn' = @{
            'color'            = $AlternateFontColor
            'background-color' = $PrimaryColor
        }

        '.btn:hover' = @{
            'color'            = $AlternateFontColor
            'background-color' = $PrimaryColorDark
        }

        '.btn-floating' = @{
            'background-color' = $PrimaryColor
        }

        '.btn-floating:hover' = @{
            'background-color' = $PrimaryColorDark
        }

        '.btn-floating:focus, .btn-large:focus, .btn-small:focus, .btn:focus' = @{
            'background-color' = $PrimaryColorDark
        }

        '.btn-flat' = @{
            'color' = $PrimaryColor
        }

        '[type="radio"]:checked + span::after' = @{
            'background-color' = $PrimaryColor
        }

        '[type="checkbox"]:checked + span:not(.lever)::before' = @{
            "border-right"  = "2px solid $PrimaryColor"
            "border-bottom" = "2px solid $PrimaryColor"
        }

        '.pagination li a' = @{
            'color' = $PrimaryColor
        }

        '.pagination li.active' = @{
            'color'            = "$PrimaryFontColor  !important"
            'background-color' = $PrimaryColor
        }

        '.sidenav' = @{
            'background-color' = $PrimaryColor
            'color'            = $AlternateFontColor
        }

        '.sidenav a:hover' = @{
            'background-color' = $PrimaryColor
            'color'            = $AlternateFontColor
        }

        '.sidenav li>a' = @{
            'color'            = $AlternateFontColor
            'background-color' = $PrimaryColor
        }

        '.sidenav li>a:hover' = @{
            'background-color' = $PrimaryColorDark
        }

        '.sidenav.sidenav-fixed' = @{
            'background-color' = $PrimaryColor
        }

        '.sidenav .subheader' = @{
            'color'     = $AlternateFontColor
            'font-size' = 'large'
        }

        '.sidenav .divider' = @{
            'background-color' = $PrimaryColorDark
        }

        '.sidenav .collapsible-body' = @{
            'background-color' = $PrimaryColor
        }

        '.sidenav .collapsible-header' = @{
            'color'     = $AlternateFontColor
            'font-size' = 'large'
        }
    
        '.sidenav .collapsible-header:hover' = @{
            'color' = $AlternateFontColor
        }

        '.sidenav li.active' = @{
            'padding-left' = "0px !important"
        }

        '.progress' = @{
            'background-color' = $AlternativeBackgroundColor2
        }

        '.progress .determinate, .progress .indeterminate' = @{
            'background-color' = $PrimaryColor
            'border-bottom'    = "1px solid $PrimaryBackgroundColor"
        }

        'input:not([type]), input[type="date"]:not(.browser-default), input[type="datetime-local"]:not(.browser-default), input[type="datetime"]:not(.browser-default), input[type="email"]:not(.browser-default), input[type="number"]:not(.browser-default), input[type="password"]:not(.browser-default), input[type="search"]:not(.browser-default), input[type="tel"]:not(.browser-default), input[type="text"]:not(.browser-default), input[type="time"]:not(.browser-default), input[type="url"]:not(.browser-default), textarea.materialize-textarea' = @{
            'color'         = $PrimaryFontColor 
            'border-bottom' = "1px solid $PrimaryBackgroundColor"
        }

        'input:not([type]):not([readonly]):focus, input[type=date]:not([readonly]):not(.browser-default):focus, input[type=datetime-local]:not([readonly]):not(.browser-default):focus, input[type=datetime]:not([readonly]):not(.browser-default):focus, input[type=email]:not([readonly]):not(.browser-default):focus, input[type=number]:not([readonly]):not(.browser-default):focus, input[type=password]:not([readonly]):not(.browser-default):focus, input[type=search]:not([readonly]):not(.browser-default):focus, input[type=tel]:not([readonly]):not(.browser-default):focus, input[type=text]:not([readonly]):not(.browser-default):focus, input[type=time]:not([readonly]):not(.browser-default):focus, input[type=url]:not([readonly]):not(.browser-default):focus, textarea:not([readonly]).materialize-textarea:focus' = @{
            'color'         = $PrimaryColor
            'border-bottom' = "1px solid $PrimaryColorDark"
        }

        'input:not([type]):not([readonly]):focus + label, input[type=date]:not([readonly]):not(.browser-default):focus + label, input[type=datetime-local]:not([readonly]):not(.browser-default):focus + label, input[type=datetime]:not([readonly]):not(.browser-default):focus + label, input[type=email]:not([readonly]):not(.browser-default):focus + label, input[type=number]:not([readonly]):not(.browser-default):focus + label, input[type=password]:not([readonly]):not(.browser-default):focus + label, input[type=search]:not([readonly]):not(.browser-default):focus + label, input[type=tel]:not([readonly]):not(.browser-default):focus + label, input[type=text]:not([readonly]):not(.browser-default):focus + label, input[type=time]:not([readonly]):not(.browser-default):focus + label, input[type=url]:not([readonly]):not(.browser-default):focus + label, textarea:not([readonly]).materialize-textarea:focus + label' = @{
            'color' = $PrimaryColor
        }

        '.switch label' = @{
            'color' = $PrimaryFontColor 
        }

        '.switch label input[type=checkbox]:checked+.lever' = @{
            'background-color' = $AlternativeBackgroundColor2
        }

        '.switch label input[type=checkbox]:checked+.lever:after' = @{
            'background-color' = $PrimaryColor
        }

        '.card .card-action a:not(.btn):not(.btn-large):not(.btn-small):not(.btn-large):not(.btn-floating)' = @{
            'color'              = $PrimaryColor
            '-webkit-transition' = "color .3s ease"
            'transition'         = "color .3s ease"
        }

        '.card .card-action a:not(.btn):not(.btn-floating):not(.btn-large):not(.btn-small):not(.btn-large)' = @{
            'color'              = $PrimaryColor
            '-webkit-transition' = "color .3s ease"
            'transition'         = "color .3s ease"
        }

        '.card .card-action a:not(.btn):not(.btn-floating):not(.btn-large):not(.btn-small):not(.btn-large):hover' = @{
            'color'              = $PrimaryColorDark
            '-webkit-transition' = "color .3s ease"
            'transition'         = "color .3s ease"
        }

        'a' = @{
            'color' = $PrimaryColor
        }

        '.dropdown-content' = @{
            'background-color' = $AlternativeBackgroundColor
        }
        
        '.dropdown-content li>a, .dropdown-content li>span' = @{
            'color' = $PrimaryFontColor 
        }

        '.select-dropdown.dropdown-content li.selected' = @{
            'background-color' = $AlternativeBackgroundColor2
        }

        '.select-wrapper input.select-dropdown' = @{
            'color'                  = $PrimaryFontColor 
            'border-bottom'          = "1px solid $PrimaryColorDark"
            'border-block-end-color' = $PrimaryColorDark
        }

        '.select-dropdown li span' = @{
            'color' = $PrimaryFontColor 
        }

        '[type=radio].with-gap:checked+span:after, [type=radio]:checked+span:after' = @{
            'background-color' = $PrimaryColor
        }

        '[type=radio].with-gap:checked+span:after, [type=radio].with-gap:checked+span:before, [type=radio]:checked+span:after' = @{
            'border' = "2px solid $PrimaryColorDark"
        }

        '.divider' = @{
            'background-color' = $AlternativeBackgroundColor
        }

        'pre' = @{
            'background-color' = $AlternativeBackgroundColor3
            'padding-left'     = "5px"
            'padding-right'    = "5px"
            'padding-top'      = "5px"
            'padding-bottom'   = "5px"
        }

        '.page-footer .footer-copyright' = @{
            'background-color' = $PrimaryColor
        }

    }
}
