---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard.Community
online version: https://go.microsoft.com/fwlink/?LinkID=217032
schema: 2.0.0
---

# Invoke-UDRedirect

## SYNOPSIS
Redirects a user to a URL. 

## SYNTAX

```
Invoke-UDRedirect -Url <String> [-OpenInNewWindow] [<CommonParameters>]
```

## DESCRIPTION
Redirects a user to a URL. This cmdlet can be called from any endpoint.

## EXAMPLES

### Example 1
```
PS C:\> New-UDButton -Text "Redirect to Google" -OnClick {
    Invoke-UDRedirect -Url "https://www.google.com"
}
```

Redirects the user to Google.

## PARAMETERS

### -OpenInNewWindow
Opens the URL in a new window. 

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

### -Url
The URL to redirect the user to. 

```yaml
Type: String
Parameter Sets: (All)
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
