---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: https://github.com/ironmansoftware/universal-dashboard/blob/master/src/UniversalDashboard/Help/New-UDInput.md
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

### Basic Input
```
New-UDInput -Title "User Information" -Endpoint {
	param($FirstName, $LastName, $Address, $PhoneNumber)

	New-UDInputAction -Toast "Record saved! $FirstName, $LastName, $Address, $PhoneNumber"
}
```

Accepts user input and a toast message to the client.


### Custom Input Fields
```
New-UDInput -Title "User Information" -Content {
    New-UDInputField -Type textbox -Name FirstName -Placeholder 'First Name'
	New-UDInputField -Type textbox -Name LastName -Placeholder 'Last Name'
	New-UDInputField -Type textbox -Name Address -Placeholder 'Address'
	New-UDInputField -Type textbox -Name PhoneNumber -Placeholder 'Phone Number'
	New-UDInputField -Type password -Name Password -Placeholder 'Password'
	New-UDInputField -Type date -Name StartDate -Placeholder 'Start Date'
	New-UDInputField -Type time -Name StartTime -Placeholder 'Start Time'
} -Endpoint {
	param($FirstName, $LastName, $Address, $PhoneNumber, $Password, $StartDate, $StartTime)

	New-UDInputAction -Toast "Record saved! $FirstName, $LastName, $Address, $PhoneNumber, $Password, $StartDate, $StartTime"
}
```

Users custom input fields to configure the form and then sends a toast to the user when the button is clicked.

## PARAMETERS

### -ArgumentList
Arguments to pass to the Endpoint parameter. They are available via the $ArgumentList variable within the endpoint. 

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
Whether or not to enforce client side validation via ValidationAttributes.

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

