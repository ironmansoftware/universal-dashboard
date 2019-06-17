---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: https://github.com/ironmansoftware/universal-dashboard/blob/master/src/UniversalDashboard/Help/New-UDFab.md
schema: 2.0.0
---

# New-UDFab

## SYNOPSIS
Creates a new floating action button.

## SYNTAX

```
New-UDFab [-Id <String>] [-Content] <ScriptBlock> [-ButtonColor <DashboardColor>] [-Icon <FontAwesomeIcons>]
 [-Size <Object>] [-Horizontal] [-onClick <Object>] [<CommonParameters>]
```

## DESCRIPTION
Creates a new floating action button.

## EXAMPLES

### Fab with child items
```
New-UdFab -Icon "plus" -Size "large" -ButtonColor "red" -IconColor 'white' -Content {
    New-UDFabButton -Icon address_book -ButtonColor 'blue' -IconColor 'white'
}
```

Creates a large, red floating action button with a plus icon.

## PARAMETERS

### -ButtonColor
The color of the button.

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

### -Content
The content of the button. These should be other buttons. Use New-UDFabButton to craete sub-buttons.

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

### -Horizontal
Whether the button should open horizontally.

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
The icon to show in the button. 

```yaml
Type: FontAwesomeIcons
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The Id of this element. 

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

### -Size
The size of this button. 

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 
Accepted values: Small, Large

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -onClick
A script block or an endpoint created with New-UDElement to handle event clicks.

```yaml
Type: Object
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

