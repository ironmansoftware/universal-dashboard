---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# Set-UDCookie

## SYNOPSIS
Sets a response cookie in the UD response. 

## SYNTAX

```
Set-UDContentType -Name <string> -Value <string> [-CookieOptions] <Microsoft.AspNetCore.Http.CookieOptions> [<CommonParameters>]
```

## DESCRIPTION
Sets a response cookie in the UD response. 

## EXAMPLES

### Example 1
```
PS C:\> Set-UDCookie -Name 'MyCookie' -Value 'CookieValue'
```

Sets a response cookie. 

## PARAMETERS

### -Name
The name of the cookie

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
The value of the cookie

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CookieOptions
Additional cookie options to set. 

```yaml
Type: Microsoft.AspNetCore.Http.CookieOptions
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

