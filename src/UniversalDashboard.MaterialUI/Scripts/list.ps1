function New-UDMuList {
    param(
        [Parameter ()][string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter ()][scriptblock]$Content,
        [Parameter ()][string]$SubHeader,
        [Parameter ()][Hashtable]$Style
    )
    End
    {
        @{
            type = 'mu-list'
            isPlugin = $true
            assetId = $MUAssetId

            id = $Id
            content = $Content.Invoke()
            subHeader = $SubHeader
            style = $Style
        }
    }
}


function New-UDMuListItem {
    [CmdletBinding()]
    param(
        [Parameter ()][string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter ()][ValidateSet("Icon","Avatar")][string]$AvatarType,
		[Parameter ()][object]$OnClick, 
        [Parameter ()][switch]$IsButton, 
        [Parameter ()][string]$Label, 
        [Parameter ()][scriptblock]$Content, 
        [Parameter ()][switch]$IsEndPoint, 
        [Parameter ()][switch]$AutoRefresh,
        [Parameter ()][int]$RefreshInterval = 5,
        [Parameter ()][string]$SubTitle,
        [Parameter ()][PSTypeName('UniversalDashboard.MaterialUI.Icon')]$Icon,
        [Parameter ()][string]$Source,
        [Parameter ()][scriptblock]$SecondaryAction,
        [Parameter ()][Hashtable]$LabelStyle,
        [Parameter ()][Hashtable]$Style
    )
    # DynamicParam {
        
    #     $paramDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

    #     if ($AvatarType -eq "Icon") {
    #          #create a new ParameterAttribute Object
    #          $IconAttribute = New-Object System.Management.Automation.ParameterAttribute
    #          $IconAttribute.Mandatory = $true
    #          $IconAttribute.HelpMessage = "Use New-UDIcon to create new icon"
    #          $attributeCollection = new-object System.Collections.ObjectModel.Collection[System.Attribute]
    #          #add our custom attribute
    #          $attributeCollection.Add($IconAttribute)
    #          #add our paramater specifying the attribute collection
    #          $IconParam = New-Object System.Management.Automation.RuntimeDefinedParameter('Icon', [object], $attributeCollection)
    #          $paramDictionary.Add('Icon', $IconParam)

    #     }
    #     elseif($AvatarType -eq "Avatar"){
    #         #create a new ParameterAttribute Object
    #         $AvatarAttribute = New-Object System.Management.Automation.ParameterAttribute
    #         $AvatarAttribute.Mandatory = $true
    #         $AvatarAttribute.HelpMessage = "Enter the path to the avatar image it can be local or url"
    #         $AvatarCollection = new-object System.Collections.ObjectModel.Collection[System.Attribute]

    #         #add our custom attribute
    #         $AvatarCollection.Add($AvatarAttribute)
    #         #add our paramater specifying the attribute collection
    #         $AvatarParam = New-Object System.Management.Automation.RuntimeDefinedParameter('Source', [string], $AvatarCollection)
    #         $paramDictionary.Add('Source', $AvatarParam)
    #     }
    #     return $paramDictionary
    # }
    begin{}
    Process{}
    End 
    {
        if ($null -ne $OnClick) {
            if ($OnClick -is [scriptblock]) {
                $OnClick = New-UDEndpoint -Endpoint $OnClick -Id ($Id + "onClick")
            }
            elseif ($OnClick -isnot [UniversalDashboard.Models.Endpoint]) {
                throw "OnClick must be a script block or UDEndpoint"
            }else{
                $OnClick = $null
            }
        }

        if($IsEndPoint){
            $EndPoint = New-UDEndpoint -Endpoint $Content -Id $Id
        }

        if($null -ne $Content){
            $CardContent = $Content.Invoke()
        }else{
            $CardContent = $null
        }

        if($null -ne $SecondaryAction){
            $Action = $SecondaryAction.Invoke()
        }else{
            $Action = $null
        }
        
        @{
            type = 'mu-list-item'
            isPlugin = $true
            assetId = $MUAssetId

            id = $Id
            subTitle = $SubTitle
            label = $Label
            onClick = $OnClick
            content = $CardContent
            secondaryAction = $Action
            icon =  $Icon
            source = $Source
            avatarType = $AvatarType
            isButton = $IsButton.IsPresent
            isEndpoint = $IsEndPoint.IsPresent
            refreshInterval = $RefreshInterval
            autoRefresh = $AutoRefresh.IsPresent
            labelStyle = $LabelStyle
            style = $Style
        }
    }
}