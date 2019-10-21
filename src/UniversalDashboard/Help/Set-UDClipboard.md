---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: https://go.microsoft.com/fwlink/?LinkID=217032
schema: 2.0.0
---

# Set-UDClipboard

## SYNOPSIS
Sets the contents of the clipboard.

## SYNTAX

```
Set-UDClipboard -Data <String> [-toastOnSuccess] [-toastOnError] [<CommonParameters>]
```

## DESCRIPTION
Sets the contents of the clipboard.

## EXAMPLES

### Example 1
```
PS C:\> Set-UDClipboard -Data 'Some text'
```

Sets 'Some text' into the clipboard.

## PARAMETERS

### -Data
The text to set into the clipboard.

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

### -toastOnError
Creates a toast when it fails to set the clipboard text.

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

### -toastOnSuccess
Creates a toast when it succeeds to set the clipboard text.

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

