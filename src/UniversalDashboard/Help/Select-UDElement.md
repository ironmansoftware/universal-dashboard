---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: https://go.microsoft.com/fwlink/?LinkID=217032
schema: 2.0.0
---

# Select-UDElement

## SYNOPSIS
Selects an element. 

## SYNTAX

```
Select-UDElement -ID <String> [<CommonParameters>] -ScrollToElement [Switch]
```

## DESCRIPTION
Selects an element. 

## EXAMPLES

### Example 1
```
PS C:\> Select-UDElement -Id 'textbox' -ScrollToElement
```

Selects the text box with the ID 'textbox' and scrolls to the position on page.

## PARAMETERS

### -ID
The ID of the element to select.

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

### -ScrollToElemenet

```yaml
Type: Switch
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

