
$CustomElement = {
    New-UDElement -Tag "span" -Content { "Custom Element!" } -Attributes @{ className = "white-text" }
}

$NestedElements = {
    New-UDElement -Tag "div" -Attributes @{ className = "card black-text"} -Content {
        New-UDElement -Tag "div" -Attributes @{ className = "card-content" } -Content { "Nested Element!" }
     }
}

$Attributes = {
    New-UDElement -Tag "div" -Attributes @{
        className = "card"
        style = @{
            backgroundColor = "#4081C9"
            color = "#FFFFFF"
        }
    } -Content {
        "Attributes"
    }
}

$LoadContentFromAnEndpoint = {
    New-UDElement -Tag "div" -Attributes @{ className = "white-text" } -Endpoint {
        Get-Date
    }
}

$SetContentFromAnEndpoint = {
    $onClickHandler = {
        Set-UDElement -Id "target" -Content { New-Guid }
    }

    New-UDElement -Tag "a" -Attributes @{ className = "btn"; onClick = $onClickHandler } -Content { "Update the GUID" }
    New-UDElement -Tag "p" -Id "target" -Attributes @{ className = "white-text" }
}

$AddChildElements = {
    $onClickHandler = {
        Add-UDElement -ParentId "addChildElement" -Content {
            New-UDElement -Tag "p" -Content {
                "Add new element at $(Get-Date)"
            }
        }
    }

    New-UDElement -Tag "a" -Attributes @{ className = "btn"; onClick = $onClickHandler } -Content { "Add child element" }
    New-UDElement -Tag "p" -Id "addChildElement" -Attributes @{ className = "white-text" }
}

$RemoveAnElement = {
    $onClickHandler = {
        Remove-UDElement -Id "removeMe"
    }

    New-UDElement -Tag "a" -Attributes @{ className = "btn"; onClick = $onClickHandler } -Content { "Remove text" }
    New-UDElement -Tag "p" -Id "removeMe" -Attributes @{ className = "white-text" } -Content { "Remove me"}
}

$ClearChildren = {
    $onClickHandler = {
        Clear-UDElement -Id "clearMe"
    }

    New-UDElement -Tag "a" -Attributes @{ className = "btn"; onClick = $onClickHandler } -Content { "Clear Children" }
    New-UDElement -Tag "div" -Id "clearMe" -Attributes @{ className = "card black-text" } -Endpoint {
        New-UDElement -Tag "p" -Content { "Child1" }
        New-UDElement -Tag "p" -Content { "Child2" }
        New-UDElement -Tag "p" -Content { "Child3" }
    }
}

New-UDPage -Name "Elements" -Icon cubes -Content {
    New-UDPageHeader -Title "Elements" -Icon "cubes" -Description "Create custom elements using PowerShell script to create any type of HTML node. Take advantage of websockets to create real-time applications." -DocLink "https://docs.universaldashboard.io/components/custom-components/powershell-elements"
    New-UDExample -Title "Simple Elements" -Description "Simple HTML element." -Script $CustomElement
    New-UDExample -Title "Nested Elements" -Description "Elements can be nested within each other." -Script $NestedElements
    New-UDExample -Title "Attributes" -Description "Set attributes on the HTML tag." -Script $Attributes
    New-UDExample -Title "Endpoints" -Description "Load the content of an element from an PowerShell endpoint." -Script $LoadContentFromAnEndpoint
    New-UDExample -Title "Update Element Content" -Description "Sets the content of a element from an endpoint." -Script $SetContentFromAnEndpoint
    New-UDExample -Title "Add child element" -Description "Add child elements to a parent element from within an endpoint." -Script $AddChildElements
    New-UDExample -Title "Remove element" -Description "Remove an element from within an endpoint." -Script $RemoveAnElement
    New-UDExample -Title "Clear children" -Description "Clear children of an element from within an endpoint." -Script $ClearChildren
}