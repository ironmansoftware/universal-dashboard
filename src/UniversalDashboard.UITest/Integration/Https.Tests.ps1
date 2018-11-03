param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Describe "Https" {
    $CertPassword = ConvertTo-SecureString -AsPlainText -Force -String "ud"

    Context "From store" {

        Import-PfxCertificate -Password $CertPassword -FilePath (Join-Path $PSScriptRoot '..\Assets\certificate.pfx') -CertStoreLocation Cert:\CurrentUser\My

        It "should serve HTTPS" {
            $Cert = Get-ChildItem Cert:\currentuser\my\D8B484EAEF02D50F6E1FB064A129BE5BE33DEADE
            $Dashboard = Start-UDDashboard -Port 10001 -Certificate $Cert

            $Request = Invoke-WebRequest https://localhost:10001/dashboard
            $Request.StatusCode | Should be 200

            Stop-UDDashboard -Server $Dashboard
        }
    }

    Get-UDDashboard | Stop-UDDashboard

    Context "From file" {
        It "should serve HTTPS" {
            $Dashboard = Start-UDDashboard -Port 10001 -CertificateFile (Join-Path $PSScriptRoot '..\Assets\certificate.pfx') -CertificateFilePassword $CertPassword

            $Request = Invoke-WebRequest https://localhost:10001/dashboard
            $Request.StatusCode | Should be 200

            Stop-UDDashboard -Server $Dashboard
        }
    }
}