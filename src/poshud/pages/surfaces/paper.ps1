New-ComponentPage -Title 'Paper' -Description 'In Material Design, the physical properties of paper are translated to the screen.' -SecondDescription "The background of an application resembles the flat, opaque texture of a sheet of paper, and an application’s behavior mimics paper’s ability to be re-sized, shuffled, and bound together in multiple sheets." -Content {
    New-Example -Title 'Paper' -Description '' -Example {
New-UDPaper -Elevation 0 -Content {} 
New-UDPaper -Elevation 1 -Content {} 
New-UDPaper -Elevation 3 -Content {} 
    }
} -Cmdlet "New-UDPaper"