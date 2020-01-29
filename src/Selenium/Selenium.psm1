$Module = Import-Module Selenium -MinimumVersion '3.0.0' -ErrorAction Ignore
if ($Null -eq $Module)
{
    Install-Module Selenium -AllowPrerelease 
    Import-Module Selenium
}