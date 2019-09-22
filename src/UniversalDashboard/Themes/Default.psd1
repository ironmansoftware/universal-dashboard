@{
    Name = "Default"
    Definition = @{
    '.divider' = @{
'height’ = "1px"
'overflow’ = "hidden"
'background-color' = "#fff"
}
'.switch label input[type="checkbox"]:checked + .lever::after' = @{
    "background-color" = "#3f51b5"
}
'.switch label input[type="checkbox"]:checked + .lever' = @{
	"background-color" = "#3f51b5"
}
        
        UDDashboard = @{
            BackgroundColor = "#EEEEEE"
            FontColor = "#111111"
            
        }
        UDNavBar = @{
            BackgroundColor = "#3f51b5"
            FontColor = "#ffffff"
        }
        UDFooter = @{
            BackgroundColor = "#3f51b5"
            FontColor = "#ffffff"
            "margin-top" = "20px"
        }
    
        'main' = @{
            'padding-left' = "50px"
            'padding-right' = "50px"
            'padding-top' = "50px"
            'padding-bottom' = "50px"
        }
    
        '.btn' = @{
            'background-color' = "#3f51b5"
        }
    
        '.btn:hover' = @{
            'background-color' = "#2c387e"
        }
    
        '.btn-floating' = @{
            'background-color' = "#3f51b5"
        }
    
        '.btn-floating:hover' = @{
            'background-color' = "#2c387e"
        }
    
        '.btn-floating:focus, .btn-large:focus, .btn-small:focus, .btn:focus' = @{
            'background-color' = "#2c387e"
        }
        
        '[type="radio"]:checked + span::after' = @{
            'background-color' = "#3f51b5"
        }
    
        '[type="checkbox"]:checked + span:not(.lever)::before' = @{
            "border-right" = "2px solid #3f51b5"
            "border-bottom" = "2px solid #3f51b5"
        }
    
        '.pagination li a' = @{
            'color' = "#3f51b5"
        }
    
        '.pagination li.active' = @{
            'color' = "#111111 !important"
            'background-color' = "#3f51b5"
        }
    
        '.tabs' = @{
            'color'= "#3f51b5"
            
        }
        '.tabs .tab' = @{
            'color' = "#3f51b5"
        }
    
        '.tabs .tab a:hover' = @{
            'background-color' = "#3f51b5"
            'color'= "#ffffff"
        }
    
        '.tabs .tab a.active' = @{
            'background-color' = "#3f51b5"
            'color'= "#ffffff"
        }
    
        '.tabs .tab a:focus.active' = @{
            'background-color' = "#3f51b5"
            'color'= "#ffffff"
        }
    
        '.tabs .indicator' = @{
            'background-color' = "#2c387e"
        }
    
        '.tabs .tab a' = @{
            'color' = "#3f51b5"
        }
    
        '.sidenav a:hover' = @{
            'background-color' = "#3f51b5"
            'color'= "#FFFFFF"
        }
    
        '.sidenav li>a' = @{
            'color' = "#FFFFFF"
            'background-color' = "#3f51b5"
        }
       
        '.sidenav li>a:hover' = @{
            'background-color' = "#2c387e"
        }
    
        '.sidenav.sidenav-fixed' = @{
            'background-color' = "#3f51b5"
        }
    
        '.sidenav' = @{
            'background-color' = "#3f51b5"
        }
    
        '.sidenav .subheader' = @{
            'color'= "#ffffff"
            'font-size' = 'large'
        }
    
        '.sidenav .divider' = @{
            'background-color' = "#2c387e"
        }
    
        '.sidenav .collapsible-header' = @{
            'color'= "#ffffff"
            'font-size' = 'large'
        }
    
        '.sidenav .collapsible-header:hover' = @{
            'color'= "#ffffff"
        }

        '.progress' = @{
            'background-color' = '#8c9eff'
        }

        '.progress .determinate, .progress .indeterminate' = @{
            'background-color' = '#3f51b5'
        }

        'input:not([type]), input[type="date"]:not(.browser-default), input[type="datetime-local"]:not(.browser-default), input[type="datetime"]:not(.browser-default), input[type="email"]:not(.browser-default), input[type="number"]:not(.browser-default), input[type="password"]:not(.browser-default), input[type="search"]:not(.browser-default), input[type="tel"]:not(.browser-default), input[type="text"]:not(.browser-default), input[type="time"]:not(.browser-default), input[type="url"]:not(.browser-default), textarea.materialize-textarea' = @{
            'color'= "#111111"
        }
    
        'input:not([type]):not([readonly]):focus, input[type=date]:not([readonly]):not(.browser-default):focus, input[type=datetime-local]:not([readonly]):not(.browser-default):focus, input[type=datetime]:not([readonly]):not(.browser-default):focus, input[type=email]:not([readonly]):not(.browser-default):focus, input[type=number]:not([readonly]):not(.browser-default):focus, input[type=password]:not([readonly]):not(.browser-default):focus, input[type=search]:not([readonly]):not(.browser-default):focus, input[type=tel]:not([readonly]):not(.browser-default):focus, input[type=text]:not([readonly]):not(.browser-default):focus, input[type=time]:not([readonly]):not(.browser-default):focus, input[type=url]:not([readonly]):not(.browser-default):focus, textarea:not([readonly]).materialize-textarea:focus' = @{
            'color'= "#3f51b5"
        }
        
        'input:not([type]):not([readonly]):focus + label, input[type=date]:not([readonly]):not(.browser-default):focus + label, input[type=datetime-local]:not([readonly]):not(.browser-default):focus + label, input[type=datetime]:not([readonly]):not(.browser-default):focus + label, input[type=email]:not([readonly]):not(.browser-default):focus + label, input[type=number]:not([readonly]):not(.browser-default):focus + label, input[type=password]:not([readonly]):not(.browser-default):focus + label, input[type=search]:not([readonly]):not(.browser-default):focus + label, input[type=tel]:not([readonly]):not(.browser-default):focus + label, input[type=text]:not([readonly]):not(.browser-default):focus + label, input[type=time]:not([readonly]):not(.browser-default):focus + label, input[type=url]:not([readonly]):not(.browser-default):focus + label, textarea:not([readonly]).materialize-textarea:focus + label' = @{
            'color'= "#3f51b5"
        }

    }
}