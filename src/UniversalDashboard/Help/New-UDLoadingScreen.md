---
external help file: UniversalDashboard.Community-help.xml
online version: https://go.microsoft.com/fwlink/?LinkID=217032
schema: 2.0.0
---

# New-UDLoadingScreen

## SYNOPSIS
Customizations for the loading screen.

## SYNTAX

```
New-UDLoadingScreen [-BackgroundColor <DashboardColor>] [-TextColor <DashboardColor>] [-HideSplash]
 [-Text <String>] [<CommonParameters>]
```

## DESCRIPTION
Customizations for the loading screen.

## EXAMPLES

### Example 1
```
PS C:\> New-UDLoadingScreen -BackgroundColor Blue -TextColor White
```

Updates the loading screen to have a blue background color and a white text color.

## PARAMETERS

### -BackgroundColor
Background color of loading screen.

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

### -HideSplash
Hides the splash screen completely.

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

### -Text
Text to show on the loading screen. 

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

### -TextColor
Text color of loading screen.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

