New-ComponentPage -Title 'Tree View' -Description 'A tree view widget presents a hierarchical list.' -SecondDescription "Tree views can be used to represent a file system navigator displaying folders and files, an item representing a folder can be expanded to reveal the contents of the folder, which may be files, folders, or both." -Content {
    New-Example -Title 'Tree view' -Description '' -Example {
        New-UDTreeView -Node {
            New-UDTreeNode -Id 'Root' -Name 'Root' -Children {
                New-UDTreeNode -Id 'Level1' -Name 'Level 1' -Children {
                    New-UDTreeNode -Id 'Level2' -Name 'Level 2'
                }
                New-UDTreeNode -Name 'Level 1' -Children {
                    New-UDTreeNode -Name 'Level 2'
                }
                New-UDTreeNode -Name 'Level 1' -Children {
                    New-UDTreeNode -Name 'Level 2'
                }   
            }
            New-UDTreeNode -Id 'Root2' -Name 'Root 2'
        }
    }
} -Cmdlet @("New-UDTreeView", "New-UDTreeNode")
