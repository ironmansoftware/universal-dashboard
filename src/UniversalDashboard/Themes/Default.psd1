@{
    Name = "Default"
    Definition = @{
        
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
        }

        '.btn' = @{
            'background-color' = "#3f51b5"
        }

        '.btn:hover' = @{
            'background-color' = "#002984"
        }

        '.btn-floating' = @{
            'background-color' = "#3f51b5"
        }

        'main' = @{
            'padding-left' = "50px"
            'padding-right' = "50px"
            'padding-top' = "50px"
            'padding-bottom' = "50px"
        }

        '[type="radio"]:checked + span::after' = @{
            'background-color' = "#3f51b5"
        }

        '[type="checkbox"]:checked + span:not(.lever)::before' = @{
            "border-right" = "2px solid #3f51b5"
            "border-bottom" = "2px solid #3f51b5"
        }

        '.pagination li a'= @{
            'color' = "#3f51b5"
        }

        '.pagination li.active' = @{
            'color' = "#111111 !important"
            'background-color' = "#3f51b5"
        }

    }
}