. "$PSScriptRoot\..\TestFramework.ps1"

Describe "Cache" {
    Context "Xml" {
        It "Should work with XML" {
            $cache:data = [xml]"<data><xpath></xpath><xpath></xpath><xpath></xpath></data>"
            ($Cache:data.SelectNodes("//data/xpath")).Count | should be 3
        }
    }

    Context "Clear-UDCache" {
        It "Should work with XML" {
            $cache:data = [xml]"<data><xpath></xpath><xpath></xpath><xpath></xpath></data>"
            Clear-UDCache
            $Cache:data | Should be $null
        }
    }
}