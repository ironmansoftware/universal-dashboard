New-ComponentPage -Title 'Icons' -Description 'FontAwesome icons to include in your dashboard.' -SecondDescription "" -Content {

    New-UDTextbox -Id 'txtIconSearch' -Label 'Search' 
    New-UDButton -Text 'Search' -OnClick {
        Sync-UDElement -Id 'icons'
    }

    New-UDElement -tag 'p' -Content {}

    New-UDDynamic -Id 'icons' -Content {
        $Icons = [Enum]::GetNames([UniversalDashboard.Models.FontAwesomeIcons])
        $IconSearch = (Get-UDElement -Id 'txtIconSearch').value
        if ($null -ne $IconSearch -and $IconSearch -ne '')
        {
            $Icons = $Icons.where({ $_ -match $IconSearch})
        }

        foreach($icon in $icons) {
            New-UDIcon -Icon $icon -Size lg
        }
    }
} -Cmdlet "New-UDIcon"