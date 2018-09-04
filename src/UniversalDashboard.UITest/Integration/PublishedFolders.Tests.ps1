# param([Switch]$Release)

# Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
# $ModulePath = Get-ModulePath -Release:$Release

# Import-Module $ModulePath -Force

Get-UDRestApi | Stop-UDRestApi
Get-UDDashboard | Stop-UDDashboard
Describe "PublishedFolders" {
    Context "published  folder via rest api" {
        $TempPath = [IO.Path]::GetTempPath()

        'log','txt','ps1','psd1','psm1','md','yml','html' | ForEach-Object {

            $TempFile = Join-Path $TempPath "myFile.$_"

            "Test" | Out-File $TempFile -Force -Encoding ascii

    
            $Server = Start-UDRestApi -Port 10001 -PublishedFolder @(
                Publish-UDFolder -Path $TempPath -RequestPath "/temp"
            )
    
            It "should return the content of $TempFile" {
                (Invoke-WebRequest "http://localhost:10001/temp/myFile.$_").Content | Should be "Test`r`n"
            }
            
            Stop-UDRestApi $Server
        }


    }

    Context "published  folder via dashboard" {
        
        'log','txt','ps1','psd1','psm1','md','yml','html' | ForEach-Object {
        
            $TempPath = [IO.Path]::GetTempPath()
            $TempFile = Join-Path $TempPath "myFile.$_"

            "Test" | Out-File $TempFile -Force -Encoding ascii

            $Server = Start-UDDashboard -Port 10001 -PublishedFolder @(
                Publish-UDFolder -Path $TempPath -RequestPath "/temp"
            ) -Dashboard (
                New-UDDashboard -Title "Hey" -Content {}
            )

            It "should publish folder and return the content of $TempFile" {
                (Invoke-WebRequest "http://localhost:10001/temp/myFile.$_").Content | Should be "Test`r`n"
            }

            Stop-UDDashboard $Server
        }
    }
}