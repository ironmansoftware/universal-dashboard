$Users = @(
    [PSCustomObject]@{
        id   = 1
        name = "Adam"
    }
    [PSCustomObject]@{
        id   = 2
        name = "Frank"
    }
)

$CreateRestApis = {
    New-UDEndpoint -Url "/api/user" -Endpoint {
        $Users
    }

    Invoke-RestMethod -Uri "https://poshud.com/api/user"
}

$Parameters = {
    New-UDEndpoint -Url "/api/user/:id" -Endpoint {
        param($id)

        $Users | Where-Object Id -eq $id
}

Invoke-RestMethod -Uri "https://poshud.com/api/user/1"
}

$PostData = {
    New-UDEndpoint -Url "/api/echo" -Method POST -Endpoint {
        param($Body)

        $Body | ConvertTo-Json
}

$Body = @{  value = "test" }
Invoke-RestMethod -Uri "https://poshud.com/api/echo" -Method POST -Body  -ContentType "application/json"
}

New-UDPage -Name "REST APIs" -Icon code -Content {
    New-UDPageHeader -Title "REST APIs" -Icon "code" -Description "Create REST APIs using PowerShell." -DocLink "https://docs.universaldashboard.io/rest-apis"
    New-UDExample -Title "Return data" -Description "Return data from REST APIs." -Script $CreateRestApis -NoRender
    New-UDExample -Title "Parameters" -Description "Accept parameters for your REST APIs." -Script $Parameters -NoRender
    New-UDExample -Title "POST Data" -Description "Post data to an endpoint." -Script $PostData -NoRender
}