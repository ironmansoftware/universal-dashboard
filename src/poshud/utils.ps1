function New-UDComponentPage {
    param(
        $Command
    )

    New-UDPage -Name $Command -Content {

        $Help = Get-Help $Command -Full
        $OnlineVersion = $Help.relatedLinks.navigationLink | Where-Object linkText -eq 'Online Version:' | Select-Object -ExpandProperty uri

        New-UDElement -Tag div -Attributes @{ style = @{ paddingLeft = "20px" }} -Content {
            New-UDRow -Columns {
                New-UDColumn -Size 12 -Content {
                    New-UDHeading -Size 3 -Text $Command
                }
            }

            New-UDRow -Columns {
                New-UDButton -Icon github -Text "Edit on GitHub" -OnClick (
                    New-UDEndpoint -Endpoint {
                        Invoke-UDRedirect -Url $ArgumentList[0] -OpenInNewWindow 
                    } -ArgumentList $OnlineVersion
                ) -BackgroundColor 'white' -FontColor 'black'
            }
    
            New-UDRow -Columns {
                New-UDColumn -Size 12 -Content {
                    New-UDHeading -Size 5 -Text $Help.Description.Text
                }
            }

            New-UDElement -tag 'hr'

            New-UDRow -Columns {
                New-UDColumn -Size 12 -Content {
                    New-UDHeading -Size 4 -Text "Examples"
                }
            }

            $Help.Examples.Example | ForEach-Object {
                New-UDRow -Columns {
                    New-UDColumn -Size 12 -Content {
                        New-UDComponentExample -Name $_.title.replace('-', '') -Description $_.remarks.text -Code $_.code
                    }
                }
            }

            New-UDRow -Columns {
                New-UDColumn -Size 12 -Content {
                    New-UDHeading -Size 4 -Text "API"
                }
            }

            New-UDTable -Title "API" -Headers @("Name", "Description", "Type", "Position", "Pipeline Input", "Mandatory")  -Content {
                $Help.Parameters.parameter | ForEach-Object {
                    [PSCustomObject]@{
                        name = $_.Name 
                        description = $_.Description[0].text
                        type = $_.Type.name 
                        position = $_.position
                        pipelineInput = if ($_.pipelineInput -eq 'false') { New-UDIcon -Icon times } else { New-UDIcon -Icon check }
                        mandatory = if ($_.required -eq 'false') { New-UDIcon -Icon times } else { New-UDIcon -Icon check }
                    }
                } | Out-UDTableData -Property @("name", "description", "type", "position", "pipelineInput", "mandatory")
            } 
        }
    }
}

function New-UDComponentExample {
    param(
        $Name,
        $Description,
        $Code
    )

    New-UDHeading -Size 4 -Text $Name 
    New-UDHeading -Size 5 -Text $Description 

    New-UDTabContainer -Tabs {
        New-UDTab -Text "Example" -Content {
            New-UDElement -Tag 'div' -Attributes @{
                style = @{
                    padding = '30px'
                    textAlign = 'center'
                    background = '#f8f8f8'
                }
            } -Content {
                Invoke-Expression $Code
            }
        }
        New-UDTab -Text "Code" -Content {
            New-UDElement -Tag 'div' -Attributes @{
                style = @{
                    padding = '10px'
                    background = '#f8f8f8'
                }
            } -Content {
                New-UDElement -tag pre -Content {
                    $Code
                }
            }            
        }
    }

    New-UDElement -tag 'hr'
}

function New-UDRestApiExample {
    param(
        $Name,
        $Description,
        $Code,
        $Invocation
    )

    New-UDHeading -Size 4 -Text $Name 
    New-UDHeading -Size 5 -Text $Description 

    New-UDTabContainer -Tabs {
        New-UDTab -Text "Code" -Content {
            New-UDElement -Tag 'div' -Attributes @{
                style = @{
                    padding = '30px'
                    background = '#f8f8f8'
                }
            } -Content {
                New-UDElement -tag pre -Content {
                    $Code
                    Invoke-Expression $Code | Out-Null
                }
            }
        }
        New-UDTab -Text "Try It" -Content {
            New-UDElement -Tag 'div' -Attributes @{
                style = @{
                    padding = '30px'
                    background = '#f8f8f8'
                }
            } -Content {
                New-UDElement -tag pre -Content {
                    $Invocation
                }
            }            
        }
    }

    New-UDElement -tag 'hr'
}


function New-UDRawExample {
    param(
        $Name,
        $Description,
        $Code
    )

    New-UDHeading -Size 4 -Text $Name 
    New-UDHeading -Size 5 -Text $Description 

    New-UDTabContainer -Tabs {
        New-UDTab -Text "Code" -Content {
            New-UDElement -Tag 'div' -Attributes @{
                style = @{
                    padding = '30px'
                    background = '#f8f8f8'
                }
            } -Content {
                New-UDElement -tag pre -Content {
                    $Code
                    Invoke-Expression $Code | Out-Null
                }
            }
        }
    }

    New-UDElement -tag 'hr'
}