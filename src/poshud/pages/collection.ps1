
New-UDPage -Name "Collection" -Icon list -Content {
    New-UDRow -Columns {
        New-UDColumn -Size 2 -Content {}
        New-UDColumn -Size 10 -Content {
            New-UDHeading -Size 1 -Text "Collections"  -Color $Colors.FontColor

            New-UDParagraph -Content {
                "Collections allow you to group list objects together."
            } -Color $Colors.FontColor
            
            New-UDHeading -Size 3 -Text "Basic"  -Color $Colors.FontColor

            New-UDElementExample -Example {
                New-UDCollection -Content {
                    New-UDCollectionItem -Content { "Alvin" }
                    New-UDCollectionItem -Content { "Alvin" }
                    New-UDCollectionItem -Content { "Alvin" }
                    New-UDCollectionItem -Content { "Alvin" }
                }
            }
            
            New-UDHeading -Size 3 -Text "Links"  -Color $Colors.FontColor
            
            New-UDElementExample -Example {
                New-UDCollection -LinkCollection -Content {
                    New-UDCollectionItem -Content { "Alvin" } -Url "#!"
                    New-UDCollectionItem -Content { "Alvin" } -Url "#!" -Active
                    New-UDCollectionItem -Content { "Alvin" } -Url "#!"
                    New-UDCollectionItem -Content { "Alvin" } -Url "#!"
                }
            }

            New-UDHeading -Size 3 -Text "Headers"  -Color $Colors.FontColor

            New-UDElementExample -Example {
                New-UDCollection -Content {
                    New-UDCollectionItem -Content { "Alvin" }
                    New-UDCollectionItem -Content { "Alvin" }
                    New-UDCollectionItem -Content { "Alvin" }
                    New-UDCollectionItem -Content { "Alvin" }
                } -Header "First Names"
            }
            
            New-UDHeading -Size 3 -Text "Secondary Content"  -Color $Colors.FontColor

            New-UDElementExample -Example {
                New-UDCollection -Content {
                    New-UDCollectionItem -Content { "Alvin" } -SecondaryContent { New-UDIcon -Icon paper_plane }
                    New-UDCollectionItem -Content { "Alvin" } -SecondaryContent { New-UDIcon -Icon paper_plane }
                    New-UDCollectionItem -Content { "Alvin" } -SecondaryContent { New-UDIcon -Icon paper_plane }
                    New-UDCollectionItem -Content { "Alvin" } -SecondaryContent { New-UDIcon -Icon paper_plane }
                } 
            }
        }
    }
}
