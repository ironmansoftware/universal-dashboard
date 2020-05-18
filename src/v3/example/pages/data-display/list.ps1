New-ComponentPage -Title 'List' -Description 'Lists are continuous, vertical indexes of text or images.' -SecondDescription "Lists are a continuous group of text or images. They are composed of items containing primary and supplemental actions, which are represented by icons and text." -Content {
    New-Example -Title 'List' -Description '' -Example {
New-UDList -Content {
    New-UDListItem -Label 'Inbox' -Icon (New-UDIcon -Icon envelope -Size 3x) -SubTitle 'New Stuff'
    New-UDListItem -Label 'Drafts' -Icon (New-UDIcon -Icon edit -Size 3x) -SubTitle "Stuff I'm working on "
    New-UDListItem -Label 'Trash' -Icon (New-UDIcon -Icon trash -Size 3x) -SubTitle 'Stuff I deleted'
    New-UDListItem -Label 'Spam' -Icon (New-UDIcon -Icon bug -Size 3x) -SubTitle "Stuff I didn't want"
}
    }
} -Cmdlet @("New-UDList", "New-UDListItem")