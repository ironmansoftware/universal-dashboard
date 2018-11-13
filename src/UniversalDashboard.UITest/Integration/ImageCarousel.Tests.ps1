param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
Import-Module $ModulePath -Force

Describe "New-UDImageCarousel" {

    Context "Image Carousel With Slides" {
        
        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            New-UDDashboard -Title "Test Carousel" -Pages (New-UDPage -Name "Home" -Content {

                $FirstSlide = @{
                    backgroundRepeat = "no-repeat"
                    BackgroundImage = "https://stmed.net/sites/default/files/lady-deadpool-wallpapers-27626-5413437.jpg"
                    BackgroundColor  = "transparent"
                    BackgroundSize = "cover"
                    BackgroundPosition = "0% 0%"
                    Url  = "https://universaldashboard.io/"
                }
                $SecondSlide = @{
                    BackgroundColor  = "blue"
                }
                $ThirdSlide = @{
                    BackgroundColor  = "transparent"
                    BackgroundSize = "cover"
                    BackgroundPosition = "0% 0%"
                    Url  = "https://stmed.net/sites/default/files/ultimate-spider-man-wallpapers-27724-2035627.jpg"
                    BackgroundImage  = "https://stmed.net/sites/default/files/ultimate-spider-man-wallpapers-27724-2035627.jpg"
                }
                New-UDImageCarousel -Id "carousel-demo" -Items {
                    New-UDImageCarouselItem @FirstSlide
                    New-UDImageCarouselItem @SecondSlide
                    New-UDImageCarouselItem @ThirdSlide
                }  -Height 750px -FullWidth -ShowIndecators -ButtonText "Button" -FixButton
            
            })
        ))') -SessionVariable ss -ContentType "text/plain"

        $Cache:Driver.navigate().refresh()

        $carousel = Find-SeElement -Driver $Cache:Driver -Id "carousel-demo"

        it "Should have image carousel component" {
            $carousel -eq $null | Should be $false
        }

        it "Should have 3 slides in the image carousel" {
            $carousel.FindElementsByClassName("carousel-item").count | Should be 3
        }

        it "Should have fixed button" {
            $carousel.FindElementsByClassName("carousel-fixed-item").count | should be 1
        }

        it "Should have custom height Size" {
            $carousel.Size.Height | should be 750
        }
    }
}
