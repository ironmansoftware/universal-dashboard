param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release

Import-Module $ModulePath -Force

Get-UDRestApi | Stop-UDRestApi
Get-UDDashboard | Stop-UDDashboard
Describe "Api" {
    Context "Special Characters" {
        $Server = Start-UDRestApi -Port 10001 -Endpoint @(
            New-UDEndpoint -Url "/recherches" -Method "GET" -Endpoint {
                'éèù' | ConvertTo-Json
            }
        ) 

        It "doesn't mess up the characters" {
            (Invoke-RestMethod http://localhost:10001/api/recherches) | Should be "éèù"
        }

        Stop-UDRestApi $Server
    }

    Context "Performance" {
        $Server = Start-UDRestApi -Port 10001 -Endpoint @(
            New-UDEndpoint -Url "user" -Method "GET" -Endpoint {
                @("Adam", "Bill", "Frank") | ConvertTo-Json
            }
        ) 

        It "Is fast" {
            (Measure-Command -Expression { 
                1..100 | % { Invoke-RestMethod http://localhost:10001/api/user  }
            }).TotalSeconds | Should BeLessThan 15
        }

        Stop-UDRestApi $Server
    }

    Context "Components" {

        $Variable = @("Some text")
        
        $Init = New-UDEndpointInitialization -Variable "Variable"

        $Server = Start-UDRestApi -Port 10001 -Endpoint @(
            New-UDEndpoint -Url "user" -Method "GET" -Endpoint {
                @("Adam", "Bill", "Frank") | ConvertTo-Json
            }
            New-UDEndpoint -Url "user/me" -Method "GET" -Endpoint {
                @($User) | ConvertTo-Json
            }
            New-UDEndpoint -Url "variable" -Method "GET" -Endpoint {
                $Variable | ConvertTo-Json
            }
            New-UDEndpoint -Url "user/:id" -Method "GET" -Endpoint {
                param($id)
                @("Adam", "Bill", "Frank", $id) | ConvertTo-Json
            }
            New-UDEndpoint -Url "user" -Method "DELETE" -Endpoint {
                @("Adam", "Bill", "Frank") | ConvertTo-Json
            }
            New-UDEndpoint -Url "user" -Method "POST" -Endpoint {
                param($test)
                @("Adam", "Bill", "Frank", $test) | ConvertTo-Json
            }
            New-UDEndpoint -Url "user" -Method "PUT" -Endpoint {
                param($test)
                @("Adam", "Bill", "Frank", $test) | ConvertTo-Json
            }
            New-UDEndpoint -Url "project" -Method "GET" -Endpoint {
                
                Set-UDContentType "application/xml"

                "<Project name=`"test`"></Project>"
            }
            New-UDEndpoint -Url "querystring" -Method "POST" -Endpoint {
                param($test)
                @("Adam", "Bill", "Frank", $test) | ConvertTo-Json
            }
            New-UDEndpoint -Url "inttest" -Method "POST" -Endpoint {
                param( [Int]$value )
            
                $value
            } 
            New-UDEndpoint -Url "/recherches/:rechercheId" -Method "DELETE" -Endpoint {
                param($rechercheId)
                
                $rechercheId
            }
            New-UDEndpoint -Url "/recherches/:rechercheId/activate" -Method "DELETE" -Endpoint {
                param($rechercheId)
                
                $rechercheId
            }
        ) -EndpointInitialization $Init

        It "should work with nested routes" {
            Invoke-RestMethod -Uri 'http://localhost:10001/api/recherches/1' -Method DELETE | Should be "1"
            Invoke-RestMethod -Uri 'http://localhost:10001/api/recherches/2/activate' -Method DELETE | Should be "2"
        }

        It "should process int correctly" {
            Invoke-RestMethod -Uri 'http://localhost:10001/api/inttest' -Method POST -Body {value=2} | Should be "2"
        }

        It "returns users from the get endpoint" {
            $users = Invoke-RestMethod -Uri http://localhost:10001/api/user 
            $users[0] | Should be "Adam"
            $users[1] | Should be "Bill"
            $users[2] | Should be "Frank"
        }

        It "returns variable from the get endpoint" {
            $variables = Invoke-RestMethod -Uri http://localhost:10001/api/variable
            $variables | Should be "Some text"
        }

        
        It "returns users from the get endpoint with variable" {
            $users = Invoke-RestMethod -Uri 'http://localhost:10001/api/user/1'
            $users[0] | Should be "Adam"
            $users[1] | Should be "Bill"
            $users[2] | Should be "Frank"
            $users[3] | Should be "1"
        }
        
        It "returns users from the delete endpoint" {
            $users = Invoke-RestMethod -Uri http://localhost:10001/api/user -Method DELETE
            $users[0] | Should be "Adam"
            $users[1] | Should be "Bill"
            $users[2] | Should be "Frank"
        }

        It "returns users from the post endpoint" {
            $users = Invoke-RestMethod -Uri http://localhost:10001/api/user -Method POST -Body @{Test="xyz"}
            $users[0] | Should be "Adam"
            $users[1] | Should be "Bill"
            $users[2] | Should be "Frank"
            $users[3] | Should be "xyz"
        }

        It "returns users from the put endpoint" -Skip {
            $users = Invoke-RestMethod -Uri http://localhost:10001/api/user -Method PUT -Body @{Test="xyz"}
            $users[0] | Should be "Adam"
            $users[1] | Should be "Bill"
            $users[2] | Should be "Frank"
            $users[3] | Should be "xyz"
        }

        It "returns users from query string" {
            $users = Invoke-RestMethod -Uri http://localhost:10001/api/querystring?Test=xyz -Method POST 
            $users[0] | Should be "Adam"
            $users[1] | Should be "Bill"
            $users[2] | Should be "Frank"
            $users[3] | Should be "xyz"
        }

        It "returns xml" {
            $project = Invoke-RestMethod -Uri http://localhost:10001/api/project -Method GET -ContentType "application/xml"
            $project 
            $project.Project.name | should be 'test'
        }

        It "returns a 404 for a missing method" {
            { Invoke-WebRequest -Uri http://localhost:10001/api/somecrap -Method GET } | Should throw
        }

        Stop-UDRestApi $Server
    }

    Disable-UDLogging

    Context "Post without content type"{

        $wsPOST = New-UDEndpoint -Url "/SpireonEvents" -Method POST -Endpoint {
        param($Body)
            $jsonBody = ConvertFrom-Json $Body

            Write-Output ($jsonBody | ConvertTo-Json)
        }

        $Server = Start-UDRestApi -Port 1001 -Endpoint @(
                    $wsPOST
                )

        It "Should return JSON even if no content type specified"{
            $json = (@{FilePath = "code"; Arguments = "script.ps1" } | ConvertTo-Json)
            $result = Invoke-RestMethod -Uri 'http://localhost:1001/api/SpireonEvents' -Method POST -Body $json #-ContentType 'application/json'
            $result | Should Be '@{Arguments=script.ps1; FilePath=code}'
        }
        $Server| Stop-UDDashboard
        
        Stop-UDRestApi $Server
    }
}