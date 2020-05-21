Enter-SeUrl "$Address/Test/Modal" -Target $Driver

Describe "Modal" {
    It "should open modal with new content" {
        $Element = Find-SeElement -Driver $Driver -Id 'buttonShow' 
        Invoke-SeClick -Element $Element 

        Start-Sleep 3

        Find-SeElement -Driver $Driver -Id 'modal-content1' | Should not be $null

        Find-SeElement -Driver $Driver -TagName 'body' | Invoke-SeClick -Driver $Driver -JavaScriptClick
        Enter-SeUrl -Url "$Address/Test/Modal" -Target $Driver 
    }

    It "should dispose of content when hidden" {
        
        $Element = Find-SeElement -Driver $Driver -Id 'button2' 
        Invoke-SeClick -Element $Element 

        Start-Sleep 3

        Find-SeElement -Driver $Driver -Id 'modal-content2' | Should not be $null

        $Element = Find-SeElement -Driver $Driver -Id 'hide' 
        Invoke-SeClick -Element $Element 

        Start-Sleep 1

        Find-SeElement -Driver $Driver -Id 'modal-content2' | Should be $null
        Enter-SeUrl -Url "$Address/Test/Modal" -Target $Driver 
    }

    It "should open and close modal" {
        Find-SeElement -Driver $Driver -Id "Click" | Invoke-SeClick

        Start-Sleep 3

        (Find-SeElement -Driver $driver -Id "Heading").Text | Should be "Heading"
        Find-SeElement -Driver $Driver -Id "Close" | Invoke-SeClick
    }
}