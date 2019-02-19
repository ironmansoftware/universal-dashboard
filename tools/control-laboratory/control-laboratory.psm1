function New-ControlLibrary {
    param($PSModuleInfo)

    $Commands = $PSModuleInfo.ExportedCommands

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
                                    if ($null -ne $parameter.Value) {
                                        $value = $parameter.Value 

                                        if ($Value.Contains(",")) {
                                            $value = $Value.Split(",")
                                        }

                                        $arguments[$parameter.Key] = $Value
                                    }
                                }
                                
                                Clear-UDElement -Id "Container"
                                Add-UDElement -ParentId "Container" -Content {
                                    New-UDTabContainer -Tabs {
                                        New-UDTab -Text "View" -Content {
                                            . $ArgumentList[0] @arguments
                                        }
                                        New-UDTab -Text "Code" -Content {
                                            "$($ArgumentList[0]) @arguments"
                                        }
                                    }
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
}


function Show-ControlProperties {
    param(
        $ControlName 
    )

    $CommandInfo = Get-Command $ControlName

    Show-UDModal -Content {
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
                        
                        Clear-UDElement -Id "Container"
                        Add-UDElement -ParentId "Container" -Content {
                            New-UDTabContainer -Tabs {
                                New-UDTab -Text "View" -Content {
                                    . $ArgumentList[0] @arguments
                                }
                                New-UDTab -Text "Code" -Content {
                                    New-UDElement -Tag "pre" -Content {

                                        $argumentString = ""
                                        foreach($arg in $arguments.GetEnumerator()) {
                                            $argumentString += " -$($arg.Key) `"$($arg.Value)`""
                                        }

                                        "$($ArgumentList[0])$argumentString"
                                    }
                                }
                            }
                        }

                    } -ArgumentList @($ControlName, $parameterSet.Name)
                }
            }
        }
    }
}
