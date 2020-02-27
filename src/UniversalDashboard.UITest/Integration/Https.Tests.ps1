. "$PSScriptRoot\..\TestFramework.ps1"

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

        It "should serve HTTPS - REST API" {
            $Endpoint = New-UDEndpoint -Url "/test" -Endpoint {}

            Start-UDRestApi -Port 10001 -Certificate $Cert -Endpoint $Endpoint -Force

            $Request = Invoke-WebRequest https://localhost:10001/test
            $Request.StatusCode | Should be 200
        }

        It "should serve HTTPS" {
            Start-UDDashboard -Port 10001 -Certificate $Cert -Force -Dashboard (New-UDDashboard -Content {})

            $Request = Invoke-WebRequest https://localhost:10001/dashboard
            $Request.StatusCode | Should be 200
        }

        It "should redirect HTTPS" {
            Start-UDDashboard -Port 10001 -HttpsPort 10002 -Certificate $Cert -Force -Dashboard (New-UDDashboard -Content {})

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
        }
    }

    Context "From file" {
        It "should serve HTTPS" {''

            $CertPath = [System.IO.Path]::GetTempFileName() + ".pfx"
            $CertPassword = ConvertTo-SecureString -String "WeakPassword" -AsPlainText -Force

            Export-PfxCertificate -Cert $Cert -Password $CertPassword -Force -FilePath $CertPath

            Start-UDDashboard -Port 10001 -CertificateFile $CertPath -CertificateFilePassword $CertPassword -Force -Dashboard (New-UDDashboard -Content {})

            $Request = Invoke-WebRequest https://localhost:10001/dashboard
            $Request.StatusCode | Should be 200

            Remove-Item $CertPath -Force
        }
    }
}
