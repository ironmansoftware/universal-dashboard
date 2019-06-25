New-UDPage -Name "REST-APIs" -Endpoint {

    $OnlineVersion = 'https://github.com/ironmansoftware/universal-dashboard/blob/master/src/poshud/pages/rest-apis.ps1'

    New-UDElement -Tag div -Attributes @{ style = @{ paddingLeft = "20px" }} -Content {
        New-UDRow -Columns {
            New-UDColumn -Size 12 -Content {
                New-UDHeading -Size 3 -Text "REST APIs"
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
                New-UDHeading -Size 5 -Text "You can define REST APIs to allow herrogenous systems to interact with PowerShell over HTTP."
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
                New-UDRestApiExample -Name "Return Data" -Description "Creates a basic GET endpoint that returns data." -Code "New-UDEndpoint -Url '/data' -Endpoint { 'Hello, World!' } " -Invocation "Invoke-RestMethod http://localhost:10001/api/data"
            }
        }

        New-UDRow -Columns {
            New-UDColumn -Size 12 -Content {
                New-UDRestApiExample -Name "Filter Data" -Description "Filter data using route variables." -Code "New-UDEndpoint -Url '/data/:filter' -Endpoint { param(`$filter) @(1,2,3) | Where-Object { `$_ -eq `$filter } } " -Invocation "Invoke-RestMethod http://localhost:10001/api/data/1"
            }
        }

        New-UDRow -Columns {
            New-UDColumn -Size 12 -Content {
                New-UDRestApiExample -Name "Filter Data with query string parameters" -Description "Filter data using query string parameters." -Code "New-UDEndpoint -Url '/queryData' -Endpoint { param(`$filter) @(1,2,3) | Where-Object { `$_ -eq `$filter } } " -Invocation "Invoke-RestMethod http://localhost:10001/api/queryData?filter=1"
            }
        }


        New-UDRow -Columns {
            New-UDColumn -Size 12 -Content {
                New-UDRestApiExample -Name "Send Data to the Server" -Description "Sends data to the server via the body" -Code "New-UDEndpoint -Method POST -Url '/data' -Endpoint { param(`$Body) `$Body } " -Invocation "Invoke-RestMethod http://localhost:10001/api/data -Method POST -Body 'Echo'"
            }
        }

        New-UDRow -Columns {
            New-UDColumn -Size 12 -Content {
                New-UDRestApiExample -Name "Send Data via route variables" -Description "Uses route variables to send data to the endpoint on the server" -Code "New-UDEndpoint -Method POST -Url '/data/:variable' -Endpoint { param(`$variable) `$variable } " -Invocation "Invoke-RestMethod http://localhost:10001/api/data/echo -Method POST"
            }
        }
    }
}