function New-UDCollection {
    param(
        [Parameter()]
        [String]$Id = (New-Guid),
        [Parameter()]
        [ScriptBlock]$Content,
        [Parameter()]
        [Switch]$LinkCollection,
        [Parameter()]
        [string]$Header
    )

    $collectionClass = "collection"
    if ($PSBoundParameters.ContainsKey("Header")) {
        $collectionClass += " with-header"
    }

    if ($LinkCollection) {
        New-UDElement -Tag "div" -Attributes @{
            className = $collectionClass
        } -Content $Content
    }
    else {
        New-UDElement -Tag "ul" -Attributes @{
            className = $collectionClass
        } -Content {
            if ($PSBoundParameters.ContainsKey("Header")) {
                New-UDElement -Tag 'li' -Attributes @{
                    className = 'collection-header'
                } -Content {
                    New-UDHeading -Size 4 -Text $Header
                }
            }

            $Content.Invoke()
        }
    }


}

function New-UDCollectionItem {
    [CmdletBinding(DefaultParameterSetName = 'content')]
    param(
        [Parameter()]
        [String]$Id = (New-Guid),
        [Parameter()]
        [ScriptBlock]$Content,
        [Parameter(ParameterSetName = 'content')]
        [ScriptBlock]$SecondaryContent,
        [Parameter(ParameterSetName = 'link')]
        [String]$Url,
        [Switch]$Active
    )

    $className = "collection-item"
    if ($Active) {
        $className += " active"
    }

    if ($PSCmdlet.ParameterSetName -eq 'link') {
        New-UDElement -Tag "a" -Attributes @{
            href = $Url
            className = $className
        } -Content $Content
    } else {
        New-UDElement -Tag "li" -Attributes @{
            className = $className
        } -Content {
            if ($SecondaryContent -ne $null) {
                New-UDElement -Tag 'div' -Content {
                    $Content.Invoke()
                    New-UDElement -Tag 'span' -Attributes @{ className = 'secondary-content' } -Content $SecondaryContent
                }
            }
            else {
                $Content.Invoke()
            }
           
        }
    }
}
