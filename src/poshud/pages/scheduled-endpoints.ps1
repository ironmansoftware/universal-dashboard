New-UDPage -Name "Scheduled-Endpoints" -Endpoint {

    $OnlineVersion = 'https://github.com/ironmansoftware/universal-dashboard/blob/master/src/poshud/pages/scheduled-endpoints.ps1'

    New-UDElement -Tag div -Attributes @{ style = @{ paddingLeft = "20px" }} -Content {
        New-UDRow -Columns {
            New-UDColumn -Size 12 -Content {
                New-UDHeading -Size 3 -Text "Scheduled Endpoints"
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
                New-UDHeading -Size 5 -Text "Scheduled endpoints allow you to schedule actions to be taken on an interval. This is similar to a task scheduler but can interact with features of Universal Dashboard."
            }
        }

        New-UDElement -tag 'hr'

        New-UDRow -Columns {
            New-UDColumn -Size 12 -Content {
                New-UDHeading -Size 4 -Text "Examples"
            }
        }

        New-UDRow -Columns {
            New-UDColumn -Size 12 -Content {
                New-UDRawExample -Title 'Scheduled every 10 minutes' -Description "Runs the scheduled endpoint every ten minutes." -Code "New-UDEndpoint -Schedule (New-UDEndpointSchedule -Every 10 -Minute) -Endpoint { `$Cache:Processes = Get-Process }" 
            }
        }
    }
}