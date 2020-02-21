. "$PSScriptRoot\..\TestFramework.ps1"

Describe "PublishedFolders" {
    Context "published  folder via rest api" {
        $TempPath = [IO.Path]::GetTempPath()

        'log','txt','ps1','psd1','psm1','md','yml','html' | ForEach-Object {

            $TempFile = Join-Path $TempPath "myFile.$_"

            "Test" | Out-File $TempFile -Force -Encoding ascii

            Start-UDRestApi -Port 10001 -Force -PublishedFolder @(
                Publish-UDFolder -Path $TempPath -RequestPath "/temp"
            )
    
            It "should return the content of $TempFile" {
                (Invoke-WebRequest "http://localhost:10001/temp/myFile.$_").Content | Should be "Test`r`n"
            }
        }


    }

    Context "published  folder via dashboard" {
        
        'log','txt','ps1','psd1','psm1','md','yml','html' | ForEach-Object {
        
            $TempPath = [IO.Path]::GetTempPath()
            $TempFile = Join-Path $TempPath "myFile.$_"

            "Test" | Out-File $TempFile -Force -Encoding ascii

            Start-UDDashboard -Force -Port 10001 -PublishedFolder @(
                Publish-UDFolder -Path $TempPath -RequestPath "/temp"
            ) -Dashboard (
                New-UDDashboard -Title "Hey" -Content {}
            )

            It "should publish folder and return the content of $TempFile" {
                (Invoke-WebRequest "http://localhost:10001/temp/myFile.$_").Content | Should be "Test`r`n"
            }
        }
    }
}