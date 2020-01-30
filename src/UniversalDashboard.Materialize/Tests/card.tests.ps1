﻿Describe "Card" {
    Context "Simple Card" {
        Set-TestDashboard -Content {
            New-UDCard -Title "Test" -Text "My text" -Id "Card" -Links @(
                New-UDLink -Text "My Link" -Url "http://www.google.com"
            )

            New-UDCard -Title "ÆØÅ" -Text "Test" -Id "nordic"

            New-UDCard -Title "Test" -Id "EndpointCard" -Endpoint {
                New-UDElement -Tag "div" -Content { "Endpoint Content" } 
            }

            New-UDCard -Title "Test" -Id "NoTextCard"

            New-UDCard -Title "Test" -Text "My text`r`nNew Line" -Id "MultiLineCard"

            New-UDCard -Title "Test" -Text "Small Text" -Id "Card-Small-Text" -TextSize Small

            New-UDCard -Title "Test" -Text "Medium Text" -Id "Card-Medium-Text" -TextSize Medium

            New-UDCard -Title "Test" -Text "Large Text" -Id "Card-Large-Text" -TextSize Large

            New-UDCard -Title "Test" -Content {
                New-UDElement -Tag "span" -Attributes @{id = "spanTest"} -Content {
                    "This is some custom content"
                }
            }

            New-UDCard -Title "Test" -Text "Text" -Id "Card-Watermark" -Watermark address_book
        }
        
        It "should have title text" {
            $Element = Find-SeElement -Id "Card" -Driver $Driver
            $Element.Text.Split("`r`n")[0] | should be "Test"
        }

        It "should have link" {
            Find-SeElement -LinkText "MY LINK" -Driver $Driver | Should not be $null
        }

        It "should show nordic chars correctly" {
            $Element = Find-SeElement -Id "nordic" -Driver $Driver
            $Element.Text.Split("`r`n")[0] | should be "ÆØÅ"
        }

        It "should load content from endpoint" {
            $Element = Find-SeElement -Id "EndpointCard" -Driver $Driver
            Start-Sleep 1
            ($Element.Text).Contains("Endpoint Content") | should be $true
        }

        It "should have title text" {
            $Element = Find-SeElement -Id "NoTextCard" -Driver $Driver
            $Element.Text | should be "Test"
        }

        It "should support new line in card" {
            $Element = Find-SeElement -Id "MultiLineCard" -Driver $Driver 
            $Br = Find-SeElement -Tag "br" -Element $Element -By TagName
            $Br | should not be $null
        }

        It "should have text of Small Text" {
            $Element = Find-SeElement -Id "Card-Small-Text" -Driver $Driver
            ($Element.Text -split "`r`n")[1] | should be 'Small Text'
        }

        $Element = Find-SeElement -Id "Card-Medium-Text" -Driver $Driver
        $CardContent = Find-SeElement -Element $Element -TagName 'h5'

        It "should have html H5 tag" {
            $CardContent.TagName | should be 'h5'
        }

        It "should have text of Medium Text" {
            $CardContent.Text | should be 'Medium Text'
        }

        $Element = Find-SeElement -Id "Card-Large-Text" -Driver $Driver
        $CardContent = Find-SeElement -Element $Element -TagName 'h3'

        It "should have html H3 tag" {
            $CardContent.TagName | should be 'h3'
        }

        It "should have text of Large Text" {
            $CardContent.Text | should be 'Large Text'
        }

        It "should have custom content" {
            $Element = Find-SeElement -Id "spanTest" -Driver $Driver
            $Element.Text | should be "This is some custom content"
        }

        It "should have watermark" {
            Find-SeElement -ClassName "fa-address-book" -Driver $Driver | Should not be $null
        }
    }
}