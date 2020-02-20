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

    New-UDPage -Name 'Checkbox' -Content {
        New-UDCheckBox -Label 'Demo' -Id 'chkLabel' -OnChange {}

        New-UDCheckBox -Label 'Demo' -Id 'chkLabelPlacementStart' -OnChange {} -LabelPlacement start

        New-UDCheckBox -Label 'Demo' -Id 'chkLabelPlacementTop' -OnChange {} -LabelPlacement top
        
        New-UDCheckBox -Label 'Demo' -Id 'chkLabelPlacementBottom' -OnChange {} -LabelPlacement bottom

        New-UDCheckBox -Label 'Demo' -Id 'chkLabelPlacementEnd' -OnChange {} -LabelPlacement end

        $Icon = New-UDIcon -Icon angry -Size lg  -Id 'demo-checkbox-icon' -Regular
        $CheckedIcon = New-UDIcon -Icon angry -Size lg  -Id 'demo-checkbox-icon-checked' 
        New-UDCheckBox -Id 'btnCustomIcon' -Icon $Icon -CheckedIcon $CheckedIcon -OnChange {} -Style @{color = '#2196f3'}

        New-UDCheckBox -Id 'chkChange' -OnChange {
            Set-TestData -Data "OnChange"
        }

        New-UDCheckBox -Id 'chkStyle' -Style @{color = 'pink'} -Label "I'm in love"

        New-UDCheckBox -Id 'chkDisabled' -Disabled

        New-UDCheckBox -Id 'chkChecked' -Checked

        New-UDCheckBox -Id 'chkCheckedDisabled' -Checked -Disabled
    }

    New-UDPage -Name 'Expansion Panel' -Content {
        New-UDExpansionPanelGroup -Items {
            New-UDExpansionPanel -Title "Hello" -Id 'expTitle' -Content {}

            New-UDExpansionPanel -Title "Hello" -Id 'expContent' -Content {
                New-UDElement -Tag 'div' -id 'expContentDiv' -Content { "Hello" }
            }

            New-UDExpansionPanel -Title "Hello" -Id 'expEndpoint' -Endpoint {
                New-UDElement -Tag 'div' -id 'expEndpointDiv' -Content { "Hello" }
            }
        }
    }

    New-UDPage -Name 'Floating Action Button' -Content {
        New-UDFloatingActionButton -Id 'fabIcon' -Icon user 

        New-UDFloatingActionButton -Id 'fabClick' -Icon user -OnClick {
            Set-TestData -Data "fabClick"
        }

        New-UDFloatingActionButton -Id 'fabSmall' -Icon user -Size small 

        New-UDFloatingActionButton -Id 'fabMedium' -Icon user -Size medium

        New-UDFloatingActionButton -Id 'fabLarge' -Icon user -Size large
    }


    New-UDPage -Name "Preloader" -Content {
        New-UDProgress -Circular 
    }

    New-UDPage -Name "Tabs" -Content {
        New-UDTabs -Tabs {
            New-UDTab -Text "Tab1" -Content {
                New-UDElement -Tag div -Id 'tab1Content' -Content { "Tab1Content"}
            }
            New-UDTab -Text "Tab2" -Content {
                New-UDElement -Tag div -Id 'tab2Content' -Content { "Tab2Content"}
            }
            New-UDTab -Text "Tab3" -Content {
                New-UDElement -Tag div -Id 'tab3Content' -Content { "Tab3Content"}
            }
        }
    }
)
