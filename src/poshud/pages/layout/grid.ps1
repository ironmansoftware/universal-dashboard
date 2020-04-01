New-ComponentPage -Title 'Grid' -Description 'The responsive layout grid adapts to screen size and orientation, ensuring consistency across layouts.' -SecondDescription "The grid creates visual consistency between layouts while allowing flexibility across a wide variety of designs. Material Design’s responsive UI is based on a 12-column grid layout." -Content {

    New-Example -Title 'Basic grid' -Description "The column widths apply at all breakpoints (i.e. xs and up)." -Example {
New-UDGrid -Container -Content {
    New-UDGrid -Item -ExtraSmallSize 12 -Content {
        New-UDPaper -Content { "xs-12" } -Elevation 2
    }
    New-UDGrid -Item -ExtraSmallSize 6 -Content {
        New-UDPaper -Content { "xs-6" } -Elevation 2
    }
    New-UDGrid -Item -ExtraSmallSize 6 -Content {
        New-UDPaper -Content { "xs-6" } -Elevation 2
    }
    New-UDGrid -Item -ExtraSmallSize 3 -Content {
        New-UDPaper -Content { "xs-3" } -Elevation 2
    }
    New-UDGrid -Item -ExtraSmallSize 3 -Content {
        New-UDPaper -Content { "xs-3" } -Elevation 2
    }
    New-UDGrid -Item -ExtraSmallSize 3 -Content {
        New-UDPaper -Content { "xs-3" } -Elevation 2
    }
    New-UDGrid -Item -ExtraSmallSize 3 -Content {
        New-UDPaper -Content { "xs-3" } -Elevation 2
    }
}
    }

    New-Example -Title 'Spacing' -Description "Adjust the spacing between items in the grid" -Example {

New-UDDynamic -Id 'spacingGrid' -Content {
    $Spacing = (Get-UDElement -Id 'spacingSelect').value

    New-UDGrid -Spacing $Spacing -Container -Content {
        New-UDGrid -Item -ExtraSmallSize 3 -Content {
            New-UDPaper -Content { "xs-3" } -Elevation 2
        }
        New-UDGrid -Item -ExtraSmallSize 3 -Content {
            New-UDPaper -Content { "xs-3" } -Elevation 2
        }
        New-UDGrid -Item -ExtraSmallSize 3 -Content {
            New-UDPaper -Content { "xs-3" } -Elevation 2
        }
        New-UDGrid -Item -ExtraSmallSize 3 -Content {
            New-UDPaper -Content { "xs-3" } -Elevation 2
        }
    }
}

New-UDSelect -Id 'spacingSelect' -Label Spacing -Option {
    0..10 | ForEach-Object { New-UDSelectOption -Name $_ -Value $_ }
} -OnChange { Sync-UDElement -Id 'spacingGrid' } -DefaultValue 3

    }
} -Cmdlet "New-UDGrid"