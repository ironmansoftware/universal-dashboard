# Universal Dashboard DarkDefault Theme
# https://material-ui.com/customization/color/

$FontColorDark = "#FFFFFF"
$FontColorLight = "#FFFFFF"

$BackgroundColorPrimary = "#393F47"
$BackgroundColorLighter = "#252525"
$BackgroundColorDarker = "#BDBDBD"
$BackgroundColorBright = "#272C33"

$PrimaryColor = "#272C33"
$PrimaryColorDark = "#272C33"

$PrimaryFontColor = $FontColorDark
$AlternateFontColor = $FontColorLight
$PrimaryBackgroundColor = $BackgroundColorPrimary
$AlternativeBackgroundColor = $BackgroundColorLighter
$AlternativeBackgroundColor2 = $BackgroundColorDarker
$AlternativeBackgroundColor3 = $BackgroundColorBright

@{
    Name = "DarkDefault"
    Definition = @{

        #UD ELEMENTS
        UDDashboard = @{
            BackgroundColor = $PrimaryBackgroundColor
            FontColor = $PrimaryFontColor 
        }

        UDNavBar = @{
            BackgroundColor = $PrimaryColor
            FontColor = $AlternateFontColor
        }

        UDFooter = @{
            BackgroundColor = $PrimaryColor
            FontColor = $AlternateFontColor
            "margin-top" = "20px"
        }

        UDCard = @{
            BackgroundColor = $AlternativeBackgroundColor3
            FontColor = $PrimaryFontColor
        }

        UDChart = @{
            BackgroundColor = $AlternativeBackgroundColor3
            FontColor = $PrimaryFontColor 
        }

        UDMonitor = @{
            BackgroundColor = $AlternativeBackgroundColor3
            FontColor = $PrimaryFontColor 
        }

        UDTable = @{
            BackgroundColor = $AlternativeBackgroundColor3
            FontColor = $PrimaryFontColor 
        }

        UDGrid = @{
            BackgroundColor = $AlternativeBackgroundColor3
            FontColor = $PrimaryFontColor 
        }

        UDCounter = @{
            BackgroundColor = $AlternativeBackgroundColor3
            FontColor = $PrimaryFontColor 
        }

        UDInput = @{
            BackgroundColor = $AlternativeBackgroundColor3
            FontColor = $PrimaryFontColor 
        }
    
        #CSS ELEMENTS
        'main' = @{
            'padding-left' = "50px"
            'padding-right' = "50px"
            'padding-top' = "50px"
            'padding-bottom' = "50px"
        }

        '@media screen and (max-width: 600px)' = @{
            'main' = @{
                'padding-left' = "3px"
                'padding-right' = "3px"
                'padding-top' = "3px"
                'padding-bottom' ="3px"
            }
        }

        'p' = @{
            'color' = "$PrimaryFontColor !important"
        }

        '.tabs' = @{
            'color'= $PrimaryColor
            'background-color' = $AlternativeBackgroundColor3
        }

        '.tabs .tab' = @{
            'color' = $AlternativeBackgroundColor
        }

        '.tabs .tab a:hover' = @{
            'background-color' = $AlternativeBackgroundColor
            'color'= $AlternateFontColor
        }

        '.tabs .tab a.active' = @{
            'background-color' = "#1c1c1c"
            'color'= $AlternateFontColor
        }

        '.tabs .tab a:focus.active' = @{
            'background-color' = $AlternativeBackgroundColor
            'color'= $AlternateFontColor
        }

        '.tabs .indicator' = @{
            'background-color' = "#FFFFFF"
        }

        '.tabs .tab a' = @{
            'color' = "#FFFFFF"
        }

        '[type="radio"]:checked + span::after' = @{
            'background-color' = "#FFFFFF"
        }

        '.btn' = @{
            'color' = $AlternateFontColor
            'background-color' = $PrimaryColor
        }

        '.btn:hover' = @{
            'color' = $AlternateFontColor
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
            'color' = $PrimaryFontColor
        }

        '[type="checkbox"]:checked + span:not(.lever)::before' = @{
            "border-right" = "2px solid $PrimaryColor"
            "border-bottom" = "2px solid $PrimaryColor"
        }

        '.pagination li a' = @{
            'color' = $PrimaryColor
        }

        '.pagination li.active' = @{
            'color' = "$PrimaryFontColor  !important"
            'background-color' = $PrimaryColor
        }

        '.sidenav' = @{
            'background-color' = $PrimaryColor
            'color' = $AlternateFontColor
        }

        '.sidenav a:hover' = @{
            'background-color' = $PrimaryColor
            'color'= $AlternateFontColor
        }

        '.sidenav li>a' = @{
            'color' = $AlternateFontColor
            'background-color' = $PrimaryColor
        }

        '.sidenav li>a:hover' = @{
            'background-color' = $PrimaryColorDark
        }

        '.sidenav.sidenav-fixed' = @{
            'background-color' = $PrimaryColor
        }

        '.sidenav .subheader' = @{
            'color'= $AlternateFontColor
            'font-size' = 'large'
        }

        '.sidenav .divider' = @{
            'background-color' = $PrimaryColorDark
        }

        '.sidenav .collapsible-header' = @{
            'color'= $AlternateFontColor
            'font-size' = 'large'
        }
    
        '.sidenav .collapsible-header:hover' = @{
            'color'= $AlternateFontColor
        }

        '.sidenav li.active' = @{
            'padding-left' = "0px !important"
        }

        '.progress' = @{
            'background-color' = $AlternativeBackgroundColor2
        }

        '.progress .determinate, .progress .indeterminate' = @{
            'background-color' = $PrimaryColor
            'border-bottom' = "1px solid $PrimaryBackgroundColor"
        }

        'input:not([type]), input[type="date"]:not(.browser-default), input[type="datetime-local"]:not(.browser-default), input[type="datetime"]:not(.browser-default), input[type="email"]:not(.browser-default), input[type="number"]:not(.browser-default), input[type="password"]:not(.browser-default), input[type="search"]:not(.browser-default), input[type="tel"]:not(.browser-default), input[type="text"]:not(.browser-default), input[type="time"]:not(.browser-default), input[type="url"]:not(.browser-default), textarea.materialize-textarea' = @{
            'color'= $PrimaryFontColor 
            'border-bottom' = "1px solid $PrimaryBackgroundColor"
        }

        'input:not([type]):not([readonly]):focus, input[type=date]:not([readonly]):not(.browser-default):focus, input[type=datetime-local]:not([readonly]):not(.browser-default):focus, input[type=datetime]:not([readonly]):not(.browser-default):focus, input[type=email]:not([readonly]):not(.browser-default):focus, input[type=number]:not([readonly]):not(.browser-default):focus, input[type=password]:not([readonly]):not(.browser-default):focus, input[type=search]:not([readonly]):not(.browser-default):focus, input[type=tel]:not([readonly]):not(.browser-default):focus, input[type=text]:not([readonly]):not(.browser-default):focus, input[type=time]:not([readonly]):not(.browser-default):focus, input[type=url]:not([readonly]):not(.browser-default):focus, textarea:not([readonly]).materialize-textarea:focus' = @{
            'color'= $PrimaryFontColor
            'border-bottom' = "1px solid $PrimaryColorDark"
        }

        'input:not([type]):not([readonly]):focus + label, input[type=date]:not([readonly]):not(.browser-default):focus + label, input[type=datetime-local]:not([readonly]):not(.browser-default):focus + label, input[type=datetime]:not([readonly]):not(.browser-default):focus + label, input[type=email]:not([readonly]):not(.browser-default):focus + label, input[type=number]:not([readonly]):not(.browser-default):focus + label, input[type=password]:not([readonly]):not(.browser-default):focus + label, input[type=search]:not([readonly]):not(.browser-default):focus + label, input[type=tel]:not([readonly]):not(.browser-default):focus + label, input[type=text]:not([readonly]):not(.browser-default):focus + label, input[type=time]:not([readonly]):not(.browser-default):focus + label, input[type=url]:not([readonly]):not(.browser-default):focus + label, textarea:not([readonly]).materialize-textarea:focus + label' = @{
            'color'= $PrimaryFontColor
        }

        '.switch label' = @{
            'color'= $PrimaryFontColor 
        }

        '.switch label input[type=checkbox]:checked+.lever' = @{
            'background-color' = $AlternativeBackgroundColor2
        }

        '.switch label input[type=checkbox]:checked+.lever:after' = @{
            'background-color' = $PrimaryColor
        }

        '.card .card-action a:not(.btn):not(.btn-large):not(.btn-small):not(.btn-large):not(.btn-floating)' = @{
            'color' = $PrimaryColor
            '-webkit-transition' = "color .3s ease"
            'transition'= "color .3s ease"
        }

        '.card .card-action a:not(.btn):not(.btn-floating):not(.btn-large):not(.btn-small):not(.btn-large)' = @{
            'color' = $PrimaryColor
            '-webkit-transition' = "color .3s ease"
            'transition'= "color .3s ease"
        }

        '.card .card-action a:not(.btn):not(.btn-floating):not(.btn-large):not(.btn-small):not(.btn-large):hover' = @{
            'color' = $PrimaryColorDark
            '-webkit-transition' = "color .3s ease"
            'transition'= "color .3s ease"
        }

        'a' = @{
            'color' = $PrimaryFontColor
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
            'color' = $PrimaryFontColor 
            'border-bottom' = "1px solid $PrimaryColorDark"
            'border-block-end-color' = $PrimaryColorDark
        }

        '.select-dropdown li span' = @{
            'color' = $PrimaryFontColor 
        }

        '[type=radio].with-gap:checked+span:after, [type=radio]:checked+span:after' = @{
            'background-color' = $PrimaryColor
        }

        '[type=radio].with-gap:checked+span:after, [type=radio].with-gap:checked+span:before, [type=radio]:checked+span:after' =@{
            'border' = "2px solid $PrimaryColorDark"
        }

        '.divider' = @{
            'background-color' = $AlternativeBackgroundColor
        }

        'pre' = @{
            'background-color' = $AlternativeBackgroundColor3
            'padding-left' = "5px"
            'padding-right' = "5px"
            'padding-top' = "5px"
            'padding-bottom' = "5px"
        }

        '.page-footer .footer-copyright' = @{
            'background-color' = $PrimaryColor
        }
        '.modal' = @{
            'color' = $PrimaryFontColor
            'background-color' = $PrimaryColor
        }
        '.modal h' = @{
            'color' = "$PrimaryFontColor !important"
        }

        '.card, .card-panel' = @{
            BackgroundColor = $AlternativeBackgroundColor3
            FontColor = $PrimaryFontColor
        }

        '.collapsible-header'= @{
            'color' = "#FFFFFF"
            'background-color' = "#272C33"
            'border-bottom' = '1px solid #1c1c1c;'
            'border-bottom-width' = '1px;'
            'border-bottom-style' = 'solid;'
            'border-bottom-color' = '#1c1c1c;'
        }
        '.collapsible' = @{
            'margin' = ".5rem 0 1rem"
            'border' = 'none'
        }

        '.collapsible-body' = @{
            'border-bottom' = 'none'
            "background-color" = "#272C33"
        }

        '.collection .collection-item' = @{
            "background-color" = "#272C33"
            'border-bottom' = '1px solid #1c1c1c;'
            'border-bottom-width' = '1px;'
            'border-bottom-style' = 'solid;'
            'border-bottom-color' = '#1c1c1c;'
            'color' = "#FFFFFF"
        }
    }
}
