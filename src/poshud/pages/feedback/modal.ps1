New-ComponentPage -Title 'Modal' -Description 'Modals inform users about a task and can contain critical information, require decisions, or involve multiple tasks.' -SecondDescription "" -Content {
    New-Example -Title 'Basic' -Description '' -Example {
New-UDButton -Text 'Basic' -OnClick {
    Show-UDModal -Content {
        New-UDTypography -Text "Hello"
    }
}
    }

    New-Example -Title 'Full Screen' -Description '' -Example {
New-UDButton -Text 'Full Screen' -OnClick {
    Show-UDModal -Content {
        New-UDTypography -Text "Hello"
    } -Footer {
        New-UDButton -Text "Close" -OnClick { Hide-UDModal }
    }  -FullScreen
}
    }

    New-Example -Title 'Full Width' -Description '' -Example {
New-UDButton -Text 'Full Width' -OnClick {
    Show-UDModal -Content {
        New-UDTypography -Text "Hello"
    } -FullWidth -MaxWidth 'md'
}
    }

    New-Example -Title 'Persistent' -Description '' -Example {
New-UDButton -Text 'Persistent' -OnClick {
    Show-UDModal -Content {
        New-UDTypography -Text "Hello"
    } -Footer {
        New-UDButton -Text "Close" -OnClick { Hide-UDModal }
    } -Persistent
}
    }
    
} -Cmdlet @("Show-UDModal", "Hide-UDModal")