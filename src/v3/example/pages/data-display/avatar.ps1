New-ComponentPage -Title 'Avatar' `
-Description 'Avatars are found throughout material design with uses in everything from tables to dialog menus.' `
-SecondDescription "" -Content {

New-Example -Title 'Avatar' -Example {
    New-UDAvatar -Image 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4' -Alt 'alon gvili avatar' -Id 'avatarContent' -Variant small

    New-UDAvatar -Image 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4' -Alt 'alon gvili avatar' -Id 'avatarStyle' -Variant medium

    $AvatarProps = @{
        Image = 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4'
        Alt = 'alon gvili avatar'
        Id = 'avatarSquare'
        variant = 'large'
    }
    New-UDAvatar @AvatarProps 
}
} -Cmdlet 'New-UDAvatar'