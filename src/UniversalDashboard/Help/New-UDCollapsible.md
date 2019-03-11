---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# New-UDCollapsible

## SYNOPSIS
Creates a new collapsible. 

## SYNTAX

```
New-UDCollapsible [-Id <String>] [-Items] <ScriptBlock> [-BackgroundColor <DashboardColor>]
 [-FontColor <DashboardColor>] [-Popout] [-Type <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates a new collapsible. Collapsibles are accordion elements that expand when clicked on. They allow you to hide content that is not immediately relevant to the user.

## EXAMPLES

### Example 1
```
PS C:\> New-UDCollapsible -Id "Collapsible" -Items {
                New-UDCollapsibleItem -Title "First" -Icon user -Content {
                    New-UDCard -Title "First"
                } -Active
                New-UDCollapsibleItem -Title "Second" -Icon group -Content {
                    New-UDCard -Title "Second"
                }
                New-UDCollapsibleItem -Title "Third" -Icon user -Content {
                    New-UDCard -Title "Third"
                }
            }
```

Creates a new collapsible with 3 different items. 

## PARAMETERS

### -BackgroundColor
The background color of the collapsible.

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontColor
The font color of the collapsible.

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The ID of this component.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Items
The collapsible items to show in this collapsible.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Popout
The collapsible behaves as a popout rather than sliding. 

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

### -Type
Defines whether multiple items can be expanded. 

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: Expandable, Accordion

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

