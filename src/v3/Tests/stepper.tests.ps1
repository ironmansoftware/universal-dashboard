Enter-SeUrl -Target $Driver -Url "$Address/Test/stepper"

Describe "Stepper" {
    It 'should set data throughout the stepper' {
        Find-SeElement -Id 'txtStep1' -Driver $Driver | Send-SeKeys -Keys "Step1Data"
        Find-SeElement -Id 'stepperbtnNext' -Driver $Driver | Invoke-SeClick 
        $Data = Get-TestData 
        $Data.context.txtStep1 | Should be "Step1Data"

        Find-SeElement -Id 'txtStep2' -Driver $Driver | Send-SeKeys -Keys "Step2Data"
        Find-SeElement -Id 'stepperbtnNext' -Driver $Driver | Invoke-SeClick 
        $Data = Get-TestData 
        $Data.context.txtStep1 | Should be "Step1Data"
        $Data.context.txtStep2 | Should be "Step2Data"

        Find-SeElement -Id 'txtStep3' -Driver $Driver | Send-SeKeys -Keys "Step3Data"
        Find-SeElement -Id 'stepperbtnNext' -Driver $Driver | Invoke-SeClick 
        $Data = Get-TestData 

        $Data.context.txtStep1 | Should be "Step1Data"
        $Data.context.txtStep2 | Should be "Step2Data"
        $Data.context.txtStep3 | Should be "Step3Data"
    }
}