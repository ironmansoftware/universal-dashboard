---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# New-UDInput

## SYNOPSIS
Creates an input card on the dashboard to accept user input. 

## SYNTAX

```
New-UDInput [-Title <String>] [-SubmitText <String>] [-BackgroundColor <DashboardColor>]
 [-FontColor <DashboardColor>] -Endpoint <ScriptBlock> [-Content <ScriptBlock>] [-Validate]
 [-ArgumentList <Object[]>] [-Id <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates an input card on the dashboard to accept user input. The fields for the input are defined by the param block of the endpoint.

## EXAMPLES

### Example 1
```
PS C:\> New-UDInput -Title "User Information" -Endpoint {
	param($FirstName, $LastName, $Address, $PhoneNumber)

	Invoke-RestMethod http://www.myserver/api/user -Method POST -Body @{
		FirstName = $FirstName
		LastName = $LastName
		Address = $Address
		PhoneNumber = $PhoneNumber
	}

	New-UDInputAction -Toast "Record saved!"
}
```

Accepts user input and sends the data to another server. The endpoint then returns a toast message to the client.

## PARAMETERS

### -ArgumentList
{{Fill ArgumentList Description}}

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BackgroundColor
The background color of the card.

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Content
Specify custom content for a UDInput. If this is specified, the param block in the Endpoint is not used to generate the controls in the input form. This provides additional control over which components show up and what values they posses. Used New-UDInputField to create a new input field.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Endpoint
The endpoint that will be executed when the form is submitted. A param block is requried.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontColor
The font coplor of the card. 

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The ID of the input control. 

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubmitText
The text for the submit button. Defaults to Submit.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
The title of the input card. 

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Validate
{{Fill Validate Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
