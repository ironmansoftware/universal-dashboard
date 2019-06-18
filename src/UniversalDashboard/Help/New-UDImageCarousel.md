---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: https://github.com/ironmansoftware/universal-dashboard/blob/master/src/UniversalDashboard/Help/New-UDImageCarousel.md
schema: 2.0.0
---

# New-UDImageCarousel

## SYNOPSIS
Render image carousel in dashboard

## SYNTAX

```
New-UDImageCarousel [-Items <ScriptBlock>] [-Id <String>] [-ShowIndecators] [-AutoCycle] [-Speed <Int32>]
 [-Width <String>] [-Height <String>] [-FullWidth] [-FixButton] [-ButtonText <String>] [<CommonParameters>]
```

## DESCRIPTION
Add image carousel to UniversalDashboard you can set the carousel to be full screen width and add button that update it href automatic to the url that set for every slide and more..

## EXAMPLES

### Example 1
```
New-UDImageCarousel -Items {
        New-UDImageCarouselItem -BackgroundImage https://i0.wp.com/ironmansoftware.com/wp-content/uploads/2019/01/azure.png -BackgroundRepeat = 'no-repeat' -BackgroundSize = 'cover' -BackgroundColor  = '#3f51b5'
        New-UDImageCarouselItem -BackgroundImage https://i2.wp.com/ironmansoftware.com/wp-content/uploads/2019/01/component.png -BackgroundRepeat = 'no-repeat' -BackgroundSize = 'cover' -BackgroundColor  = '#3f51b5'
        New-UDImageCarouselItem -BackgroundImage https://i1.wp.com/ironmansoftware.com/wp-content/uploads/2019/01/dsl.png -BackgroundRepeat = 'no-repeat' -BackgroundSize = 'cover' -BackgroundColor  = '#3f51b5'
}  -Height 650px -FullWidth -FixButton -ButtonText 'GO TO..' -ShowIndicators
```

Create new image carousel with 3 slides and with fixed button on every slide.

## PARAMETERS

### -AutoCycle
Automaticly change sildes

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

### -ButtonText
The text that will display on the button

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

### -FixButton
Add button on every slide

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

### -FullWidth
Will make the carousel width size to be 100%, insted of small square images.

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

### -Height
Set the main carousel container height

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

### -Id
Set id for the carousel component, if not specified the value will be auto generated.

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
The items (slides) to add to the carousel container, the items need to be created using New-UDImageCarouselItem cmdlet 

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

### -ShowIndicators
Will display dot for every slide in the bottom of the carousel

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

### -Speed
Set how long a slide should be display. 

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Width
Set the width of the carousel container

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

