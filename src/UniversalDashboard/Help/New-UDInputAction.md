---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# New-UDInputAction

## SYNOPSIS
Returns an action to execute after processing input with New-UDInput.

## SYNTAX

### toast
```
New-UDInputAction -Toast <String> [-Duration <Int32>] [-ClearInput] [<CommonParameters>]
```

### redirect
```
New-UDInputAction -RedirectUrl <String> [<CommonParameters>]
```

### content
```
New-UDInputAction -Content <Component[]> [<CommonParameters>]
```

## DESCRIPTION
Returns an action to execute after processing input with New-UDInput. This cmdlet is used within the Endpoint parameter of New-UDInput.

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

### -ClearInput
Clears the input fields after a toast message. 

```yaml
Type: SwitchParameter
Parameter Sets: toast
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Content
Specify one or more components (New-UDCard, New-UDChart, etc) to replace the input form with.

```yaml
Type: Component[]
Parameter Sets: content
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Duration
The number of milliseconds to display the toast message.

```yaml
Type: Int32
Parameter Sets: toast
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RedirectUrl
A local or remote URL to redirect to after processing input. 

```yaml
Type: String
Parameter Sets: redirect
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Toast
A message to toast the user with. 

```yaml
Type: String
Parameter Sets: toast
Aliases: 

Required: True
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

