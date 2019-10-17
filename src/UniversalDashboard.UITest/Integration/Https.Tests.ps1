param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Add-Type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
             ServicePoint srvPoint, X509Certificate certificate,
             WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

$Cert = New-SelfSignedCertificate -CertStoreLocation Cert:\CurrentUser\My -DnsName localhost

Describe "Https" {
    Context "From store" {

        It "should serve HTTPS" {
            $Dashboard = Start-UDDashboard -Port 10001 -Certificate $Cert

            $Request = Invoke-WebRequest https://localhost:10001/dashboard
            $Request.StatusCode | Should be 200

            Stop-UDDashboard -Server $Dashboard
        }

        It "should redirect HTTPS" {
            $Dashboard = Start-UDDashboard -Port 10001 -HttpsPort 10002 -Certificate $Cert

            try 
            {
                $Request = Invoke-WebRequest http://localhost:10001/dashboard
            }
            catch 
            {
                $_.Exception.Response.StatusCode | should be 308
            }

            $Request = Invoke-WebRequest https://localhost:10002/dashboard
            $Request.StatusCode | Should be 200

            Stop-UDDashboard -Server $Dashboard
        }
    }

    Get-UDDashboard | Stop-UDDashboard

    Context "From file" {
        It "should serve HTTPS" {''

            $CertPath = [System.IO.Path]::GetTempFileName() + ".pfx"
            $CertPassword = ConvertTo-SecureString -String "WeakPassword" -AsPlainText -Force

            Export-PfxCertificate -Cert $Cert -Password $CertPassword -Force -FilePath $CertPath

            $Dashboard = Start-UDDashboard -Port 10001 -CertificateFile $CertPath -CertificateFilePassword $CertPassword

            $Request = Invoke-WebRequest https://localhost:10001/dashboard
            $Request.StatusCode | Should be 200

            Stop-UDDashboard -Server $Dashboard

            Remove-Item $CertPath -Force
        }
    }
}
