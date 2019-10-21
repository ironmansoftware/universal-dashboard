---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# New-UDTooltip

## SYNOPSIS
Creates a tooltip around a control.

## SYNTAX

```
New-UDTooltip [[-Id] <String>] [[-Place] <String>] [[-Type] <String>] [[-Effect] <String>]
 [-TooltipContent] <ScriptBlock> [-Content] <ScriptBlock> [<CommonParameters>]
```

## DESCRIPTION
Creates a tooltip around a control.

## EXAMPLES

### A basic tool tip
```
New-UDTooltip -TooltipContent { "Hello, there!" } -Content { 
    New-UDIcon -Icon 'user'
}
```

Creates a basic tool tip

## PARAMETERS

### -Content
The content that is hovered that will display the tooltip.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases: 

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Effect
Float or solid effect

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: float, solid

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Id of the tooltip

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

### -Place
Where to place the tooltip.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: top, bottom, left, right

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TooltipContent
The content within the tooltip

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases: 

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
The style of the tooltype

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: dark, success, warning, error, info, light

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

