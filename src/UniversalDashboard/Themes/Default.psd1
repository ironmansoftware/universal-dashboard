# Universal Dashboard Default Theme
# https://material-ui.com/customization/color/

$FontColorDark = "#111111"
$FontColorLight = "#FFFFFF"

$PrimaryColor = "#3F51B5"
$PrimaryColorDark = "#2C387E"
$PrimaryColorLight = "#6573C3"

$BackgroundColorPrimary = "#EEEEEE"
$BackgroundColorLighter = "#FAFAFA"
$BackgroundColorDarker = "#BDBDBD"
$BackgroundColorBright = "#FFFFFF"

@{
    Name = "Default"
    Definition = @{

        #UD ELEMENTS
        UDDashboard = @{
            BackgroundColor = $BackgroundColorPrimary
            FontColor = $FontColorDark
        }

        UDNavBar = @{
            BackgroundColor = $PrimaryColor
            FontColor = $FontColorLight
        }

        UDFooter = @{
            BackgroundColor = $PrimaryColor
            FontColor = $FontColorLight
            "margin-top" = "4% !important"
        }

        UDCard = @{
            BackgroundColor = $BackgroundColorBright
            FontColor = $FontColorDark
        }

        UDChart = @{
            BackgroundColor = $BackgroundColorBright
            FontColor = $FontColorDark
        }

        UDMonitor = @{
            BackgroundColor = $BackgroundColorBright
            FontColor = $FontColorDark
        }

        UDTable = @{
            BackgroundColor = $BackgroundColorBright
            FontColor = $FontColorDark
        }

        UDGrid = @{
            BackgroundColor = $BackgroundColorBright
            FontColor = $FontColorDark
        }

        UDCounter = @{
            BackgroundColor = $BackgroundColorBright
            FontColor = $FontColorDark
        }

        UDInput = @{
            BackgroundColor = $BackgroundColorBright
            FontColor = $FontColorDark
        }
    
        #CSS ELEMENTS
        'main' = @{
            'padding-left' = "50px"
            'padding-right' = "50px"
            'padding-top' = "50px"
            'padding-bottom' = "50px"
        }

        'p' = @{
            'color' = "$FontColorDark !important"
        }

        '.tabs' = @{
            'color'= $PrimaryColor
            'background-color' = $BackgroundColorBright
        }

        '.tabs .tab' = @{
            'color' = $PrimaryColor
        }

        '.tabs .tab a:hover' = @{
            'background-color' = $PrimaryColorDark
            'color'= $FontColorLight
        }

        '.tabs .tab a.active' = @{
            'background-color' = $PrimaryColor
            'color'= $FontColorLight
        }

        '.tabs .tab a:focus.active' = @{
            'background-color' = $PrimaryColor
            'color'= $FontColorLight
        }

        '.tabs .indicator' = @{
            'background-color' = $PrimaryColorDark
        }

        '.tabs .tab a' = @{
            'color' = $PrimaryColor
        }

        '.btn' = @{
            'color' = $FontColorLight
            'background-color' = $PrimaryColor
        }

        '.btn:hover' = @{
            'color' = $FontColorLight
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
            "border-right" = "2px solid $PrimaryColor"
            "border-bottom" = "2px solid $PrimaryColor"
        }

        '.pagination li a' = @{
            'color' = $PrimaryColor
        }

        '.pagination li.active' = @{
            'color' = "$FontColorDark !important"
            'background-color' = $PrimaryColor
        }

        '.sidenav' = @{
            'background-color' = $BackgroundColorPrimary
            'z-index' = "0"
            'color' = $FontColorLight
        }

        '.sidenav a:hover' = @{
            'background-color' = $PrimaryColor
            'color'= $FontColorLight
        }

        '.sidenav li>a' = @{
            'color' = $FontColorLight
            'background-color' = $PrimaryColor
        }

        '.sidenav li>a:hover' = @{
            'background-color' = $PrimaryColorDark
        }

        '.sidenav.sidenav-fixed' = @{
            'background-color' = $PrimaryColor
        }

        '.sidenav .subheader' = @{
            'color'= $FontColorLight
            'font-size' = 'large'
        }

        '.sidenav .divider' = @{
            'background-color' = $PrimaryColorDark
        }

        '.sidenav .collapsible-header' = @{
            'color'= $FontColorLight
            'font-size' = 'large'
        }
    
        '.sidenav .collapsible-header:hover' = @{
            'color'= $FontColorLight
        }

        '.sidenav li.active' = @{
            'padding-left' = "0px !important"
        }

        '.progress' = @{
            'background-color' = $BackgroundColorDarker
        }

        '.progress .determinate, .progress .indeterminate' = @{
            'background-color' = $PrimaryColor
            'border-bottom' = "1px solid $BackgroundColorPrimary"
        }

        'input:not([type]), input[type="date"]:not(.browser-default), input[type="datetime-local"]:not(.browser-default), input[type="datetime"]:not(.browser-default), input[type="email"]:not(.browser-default), input[type="number"]:not(.browser-default), input[type="password"]:not(.browser-default), input[type="search"]:not(.browser-default), input[type="tel"]:not(.browser-default), input[type="text"]:not(.browser-default), input[type="time"]:not(.browser-default), input[type="url"]:not(.browser-default), textarea.materialize-textarea' = @{
            'color'= $FontColorDark
            'border-bottom' = "1px solid $BackgroundColorPrimary"
        }

        'input:not([type]):not([readonly]):focus, input[type=date]:not([readonly]):not(.browser-default):focus, input[type=datetime-local]:not([readonly]):not(.browser-default):focus, input[type=datetime]:not([readonly]):not(.browser-default):focus, input[type=email]:not([readonly]):not(.browser-default):focus, input[type=number]:not([readonly]):not(.browser-default):focus, input[type=password]:not([readonly]):not(.browser-default):focus, input[type=search]:not([readonly]):not(.browser-default):focus, input[type=tel]:not([readonly]):not(.browser-default):focus, input[type=text]:not([readonly]):not(.browser-default):focus, input[type=time]:not([readonly]):not(.browser-default):focus, input[type=url]:not([readonly]):not(.browser-default):focus, textarea:not([readonly]).materialize-textarea:focus' = @{
            'color'= $PrimaryColor
        }

        'input:not([type]):not([readonly]):focus + label, input[type=date]:not([readonly]):not(.browser-default):focus + label, input[type=datetime-local]:not([readonly]):not(.browser-default):focus + label, input[type=datetime]:not([readonly]):not(.browser-default):focus + label, input[type=email]:not([readonly]):not(.browser-default):focus + label, input[type=number]:not([readonly]):not(.browser-default):focus + label, input[type=password]:not([readonly]):not(.browser-default):focus + label, input[type=search]:not([readonly]):not(.browser-default):focus + label, input[type=tel]:not([readonly]):not(.browser-default):focus + label, input[type=text]:not([readonly]):not(.browser-default):focus + label, input[type=time]:not([readonly]):not(.browser-default):focus + label, input[type=url]:not([readonly]):not(.browser-default):focus + label, textarea:not([readonly]).materialize-textarea:focus + label' = @{
            'color'= $PrimaryColor
        }

        '.switch label input[type=checkbox]:checked+.lever' = @{
            'background-color' = $BackgroundColorDarker
        }

        '.switch label input[type=checkbox]:checked+.lever:after' = @{
            'background-color' = $PrimaryColor
        }

        '.card .card-action a:not(.btn):not(.btn-large):not(.btn-small):not(.btn-large):not(.btn-floating)' = @{
            'color' = $PrimaryColor
            '-webkit-transition' = "color .3s ease"
            'transition'= "color .3s ease"
        }

        'a' = @{
            'color' = $PrimaryColor
        }

        '.dropdown-content li>a, .dropdown-content li>span' = @{
            'color' = $PrimaryColor
        }

        '.dropdown-content' = @{
            'background-color' = $BackgroundColorDarker
        }

        '.select-wrapper input.select-dropdown' = @{
            'color' = $FontColorLight
            'border-bottom' = "1px solid #FFFFFF"
            'border-block-end-color' = "#FFFFFF"
        }

        '.select-dropdown li span' = @{
            'color' = $FontColorLight
        }

        '[type=radio].with-gap:checked+span:after, [type=radio]:checked+span:after' = @{
            'background-color' = $PrimaryColor
        }

        '[type=radio].with-gap:checked+span:after, [type=radio].with-gap:checked+span:before, [type=radio]:checked+span:after' =@{
            'border' = "2px solid $PrimaryColorDark"
        }

        '.divider' = @{
            'background-color' = $BackgroundColorLighter
        }
        
  

    }
}