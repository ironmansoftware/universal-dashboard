---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# New-UDSelect

## SYNOPSIS
Creates a select.

## SYNTAX

```
New-UDSelect [[-Id] <String>] [[-Option] <ScriptBlock>] [-MultiSelect] [[-Label] <String>] [-BrowserDefault]
 [-Icons] [[-OnChange] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Creates a select.

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

### -BrowserDefault
Whether to display the browser default select rather than the Materialize select.

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

### -Icons
Whether this select displays icons.

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
The ID of this select.

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
The label to display within this select.

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

### -MultiSelect
Whether this is a multi-select.

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

### -OnChange
A script block to invoke when this select changes. The selected value is available in the script block in the $EventData variable.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Option
Options to display in this select. This should be generated with the New-UDSelectOption cmdlet.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
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
