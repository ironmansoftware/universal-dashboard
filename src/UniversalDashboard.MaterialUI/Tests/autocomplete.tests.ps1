Enter-SeUrl -Target $Driver -Url "http://localhost:10000/Autocomplete"

Describe 'AutoComplete' {
    It 'has static autocomplete options' {
        Find-SeElement -Id 'autoComplete' -Driver $Driver | Send-SeKeys -Keys '2'
        $Element = Find-SeElement -ClassName 'MuiAutocomplete-popper' -Driver $Driver 
        $Element.FindElementByTagName('li') | Invoke-SeClick
        Get-TestData | Should be "Test2"
    }

    It 'has dynamic autocomplete options' {
        Find-SeElement -Id 'autoCompleteDynamic' -Driver $Driver | Send-SeKeys -Keys '3'
        $Element = Find-SeElement -ClassName 'MuiAutocomplete-popper' -Driver $Driver 
        $Element.FindElementByTagName('li') | Invoke-SeClick
        Get-TestData | Should be "Test3"
    }
}