function New-UDInput {
    param(

        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),

		[Parameter()]
		[string]$Title,

		[Parameter()]
		[string]$SubmitText = "Submit",

		[Parameter()]
		[DashboardColor]$BackgroundColor,

		[Parameter()]
		[DashboardColor]$FontColor,

		[Parameter(Mandatory)]
		[ScriptBlock]$Endpoint,

		[Parameter()]
		[ScriptBlock]$Content,

        [Parameter()]
        [Switch]$Validate
    )

    $fields = @()
    if ($Content)
    {
        $fields = & $Content 
    }
    else 
    {
        $ParamBlock = $Endpoint.Ast.ParamBlock
        if ($null -ne $ParamBlock)
        {
            foreach($parameter in $ParamBlock.Parameters)
            {
                $field = @{
                    name = $parameter.Name.VariablePath.ToString()
                    value = ''
                    type = ''                    
                    dotNetType = ''
                }

                if ($parameter.StaticType -eq [bool] -or $parameter.StaticType -eq [Switch])
                {
                    $field.value = "false"
                    $field.type = 'checkbox'
                    $field.dotNetType = $parameter.StaticType.FullName
                }
                elseif ($parameter.StaticType.IsEnum)
                {
                    $field.Type = 'select'
                    $field.validOptions = [Enum]::GetNames($parameter.StaticType)
                    $field.dotNetType = $parameter.StaticType.FullName
                    $field.Value = [string]([Enum]::GetValues($parameter.StaticType) | Select-Object -First 1)
                }
                elseif ($Parameter.StaticType -eq [DateTime])
                {
                    $field.type = 'date';
                    $field.dotNetType = $parameter.StaticType.FullName
                }
                elseif ($Parameter.StaticType -eq [System.Security.SecureString])
                {
                    $field.type = 'password';
                    $field.dotNetType = $parameter.StaticType.FullName
                }
                elseif ($Parameter.StaticType -eq [string[]])
                {
                    $field.type = 'textarea';
                    $field.dotNetType = $parameter.StaticType.FullName
                }
                else 
                {
                    $field.Type = 'textbox'
                    $field.DotNetType = [string].FullName
                }

                $fields += $field
            }
        }
    }

    $CustomEndpoint = {
        function ConvertTo-Type {
            param(
                [string]$VariableName
            )

            $Value = Get-Variable -Name $VariableName -ValueOnly
            $Type = Get-Variable -Name "$($VariableName)_type" -ValueOnly

            if ($Type -eq 'checkbox')
            {
                [bool]$out = $false
                [bool]::TryParse($Value, [ref]$out) | Out-Null
                $Value = $out
            }
            elseif ($Type -eq 'date')
            {
                [DateTime]$out = [DateTime]::MinValue
                [DateTime]::TryParseExact($Value, "dd-MM-yyyy", $Host.CurrentCulture, 'none', [ref]$out)
                $Value = $out
            }

            $Value
        }

        function Invoke-PSUForm 
        {
            #content
        }

        $parameters = @{}

        #parameters

        Invoke-PSUForm @parameters
    }

    $parameterStr = ''
    foreach($field in $fields)
    {
         $parameterStr += "if (-not [String]::IsNullOrEmpty(`$$($field.Name))) { `$parameters['$($field.Name)'] = ConvertTo-Type -VariableName '$($field.Name)' $([Environment]::NewLine) }"
    }

    $Endpoint = [ScriptBlock]::Create($CustomEndpoint.ToString().Replace("#content", $Endpoint.ToString()).Replace("#parameters", $parameterStr))

    [Endpoint]$e = $Endpoint
    $e.Register($Id, $PSCmdlet)

    Write-Debug ($Endpoint.ToString())

    @{
        type = "ud-input"
        isPlugin = $true 
        assetId = $AssetId 

        title = $title 
        submitText = $SubmitText 
        backgroundColor = $BackgroundColor.HtmlColor
        fontColor = $FontColor.HtmlColor
        validate = $Validate.IsPresent
        fields = $fields
        id = $id
    }
}

function New-UDInputField {
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter()]
        [Switch]$Mandatory,

        [Parameter()]
        [object[]]$Values,

        [Parameter()]
        [object]$DefaultValue,

        [Parameter()]
        [string[]]$Placeholder,

        [Parameter()]
        [Switch]$Disabled,

        [Parameter()]
        [ValidateSet("textbox", "checkbox", "select", "radioButtons", "password", "textarea", "switch", "date", "file", "time", "binaryFile")]
        [string]$Type,

        [Parameter(ParameterSetName = "datetime")]
        [string]$OkText = "Ok",

        [Parameter(ParameterSetName = "datetime")]
        [string]$CancelText = "Cancel",

        [Parameter(ParameterSetName = "datetime")]
        [string]$ClearText = "Clear"
    )

    if ($Type -eq 'select' -and -not $DefaultValue -and $Values -and $Values.Length -gt 0)
    {
        $DefaultValue = $Values | Select-Object -First 1
    }

    $inputType = [string]
    if ($Type -eq 'checkbox')
    {
        $inputType = [bool]
    }

    if ($Type -eq 'date')
    {
        $inputType = [DateTime]
    }

    @{
        name = $Name 
        required = $Mandatory.IsPresent
        validOptions = $Values
        value = $DefaultValue
        placeholder = $Placeholder
        disabled = $Disabled.IsPresent
        type = $type
        okText = $OkText
        cancelText = $CancelText 
        clearText = $ClearText 
        dotNetType = $inputType.FullName
    }
}

function New-UDInputAction {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ParameterSetName = "toast")]
		[string]$Toast,

	    [Parameter(ParameterSetName = "toast")]
	    [int]$Duration = 1000,

	    [Parameter(Mandatory, ParameterSetName = "redirect")]
		[string]$RedirectUrl,

		[Parameter(Mandatory, ParameterSetName = "content")]
		[ScriptBlock]$Content,

		[Parameter()]
		[Switch]$ClearInput
    )

    if ($Toast)
    {
        @{
            type = "toast"
            text = $Toast 
            duration = $Duration 
            clearInput = $ClearInput.IsPresent
        }
    }
    elseif ($RedirectUrl)
    {
        @{
            type = "redirect"
            route = $RedirectUrl
        }
    }
    elseif ($Content)
    {
        $c = @()
        try 
        {
            $c = & $Content 
        }
        catch
        {
            $c = New-UDError -Message $_
        }

        @{
            type = "content"
            components = $c
        }
    }
    else 
    {
        @{
            type = "clear"
            clearInput = $true 
        }
    }
}