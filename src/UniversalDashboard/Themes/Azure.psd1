$FontFamily = '"Segoe UI",Roboto,Oxygen-Sans,Ubuntu,Cantarell,"Helvetica Neue",sans-serif'

$PrimaryColor = "#1C1C1C"
$PrimaryColorDark =  "#FFFFFF"
$AlternativeBackgroundColor3 = "#252525"
$AlternateFontColor = "#FFFFFF"

@{
  Name = "Azure"
  Definition = @{
      UDDashboard = @{
          BackgroundColor = "#333333"
          FontColor = "#FFFFFF"
      }
      UDNavBar = @{
          BackgroundColor =  $PrimaryColor
          FontColor = $AlternateFontColor
      }
      UDFooter = @{
          BackgroundColor =  $PrimaryColor
          FontColor = "#FFFFFF"
          "margin-top" = "4% !important"
      }

      UDCard = @{
          BackgroundColor = "#252525"
          FontColor = "#FFFFFF"
      }
      UDChart = @{
          BackgroundColor = "#252525"
          FontColor = "#FFFFFF"
      }
      UDMonitor = @{
          BackgroundColor = "#252525"
          FontColor = "#FFFFFF"
      }
      UDTable = @{
          BackgroundColor = "#252525"
          FontColor = "#FFFFFF"
      }
      UDGrid = @{
          BackgroundColor = "#252525"
          FontColor = "#FFFFFF"
      }
      UDCounter = @{
          BackgroundColor = "#252525"
          FontColor = "#FFFFFF"
      }
      UDInput = @{
          BackgroundColor = "#252525"
          FontColor = "#FFFFFF"
      }

      'p' = @{
          'color' = '#FFFFFF !important'
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

      '[type="radio"]:checked + span::after' = @{
          'background-color' = "#FFFFFF"
      }
      
      '.pagination li a'= @{
          'color' = "#FFFFFF !important"
      }
      'input:not([type]), input[type="date"]:not(.browser-default), input[type="datetime-local"]:not(.browser-default), input[type="datetime"]:not(.browser-default), input[type="email"]:not(.browser-default), input[type="number"]:not(.browser-default), input[type="password"]:not(.browser-default), input[type="search"]:not(.browser-default), input[type="tel"]:not(.browser-default), input[type="text"]:not(.browser-default), input[type="time"]:not(.browser-default), input[type="url"]:not(.browser-default), textarea.materialize-textarea' = @{
          'border-bottom' = "1px solid #FFFFFF"
          'color'= "#FFFFFF"
      }
      '.select-wrapper input.select-dropdown'= @{
          'color'= "#ffffff"
          'border-bottom' = "1px solid #FFFFFF"
          'border-block-end-color' = "#FFFFFF"
      }
      '.dropdown-content'= @{
          'background-color' = "#333333"
      }
      '.btn'= @{
          'color'= "#1c1c1c"
          'background-color' = "#bababa"
      }
      '.btn:hover'= @{
          'color'= "#000000"
          'background-color' = "#FFFFFF"
      }
      '.btn-floating'= @{
          'color'= "#1c1c1c"
          'background-color' = "#bababa"
      }
      '.select-dropdown li span' = @{
          'color' = "#ffffff"
      }

      '.sidenav'= @{
          'background-color' = "#1c1c1c"
          'z-index' = "9999"
          'color'= "#FFF"
          "position" = "fixed"
      }


      '.sidenav a:hover'= @{
          'background-color' = "#1e353f"
          'color'= "#FFFFFF"
      }
      '.sidenav li > a' = @{
          'color'= "#f1f1f1"
      }
      'li'= @{
          'color' = "#FFFFFF"
      }
      '.collapsible-header'= @{
          'background-color' = "#252525"
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
          "background-color" = "#252525"
      }
      'h'= @{
          "color" = "#fff !important"
      }
      'h3, h4' = @{
          'line-height' = "110%"
          'color' = "#fff"
      }

      '.collection .collection-item'= @{
          'background-color' = "#252525"
      }
      '.pagination li.active' = @{
          'background-color' = "#FFFFFF"
      }
      
      '.sidenav .collapsible-header, .sidenav .collapsible li, ul:not(.browser-default)'= @{
          'color'= "#fff !important"
          'background-color' = "#1c1c1c !important"
      }
      
      '.card .card-action a:not(.btn):not(.btn-large):not(.btn-small):not(.btn-large):not(.btn-floating)'= @{
          'color'= "#FFFFFF"
          'margin-right' = "24px"
          '-webkit-transition' = "color .3s ease"
          'transition'= "color .3s ease"
          'text-transform'= "uppercase"
      }
      '.btn-flat' = @{
          'color' = "#fff"
      }
      '.sidenav .subheader' = @{
          'color' = "#fff"
      }
      '.svg-inline--fa' = @{
          'color' = "#fff"
      }
      '.modal'= @{
          'color' = "#FFFFFF"
          'background-color' = "#333333"
      }
  }
}
  