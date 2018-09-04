param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release

Import-Module $ModulePath -Force

Get-UDRestApi | Stop-UDRestApi
Get-UDDashboard | Stop-UDDashboard
Describe "PublishedFolders" {
    Context "published  folder via rest api" {

        $TempPath = [IO.Path]::GetTempPath()
        $TempFile = Join-Path $TempPath "myFile.txt"

        "Test" | Out-File $TempFile -Force -Encoding ascii

        $TempFile2 = Join-Path $TempPath "myFile.log"

        "Test2" | Out-File $TempFile2 -Force -Encoding ascii

        $TempFile3 = Join-Path $TempPath "myFile.ps1"

        "Test3" | Out-File $TempFile3 -Force -Encoding ascii

        $Server = Start-UDRestApi -Port 10001 -PublishedFolder @(
            Publish-UDFolder -Path $TempPath -RequestPath "/temp"
        )

        It "should publish folder" {
            (Invoke-WebRequest http://localhost:10001/temp/myFile.txt).Content | Should be "Test`r`n"
        }

        It "should publish folder (log)" {
            (Invoke-WebRequest http://localhost:10001/temp/myFile.log).Content | Should be "Test2`r`n"
        }

        It "should publish folder (ps1)" {
            (Invoke-WebRequest http://localhost:10001/temp/myFile.ps1).Content | Should be "Test3`r`n"
        }

        Stop-UDRestApi $Server
    }

    Context "published  folder via dashboard" {

        $TempPath = [IO.Path]::GetTempPath()
        $TempFile = Join-Path $TempPath "myFile.txt"

        "Test" | Out-File $TempFile -Force -Encoding ascii

        $TempFile2 = Join-Path $TempPath "myFile.log"

        "Test" | Out-File $TempFile2 -Force -Encoding ascii

        $TempFile3 = Join-Path $TempPath "myFile.ps1"

        "Test" | Out-File $TempFile3 -Force -Encoding ascii


        $Server = Start-UDDashboard -Port 10001 -PublishedFolder @(
            Publish-UDFolder -Path $TempPath -RequestPath "/temp"
        ) -Dashboard (
            New-UDDashboard -Title "Hey" -Content {}
        )

        It "should publish folder" {
            (Invoke-WebRequest http://localhost:10001/temp/myFile.txt).Content | Should be "Test`r`n"
        }

        It "should publish folder (log)" {
            (Invoke-WebRequest http://localhost:10001/temp/myFile.log).Content | Should be "Test2`r`n"
        }

        It "should publish folder (ps1)" {
            (Invoke-WebRequest http://localhost:10001/temp/myFile.ps1).Content | Should be "Test3`r`n"
        }

        Stop-UDDashboard $Server
    }
}