New-UDDashboard -Title "Dashboard" -Pages @(
    New-UDPage -Name "Button" -Content {

        New-UDButton -Text 'Submit' -Id 'btnDefault' 

        New-UDButton -Text 'Submit' -Id 'btnFullWidth' -FullWidth

        New-UDButton -Text 'Submit' -Id 'btnText' -variant text

        New-UDButton -Text 'Submit' -Id 'btnLabel'

        New-UDButton -Text 'Submit' -Id 'btnOutlined' -variant outlined

        New-UDButton -Text 'Submit' -Id 'btnSmall' -size small

        New-UDButton -Text 'Submit' -Id 'btnMedium' -size medium

        New-UDButton -Text 'Submit' -Id 'btnLarge' -size large

        $Icon = New-UDIcon -Icon 'github'
        New-UDButton -Text "Submit" -Id "btnIcon" -Icon $Icon -OnClick {Show-UDToast -Message 'test'}  

        $Icon = New-UDIcon -Icon 'github'
        New-UDButton -Text "Submit" -Id "btnClick" -Icon $Icon -OnClick {
            Set-TestData -Data "OnClick"
        }
    }

    New-UDPage -Name "Preloader" -Content {
        New-UDProgress -Circular 
    }
)
