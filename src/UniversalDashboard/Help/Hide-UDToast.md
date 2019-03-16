---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard.Community
online version: https://go.microsoft.com/fwlink/?LinkID=217032
schema: 2.0.0
---

# Hide-UDToast

## SYNOPSIS
Hides a toast message. 

## SYNTAX

```
Hide-UDToast [-Id] <String> [<CommonParameters>]
```

## DESCRIPTION
Hides a toast mesage. 

## EXAMPLES

### Example 1
```
PS C:\> Hide-UDToast -Id "ToastMessage"
```

Hides the toast message specified by the ID "ToastMessage"

## PARAMETERS

### -Id
The ID of the toast message to hide.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
