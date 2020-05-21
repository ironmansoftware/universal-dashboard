Enter-SeUrl -Url "$Address/Test/image-carousel" -Target $Driver
Describe "New-UDImageCarousel" {
    $carousel = Find-SeElement -Driver $driver -Id 'carousel-demo'

    it "Should have image carousel component" {
        $carousel -eq $null | Should be $false
    }

    it "Should have 3 slides in the image carousel" {
        $carousel.FindElementsByClassName('carousel-item').count | Should be 3
    }

    it "Should have fixed button" {
        $carousel.FindElementsByClassName('carousel-fixed-item').count | should be 1
    }

    it "Should have custom height Size" {
        $carousel.Size.Height | should be 750
    }
}
