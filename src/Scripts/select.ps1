function New-UDSelect {
    <#
    .SYNOPSIS
    Creates a new select.
    
    .DESCRIPTION
    Creates a new select. Selects can have multiple options and option groups. Selects can also be multi-select. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Option
    Options to include in this select. This can be either New-UDSelectOption or New-UDSelectGroup.
    
    .PARAMETER Label
    The label to show with the select. 
    
    .PARAMETER OnChange
    A script block that is executed when the script changes. $EventData will be an array of the selected values. 
    
    .PARAMETER DefaultValue
    The default selected value.
    
    .PARAMETER Disabled
    Whether this select is disabled. 
    
    .PARAMETER Multiple
    Whether you can select multiple values. 

    .PARAMETER FullWidth
    Stretch the select to the full width of the parent component.
    
    .EXAMPLE
    Creates a new select with 3 options and shows a toast when one is selected. 

    New-UDSelect -Label '1-3' -Id 'select' -Option {
        New-UDSelectOption -Name "One" -Value 1
        New-UDSelectOption -Name "Two" -Value 2
        New-UDSelectOption -Name "Three" -Value 3
    } -DefaultValue 2 -OnChange { 
        Show-UDToast -Mesage $EventData 
    }
    #>
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        [ScriptBlock]$Option,
        [Parameter()]
        [String]$Label,
        [Parameter()]
        [Endpoint]$OnChange,
        [Parameter()]
        $DefaultValue,
        [Parameter()]
        [Switch]$Disabled,
        [Parameter()]
        [Switch]$Multiple,
        [Parameter()]
        [string]$MaxWidth,
        [Parameter()]
        [string]$ClassName,
        [Parameter()]
        [switch]$FullWidth
    )

    if ($OnChange) {
        $OnChange.Register($Id + "onChange", $PSCmdlet)
    }

    @{
        type         = 'mu-select'
        assetId      = $MUAssetId
        isPlugin     = $true 

        id           = $id 
        options      = $Option.Invoke()
        label        = $Label
        onChange     = $OnChange
        defaultValue = $DefaultValue
        disabled     = $Disabled.IsPresent
        multiple     = $Multiple.IsPresent
        maxWidth     = $MaxWidth
        className    = $ClassName
        fullWidth    = $FullWidth.IsPresent
    }
}

function New-UDSelectGroup {
    <#
    .SYNOPSIS
    Creates a new select group.
    
    .DESCRIPTION
    Creates a new select group. This cmdlet is to be used with New-UDSelect. Pass the result of this cmdlet to the -Option parameter to create a new select group. 
    
    .PARAMETER Option
    Options to include in this group.
    
    .PARAMETER Name
    The name of the group. This will be displayed in the select. 
    
    .EXAMPLE
    Creates a new select with two select groups. 

    New-UDSelect -Id 'selectGrouped' -Option {
        New-UDSelectGroup -Name "Category 1" -Option {
            New-UDSelectOption -Name "One" -Value 1
            New-UDSelectOption -Name "Two" -Value 2
            New-UDSelectOption -Name "Three" -Value 3
        }
        New-UDSelectGroup -Name "Category 2" -Option {
            New-UDSelectOption -Name "Four" -Value 4
            New-UDSelectOption -Name "Five" -Value 5
            New-UDSelectOption -Name "Six" -Value 6
        }
    } -DefaultValue 2 -OnChange { Show-UDToast -Message $EventData }
    
    #>
    param(
        [Parameter(Mandatory = $true)]
        [ScriptBlock]$Option,
        [Parameter(Mandatory = $true)]
        [String]$Name
    )

    @{
        type    = 'mu-select-group'
        name    = $Name 
        options = $Option.Invoke()
    }

}

function New-UDSelectOption {
    <#
    .SYNOPSIS
    Creates a new select option.
    
    .DESCRIPTION
    Creates a new select option. This cmdlet is to be used with New-UDSelect. Pass the result of this cmdlet to the -Option parameter to create a new select group.
    
    .PARAMETER Name
    The name of the select option. This will be shown in the select. 
    
    .PARAMETER Value
    Thevalue of the select option. This will be passed back to New-UDForm -OnSubmit or the $EventData for -OnChange on New-UDSelect. 
    
    .EXAMPLE
    Creates a new select with three options. 

    New-UDSelect -Label '1-3' -Id 'select' -Option {
        New-UDSelectOption -Name "One" -Value 1
        New-UDSelectOption -Name "Two" -Value 2
        New-UDSelectOption -Name "Three" -Value 3
    } -DefaultValue 2 -OnChange { 
        $EventData = $Body | ConvertFrom-Json
        Set-TestData $EventData 
    }

    #>
    param(
        [Parameter(Mandatory = $true)]
        [String]$Name,
        [Parameter(Mandatory = $true)]
        [String]$Value
    )

    @{
        type  = 'mu-select-option'
        name  = $Name 
        value = $Value 
    }
}
