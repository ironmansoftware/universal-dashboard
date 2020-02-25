. "$PSScriptRoot\..\TestFramework.ps1"

Describe "Api" {
    Context "Components" {

        $Variable = @("Some text")
        
        $Init = New-UDEndpointInitialization -Variable "Variable"

        $ScriptBlock = [ScriptBlock]::Create((Get-Content (Join-Path $PSScriptRoot "../Assets/requires.txt") -Raw))

        Start-UDRestApi -Force -Port 10001 -Endpoint @(

            New-UDEndpoint -Url "/recherches" -Method "GET" -Endpoint {
                'éèù' | ConvertTo-Json
            }

            New-UDEndpoint -Url "/scriptblock" -Method "GET" -Endpoint $ScriptBlock

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
            New-UDEndpoint -Url "user" -Method "PATCH" -Endpoint {
                param($test)
                @("Adam", "Bill", "Frank", $test) | ConvertTo-Json
            }
            New-UDEndpoint -Url "/plop/:Guid/SomePart" -Method PATCH -Endpoint {
                param([String]$Guid,$Body)
                "MEH"
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
            New-UDEndpoint -Url "nodes\(agent=(?<name>[0-9]*)\)" -Method "GET" -Endpoint {
                param($name)
                
                $name
            } -EvaluateUrlAsRegex

            New-UDEndpoint -Url "/delete/body" -Method "DELETE" -Endpoint {
                $body
            }

            New-UDEndpoint -Url "/group/:id" -Method "GET" -Endpoint {
                param($id)
                
                $id
            }
            New-UDEndpoint -Url "/group/:id/memberOf" -Method "GET" -Endpoint {
                param($id)
                
                "memberOf$id"
            }

            $wsPOST = New-UDEndpoint -Url "/SpireonEvents" -Method POST -Endpoint {
                param($Body)
                    $jsonBody = ConvertFrom-Json $Body
        
                    Write-Output ($jsonBody | ConvertTo-Json)
                }

            ) -EndpointInitialization $Init


        New-UDEndpoint -Url "/afterstartup" -Method "GET" -Endpoint {
            "After Startup"
        }

        It "Is fast" -Skip {
            (Measure-Command -Expression { 
                1..100 | % { Invoke-RestMethod http://localhost:10001/api/user  }
            }).TotalSeconds | Should BeLessThan 15
        }

        It "doesn't mess up the characters" {
            (Invoke-RestMethod http://localhost:10001/api/recherches) | Should be "éèù"
        }

        It "not throw an error" {
            (Invoke-RestMethod http://localhost:10001/api/scriptblock?hello=test) | Should be "Hello"
        }

        It "should work with nested routes" {
            Invoke-RestMethod -Uri 'http://localhost:10001/api/recherches/1' -Method DELETE | Should be "1"
            Invoke-RestMethod -Uri 'http://localhost:10001/api/recherches/2/activate' -Method DELETE | Should be "2"
            Invoke-RestMethod -Uri 'http://localhost:10001/api/group/1' -Method GET | Should be "1"
            Invoke-RestMethod -Uri 'http://localhost:10001/api/group/1/memberOf' -Method GET | Should be "memberOf1"
            
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
            $users = Invoke-RestMethod -Uri http://localhost:10001/api/user -Method POST -Body @{Test="xyz"} -ContentType 'application/x-www-form-urlencoded'
            $users[0] | Should be "Adam"
            $users[1] | Should be "Bill"
            $users[2] | Should be "Frank"
            $users[3] | Should be "xyz"
        }

        It "returns users from the put endpoint" {
            $users = Invoke-RestMethod -Uri http://localhost:10001/api/user -Method PUT -Body @{Test="xyz"} -ContentType 'application/x-www-form-urlencoded'
            $users[0] | Should be "Adam"
            $users[1] | Should be "Bill"
            $users[2] | Should be "Frank"
            $users[3] | Should be "xyz"
        }

        It "returns users from the patch endpoint" {
            $users = Invoke-RestMethod -Uri http://localhost:10001/api/user -Method Patch -Body @{Test="xyz"} -ContentType 'application/x-www-form-urlencoded'
            $users[0] | Should be "Adam"
            $users[1] | Should be "Bill"
            $users[2] | Should be "Frank"
            $users[3] | Should be "xyz"
        }

        It "returns users from the patch endpoint with parameters" {
            $result = Invoke-RestMethod -Uri http://localhost:10001/api/plop/asdf-asdf-adsf-adsf/SomePart -Method Patch -Body @{Test="xyz"}
            $result | should be "Meh"
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

        It "returns value of regex" {
            Invoke-RestMethod -Uri 'http://localhost:10001/api/nodes(agent=1234)' -Method GET | Should be 1234
        }

        It "should use body for delete"  {
            $result = Invoke-RestMethod -Uri http://localhost:10001/api/delete/body -Method DELETE -Body "test"
            $result | Should be "test"
        }

        It "Should return JSON even if no content type specified"{
            $json = (@{FilePath = "code"; Arguments = "script.ps1" } | ConvertTo-Json)
            $result = Invoke-RestMethod -Uri 'http://localhost:10001/api/SpireonEvents' -Method POST -Body $json #-ContentType 'application/json'
            $result | Should Be '@{Arguments=script.ps1; FilePath=code}'
        }
    }
}