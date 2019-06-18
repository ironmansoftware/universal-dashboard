---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: https://github.com/ironmansoftware/universal-dashboard/blob/master/src/UniversalDashboard/Help/New-UDCheckbox.md
schema: 2.0.0
---

# New-UDCheckbox

## SYNOPSIS
Creates a checkbox.

## SYNTAX

```
New-UDCheckbox [[-Id] <String>] [[-Label] <Object>] [-Checked] [-FilledIn] [-Disabled] [[-OnChange] <Object>]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a checkbox.

## EXAMPLES

### Checked
```
New-UDCheckbox -Label "Checkbox" -Checked
```

A checked checkbox

### Disabled
```
New-UDCheckbox -Label "Checkbox" -Disabled
```

A disabled checkbox

### OnChange
```
New-UDCheckbox -Label "Checkbox" -OnChange {
    Show-UDToast -Message $EventData
}
```
Displays a toast message when clicked.

## PARAMETERS

### -Checked
Whether the default value of the checkbox is checked.

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

### -Disabled
Whether the checkbox is disabled.

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

### -FilledIn
Applies a filled in style to checkbox.

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

### -Id
The ID for this checkbox.

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

### -Label
The text to display next to the checkbox.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OnChange
A script block to invoke when the value of the checkbox changes. Use the $EventData variable to get the value of the checkbox in the script block.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
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

