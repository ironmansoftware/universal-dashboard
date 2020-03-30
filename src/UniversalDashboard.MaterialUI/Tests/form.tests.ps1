Enter-SeUrl -Target $Driver -Url "http://localhost:10000/form"

Describe "Form" {
    It 'submits all changes' {
        $Element = Find-SeElement -Id 'txtName' -Driver $Driver
        Send-SeKeys -Element $Element -Keys 'Name'

        $Element = Find-SeElement -Id 'txtLastName' -Driver $Driver
        Send-SeKeys -Element $Element -Keys 'LastName'

        Find-SeElement -Id 'chkYes' -Driver $Driver | Invoke-SeClick

        Find-SeElement -Id 'switchYes' -Driver $Driver | Invoke-SeClick

        $Element = Find-SeElement -Id 'dateDate' -Driver $Driver
        $element.Clear()
        Send-SeKeys -Element $Element -Keys '02/11/2020'

        $Element = Find-SeElement -Id 'timePicker' -Driver $Driver
        $element.Clear()
        Send-SeKeys -Element $Element -Keys '10:20 PM'

        $Element = Find-SeElement -Id 'select' -Driver $Driver
        $Element.FindElementByXPath('../..') | Invoke-SeClick 
        Find-SeElement -TagName 'li' -Driver $Driver | Select-Object -First 1 | Invoke-SeClick 
        Find-SeElement -TagName 'body' -Driver $Driver | Invoke-SeClick 

        Find-SeElement -TagName 'body' -Driver $Driver | Invoke-SeClick 
        Find-SeElement -Id 'alon' -Driver $Driver | Invoke-SeClick 

        Find-SeElement -Id 'autoCompleteForm' -Driver $Driver | Invoke-SeClick
        Find-SeElement -Id 'autoCompleteForm' -Driver $Driver | Send-SeKeys -Keys '2'
        $Element = Find-SeElement -ClassName 'MuiAutocomplete-popper' -Driver $Driver 
        $Element.FindElementByTagName('li') | Invoke-SeClick
        
        (Find-SeElement -Id 'form' -Driver $Driver).FindElementsByTagName("button") | Where-Object Text -eq 'Submit' | Invoke-SeClick 

        $TestData = Get-TestData 

        $TestData.txtName | should be "Name"
        $TestData.txtLastName | should be "LastName"
        $TestData.chkYes | should be $true
        $TestData.switchYes | should be $true
        $TestData.dateDate.StartsWith('2020-02-11') | should be $true
        $TestData.select | should be "1"
        [DateTime]$DateTime = $TestData.timePicker
        $DateTime.TimeOfDay.ToString() | should be "22:20:00"
        $TestData.simpleRadio | should be "Alon"
        $TestData.autoCompleteForm | should be "Test2"
    }

    It 'submits default values' {
        (Find-SeElement -Id 'defaultForm' -Driver $Driver).FindElementsByTagName("button")[2] | Invoke-SeClick 

        $TestData = Get-TestData 

        $TestData.txtNameDefault | should be "Name"
        $TestData.txtLastNameDefault | should be "LastName"
        $TestData.chkYesDefault | should be $true
        $TestData.switchYesDefault | should be $true
        $TestData.dateDateDefault.StartsWith('1/2/2020') | should be $true
        $TestData.selectDefault | should be "1"
        $TestData.timePickerDefault | should be "10:30 AM"
        $TestData.simpleRadioDefault | should be "Adam"
    }

    It 'returns custom content' {
        (Find-SeElement -Id 'formReturnContent' -Driver $Driver).FindElementsByTagName("button")[0] | Invoke-SeClick 
        Find-SeElement -Id 'newElement' -Target $driver | Should not be $null
    }
    
    It 'returns validates the form' {
        (Find-SeElement -Id 'validateForm-validationError' -Driver $Driver).Text | Should be "txtValidateForm is required"
        $SubmitButton = (Find-SeElement -Id 'validateForm' -Driver $Driver).FindElementsByTagName("button") | Select-Object -Last 1
        $SubmitButton.GetAttribute("disabled") | should be "true"
        Find-SeElement -Id 'txtValidateForm' -Driver $Driver | Send-SeKeys -Keys "Hello"
        Start-Sleep 1
        $SubmitButton = (Find-SeElement -Id 'validateForm' -Driver $Driver).FindElementsByTagName("button") | Select-Object -Last 1
        $SubmitButton | Invoke-SeClick
        $TestData = Get-TestData 
        $TestData.txtValidateForm | should be "Hello"
    }
}