---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# Get-UDCookie

## SYNOPSIS
Gets a cookie from the HTTP request. 

## SYNTAX

```
Get-UDCookie [[-Name] <String>] [<CommonParameters>]
```

## DESCRIPTION
Gets a cookie from the HTTP request. This cmdlet should be called within endpoints.

## EXAMPLES

### Example 1
```
PS C:\> New-UDInput -Title "Get a cookie" -Endpoint {
param()
	$Cookie = Get-UDCookie -Name "MyCookie"

	New-UDInputAction -Toast $Cookie.Value
}
```

Returns the value of MyCookie as a Toast when the user clicks the submit button. 

## PARAMETERS

### -Name
The name of the cookie to return.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
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
