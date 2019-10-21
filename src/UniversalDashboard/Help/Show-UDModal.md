---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: https://go.microsoft.com/fwlink/?LinkID=217032
schema: 2.0.0
---

# Show-UDModal

## SYNOPSIS
Shows a modal. 

## SYNTAX

```
Show-UDModal [-BottomSheet] [-FixedFooter] [-Footer <ScriptBlock>] [-Header <ScriptBlock>]
 [-Content <ScriptBlock>] [-BackgroundColor <DashboardColor>] [-FontColor <DashboardColor>] [-Height <String>]
 [-Width <String>] [-Persistent] [<CommonParameters>]
```

## DESCRIPTION
Shows a modal. This can be called from any endpoint.

## EXAMPLES

### Basic Modal
```
New-UDButton -Text "Show Modal" -OnClick {
    Show-UDModal -Header {
        New-UDHeading -Size 4 -Text "Modal"
    } -Content {
        "This is a modal"
    }
}
```

Shows a modal when the button is clicked.

### Bottom Sheet
```
New-UDButton -Text "Show Modal" -OnClick {
    Show-UDModal -Header {
        New-UDHeading -Size 4 -Text "Modal"
    } -Content {
        "This is a modal"
    } -BottomSheet
}
```

Shows a bottom sheet modal.

### Persistent
```
New-UDButton -Text "Show Modal" -OnClick {
    Show-UDModal -Header {
        New-UDHeading -Size 4 -Text "Modal"
    } -Content {
        New-UDButton -Text 'Hide Modal' -OnClick {
            Hide-UDModal
        }
    } -Persistent
}
```

Shows a persistent modal.

### Custom Width
```
New-UDButton -Text "Show Modal" -OnClick {
    Show-UDModal -Header {
        New-UDHeading -Size 4 -Text "Modal"
    } -Content {
        New-UDButton -Text 'Hide Modal' -OnClick {
            Hide-UDModal
        }
    } -Width 1000 -Height 1000
}
```

Shows a custom width modal.

## PARAMETERS

### -BackgroundColor
The background color of the modal. 

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

### -BottomSheet
Whether this is a bottom sheet modal. 

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

### -Content
The content of the modal. 

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FixedFooter
Whether this modal has a fixed footer. 

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

### -FontColor
The font color for items in the modal. 

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

### -Footer
The footer for the modal. 

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Header
The header of the modal. 

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Height
The height of the modal.

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

### -Persistent
Creates a modal that cannot click away from.

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

### -Width
The width of the modal.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

