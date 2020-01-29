$Module = Import-Module Selenium -MinimumVersion '3.0.0' -ErrorAction Ignore -Scope Global
if ($Null -eq $Module)
{
    Install-Module Selenium -AllowPrerelease 
    Import-Module Selenium -Scope Global
}

function Get-SeElementCssValue {
    param(
        [Parameter(ValueFromPipeline=$true, Mandatory = $true)]
        [OpenQA.Selenium.IWebElement]$Element,
        [Parameter(Mandatory=$true)]
        [string]$Name
    )

    Process {
        $Element.GetCssValue($Name)
    }
}