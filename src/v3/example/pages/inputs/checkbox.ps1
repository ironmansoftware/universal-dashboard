New-ComponentPage -Title 'Checkbox' -Description 'Checkboxes allow the user to select one or more items from a set.' -SecondDescription "Checkboxes can be used to turn an option on or off.

If you have multiple options appearing in a list, you can preserve space by using checkboxes instead of on/off switches. If you have a single option, avoid using a checkbox and use an on/off switch instead." -Content {
    New-Example -Title 'Checkboxes' -Description "Checkboxes can be disabled and checked by default" -Example {
New-UDCheckBox

New-UDCheckBox -Disabled

New-UDCheckBox -Checked $true

New-UDCheckBox -Checked $true -Disabled
    }

    New-Example -Title 'Checkboxes with custom icon' -Description "Create checkboxes that use any icon and style." -Example {
$Icon = New-UDIcon -Icon angry -Size lg -Regular
$CheckedIcon = New-UDIcon -Icon angry -Size lg
New-UDCheckBox -Icon $Icon -CheckedIcon $CheckedIcon -Style @{color = '#2196f3'}
    }

    New-Example -Title 'Checkboxes with onChange script block' -Description "Create checkboxes that fire script blocks when changed." -Example {
New-UDCheckBox -OnChange {
    Show-UDToast -Title 'Checkbox' -Message $Body
}    
    }

    New-Example -Title 'Checkbox with custom label placement' -Description "You can adjust where the label for the checkbox is placed." -Example {
New-UDCheckBox -Label 'Demo' -LabelPlacement start
New-UDCheckBox -Label 'Demo' -LabelPlacement top
New-UDCheckBox -Label 'Demo' -LabelPlacement bottom
New-UDCheckBox -Label 'Demo' -LabelPlacement end
    }
} -Cmdlet "New-UDCheckbox"