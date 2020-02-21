Enter-SeUrl -Target $Driver -Url "http://localhost:10000/select"

Describe "select" {

    It 'is circular indeterminate' {
        (Find-SeElement -Id 'progressCircularIndeterminate' -Driver $Driver).GetAttribute("class").Contains("MuiCircularProgress-indeterminate") | should be $true
    }

    It 'is linear indeterminate' {
        (Find-SeElement -Id 'progressLinearIndeterminate' -Driver $Driver).GetAttribute("class").Contains("MuiLinearProgress-indeterminate") | should be $true
    }

    It 'is linear determinate' {
        (Find-SeElement -Id 'progressLinearDeterminate' -Driver $Driver).GetAttribute("class").Contains("MuiLinearProgress-determinate") | should be $true
        (Find-SeElement -Id 'progressLinearDeterminate' -Driver $Driver).GetAttribute("aria-valuenow") | should be "75"
    }
}