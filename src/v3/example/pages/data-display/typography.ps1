New-ComponentPage -Title 'Typography' -Description 'Use typography to present your design and content as clearly and efficiently as possible.' -SecondDescription "Too many type sizes and styles at once can spoil any layout. A typographic scale has a limited set of type sizes that work well together along with the layout grid." -Content {
    New-Example -Title 'Variants' -Description '' -Example {
        @("h1", "h2", "h3", "h4", "h5", "h6", "subtitle1", "subtitle2", "body1", "body2", 
        "caption", "button", "overline", "srOnly", "inherit", 
        "display4", "display3", "display2", "display1", "headline", "title", "subheading") | ForEach-Object {
            New-UDTypography -Variant $_ -Text $_ -GutterBottom
            New-UDElement -Tag 'p' -Content {}
        }
    }
} -Cmdlet @("New-UDTypography")