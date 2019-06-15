---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# New-UDRadio

## SYNOPSIS
Creates a radio.

## SYNTAX

```
New-UDRadio [[-Id] <String>] [[-Label] <String>] [-WithGap] [-Disabled] [[-OnChange] <Object>]
 [[-Group] <String>] [-Checked] [<CommonParameters>]
```

## DESCRIPTION
Creates a radio. Radios can be used to select between a set of items. They should be grouped together.

## EXAMPLES

### Example 1
```
PS C:\> New-UDRadio -Label 'Option 1' -Group 'Group 1'
PS C:\> New-UDRadio -Label 'Option 2' -Group 'Group 1'
PS C:\> New-UDRadio -Label 'Option 3' -Group 'Group 1'
```

Creates three options for a radio group.

## PARAMETERS

### -Checked
{{Fill Checked Description}}

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
Whether this radio is disabled.

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

### -Group
The group for this radio. Only one option for a group can be selected.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The ID for this radio.

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
The label for this radio.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OnChange
A script block to invoke when this radio is changed. The event data will be available via the $EventData variable in the script block.

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

### -WithGap
Provides a gap style for the radio button.

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

