$Cert = New-SelfSignedCertificate -CertStoreLocation Cert:\CurrentUser\My -DnsName localhost

Start-UDDashboard -Content {
  New-UDDashboard -Title "Secure Dashboard" -Content {
    New-UDElement -Tag "h1" -Content { "hi" }
  }
} -Port 12000 -Certificate $Cert
