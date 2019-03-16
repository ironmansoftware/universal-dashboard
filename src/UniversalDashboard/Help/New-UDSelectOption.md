---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# New-UDSelectOption

## SYNOPSIS
Creates a select option for a select.

## SYNTAX

```
New-UDSelectOption [-Name] <String> [-Value] <String> [-Disabled] [-Selected] [[-Icon] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a select option for a select. This cmdlet is used with New-UDSelect.

## EXAMPLES

### Example 1
```
PS C:\> New-UDSelect -Label "State" -Option {
    New-UDSelectOption -Name "Wisconsin" -Value 1
    New-UDSelectOption -Name "Idaho" -Value 2
    New-UDSelectOption -Name "Washington" -Value 3
} -OnChange {
    $Session:State = $EventData
}
```

Creates a select that allows you to select a state. It calls back to an OnChange endpoint when clicked.

## PARAMETERS

### -Disabled
Whether this option is disabled.

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

### -Icon
An icon to display in this select option.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name to display in the select.

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

### -Selected
Whether this item is selected by default.

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

### -Value
The value of this select option.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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
