param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release

Import-Module $ModulePath -Force

Describe "Https" {
add-type @”
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
    public bool CheckValidationResult(
    ServicePoint srvPoint, X509Certificate certificate,
    WebRequest request, int certificateProblem) {
    return true;
    }
    }
“@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    $CertPassword = ConvertTo-SecureString -AsPlainText -Force -String "ud"

    Context "From store" {
        Import-PfxCertificate -Password $CertPassword -FilePath (Join-Path $PSScriptRoot '..\Assets\certificate.pfx') -CertStoreLocation Cert:\CurrentUser\My
        $Cert = Get-ChildItem Cert:\currentuser\my\D8B484EAEF02D50F6E1FB064A129BE5BE33DEADE
        Start-UDDashboard -Port 10005 -Name 'DCert5' -Certificate $Cert

        It "should serve HTTPS" {
            $Request = Invoke-WebRequest https://localhost:10005/api/internal/dashboard
            $Request.StatusCode | Should be 200
        }

        Stop-UDDashboard -Name 'DCert5'
    }

    Context "From file" {
        It "should serve HTTPS" {
            Start-UDDashboard -Port 10005 -Name 'DCert5' -CertificateFile (Join-Path $PSScriptRoot '..\Assets\certificate.pfx') -CertificateFilePassword $CertPassword

            $Request = Invoke-WebRequest https://localhost:10005/api/internal/dashboard
            $Request.StatusCode | Should be 200

            Stop-UDDashboard -Name 'DCert5'
        }
    }
}