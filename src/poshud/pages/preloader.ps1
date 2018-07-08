
New-UDPage -Name "Preloader" -Icon spinner -Content {
    New-UDRow -Columns {
        New-UDColumn -Size 2 -Content {}
        New-UDColumn -Size 10 -Content {
            New-UDHeading -Size 1 -Text "Preloaders"  -Color $Colors.FontColor

            New-UDParagraph -Content {
                "If you have content that will take a long time to load, you should give the user feedback. For this reason we provide a number activity + progress indicators."
            } -Color $Colors.FontColor
            
            New-UDHeading -Size 3 -Text "Linear"  -Color $Colors.FontColor

            New-UDParagraph -Content {
                "There are a couple different types of linear progress bars."
            } -Color $Colors.FontColor

            New-UDHeading -Size 5 -Text "Determinate" -Color $Colors.FontColor

            New-UDElementExample -Example {
                New-UDPreloader -PercentComplete 70 
            }

            New-UDHeading -Size 5 -Text "Indeterminate" -Color $Colors.FontColor

            New-UDElementExample -Example {
                New-UDPreloader 
            }

            New-UDHeading -Size 3 -Text "Circular"  -Color $Colors.FontColor

            New-UDParagraph -Content {
                "There are 4 colors and 3 sizes of circular spinners."
            } -Color $Colors.FontColor

            New-UDElementExample -Example {
                New-UDRow -Columns {
                    New-UDColumn -Size 4 -Content {
                        New-UDPreloader -Circular -Color blue -Size large
                    }
                    New-UDColumn -Size 4 -Content {
                        New-UDPreloader -Circular -Color red -Size medium
                    }
                    New-UDColumn -Size 4 -Content {
                        New-UDPreloader -Circular -Color green -Size small
                    }
                }
            }
        }
    }
}
