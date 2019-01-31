Import-Module F:\universal-dashboard\src\output\UniversalDashboard.Community.psd1

$Dashboard = New-UDDashboard -Title "Control Labratory" -Content {
    New-UDRow -Columns {
        New-UDColumn -Size 3 -Content {
            New-UDButton -Text "Load Control Library" -OnClick {
                Show-UDMOdal -Content {
                    New-UDInput -Title "Load Control Library"  -SubmitText "Import" -Endpoint {
                        param(
                            $controlLibrary
                        )

                        $ControlLibrary = Import-Module $controlLibrary -Force -PassThru
                        $Commands = $controlLibrary.ExportedCommands

                        Clear-UDElement -Id "controls"

                        $Collapsible = New-UDCollapsible -Items {
                            foreach($Command in $Commands.GetEnumerator()) {
                                New-UDCollapsibleItem -Title $Command.Key -Content {

                                    $CommandInfo = Get-Command $Command.Key

                                    New-UDTabContainer -Tabs {
                                        foreach($parameterSet in $CommandInfo.ParameterSets.GetEnumerator()) {
                                            New-UDTab -Text $parameterSet.Name -Content {
                                                New-UDInput -Title "Create Control" -Content {
                                                    $CommonParameters = @("Verbose", "Debug", "ErrorAction", "WarningAction", "InformationAction", "ErrorVariable", "WarningVariable", "InformationVariable", "OutVariable", "OutBuffer", "PipelineVariable")
                                                    foreach($parameter in $parameterSet.Parameters) {
                                                        if ($CommonParameters -contains $parameter.Name) {
                                                            continue
                                                        }

                                                        New-UDInputField -Name $parameter.Name -Type textbox
                                                    }
                                                } -Endpoint {
                                                    

                                                    $arguments = @{}

                                                    foreach($parameter in $PSBoundParameters.GetEnumerator()) {
                                                        if ($parameter.Value -ne $null) {
                                                            $value = $parameter.Value 

                                                            if ($Value.Contains(",")) {
                                                                $value = $Value.Split(",")
                                                            }

                                                            $arguments[$parameter.Key] = $Value
                                                        }
                                                    }
                                                    
                                                    Show-UDToast -Message $PSBoundParameters.Count

                                                    Clear-UDElement -Id "Container"
                                                    Add-UDElement -ParentId "Container" -Content {
                                                        . $ArgumentList[0] @arguments
                                                    }

                                                } -ArgumentList @($Command.Key, $parameterSet.Name)
                                            }
                                        }
                                    }

                                    
                                }
                            }
                        }

                        Add-UDElement -ParentId "controls" -Content {
                            $Collapsible
                        }

                    } -Content {
                        New-UDInputField -Name "controlLibrary" -Type textbox
                    }
                }
            }
            New-UDElement -Tag "div" -Id "controls" -Content {}
        }

        New-UDColumn -Size 9 -Content {
            New-UDElement -Tag "div" -Id "Container" -Content {}
        }
    }
}

Start-UDDashboard -Dashboard $Dashboard -Port 1234