$Module = Import-Module Selenium -MinimumVersion '3.0.0' -ErrorAction Ignore -PassThru
if ($Null -eq $Module)
{
    Install-Module Selenium -AllowPrerelease -Force -Scope CurrentUser -ErrorAction Ignore
    $Module = Import-Module Selenium -PassThru
}