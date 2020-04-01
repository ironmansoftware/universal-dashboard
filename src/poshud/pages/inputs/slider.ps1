New-ComponentPage -Title 'Slider' -Description 'Sliders allow users to make selections from a range of values.' -SecondDescription "Sliders reflect a range of values along a bar, from which users may select a single value. They are ideal for adjusting settings such as volume, brightness, or applying image filters." -Content {
    New-Example -Title 'Slider' -Description '' -Example {
        New-UDSlider -Value 1
    }

    New-Example -Title 'Slider with min and max values' -Description '' -Example {
        New-UDSlider -Min 10 -Max 1000
    }

    New-Example -Title 'Slider with custom step size' -Description '' -Example {
        New-UDSlider -Min 10 -Max 1000 -Step 100
    }

    New-Example -Title 'Disabled slider' -Description '' -Example {
        New-UDSlider -Disabled
    }

    New-Example -Title 'Slider with marks' -Description '' -Example {
        New-UDSlider -Marks
    }

    New-Example -Title 'Range based slider' -Description '' -Example {
        New-UDSlider -Value @(1, 10)
    }

    New-Example -Title 'OnChange event for slider' -Description '' -Example {       
New-UDSlider -OnChange {
    Show-UDToast -Message $Body 
    Set-TestData $Body
}
    }
} -Cmdlet @("New-UDSlider")