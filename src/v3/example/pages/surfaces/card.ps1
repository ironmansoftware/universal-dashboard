New-ComponentPage -Title 'Card' -Description 'Cards contain content and actions about a single subject.' -SecondDescription "Cards are surfaces that display content and actions on a single topic.

They should be easy to scan for relevant and actionable information. Elements, like text and images, should be placed on them in a way that clearly indicates hierarchy." -Content {
    New-Example -Title 'Simple Card' -Description 'Although cards can support multiple actions, UI controls, and an overflow menu, use restraint and remember that cards are entry points to more complex and detailed information.' -Example {
New-UDCard -Title 'Simple Card' -Content {
    "This is some content"
} 
    }
} -Cmdlet "New-UDCard"