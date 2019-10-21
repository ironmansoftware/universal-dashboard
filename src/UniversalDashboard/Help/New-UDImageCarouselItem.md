---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: https://go.microsoft.com/fwlink/?LinkID=217032
schema: 2.0.0
---

# New-UDImageCarouselItem

## SYNOPSIS
Create slide object for the image carousel component

## SYNTAX

```
New-UDImageCarouselItem [[-Text] <String>] [[-BackgroundColor] <DashboardColor>] [[-BackgroundImage] <String>]
 [[-FontColor] <DashboardColor>] [[-BackgroundRepeat] <String>] [[-BackgroundSize] <String>]
 [[-BackgroundPosition] <String>] [[-TitlePosition] <String>] [[-TextPosition] <String>] [[-Id] <String>]
 [[-Title] <String>] [[-Url] <String>] [<CommonParameters>]
```

## DESCRIPTION
Create slide for image carousel component, it support image url that host on the web or in local folders, it have alot of customization options.

## EXAMPLES

### Example 1
```
PS C:\> $Slide3 = @{
            BackgroundImage = 'https://stmed.net/sites/default/files/ultimate-spider-man-wallpapers-27724-2035627.jpg'
            BackgroundRepeat = 'no-repeat'
            BackgroundSize = 'cover'
            BackgroundPosition = '0% 0%'
            BackgroundColor  = '#3f51b5'
            Url  = 'http://Google.co.il'
        }
        New-UDCarousel -items {
            New-UDImageCarouselItem  @Slide3
        }
```

{{ Add example description here }}

## PARAMETERS

### -BackgroundColor
Set slide background color

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BackgroundImage
Set the url for the image it can be web like or local folder

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

### -BackgroundPosition
Set the x and y position that the image will start from.
It should be in %

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BackgroundRepeat
Set if the background should repeat it self or not.
The options are repeat or no-repeat

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BackgroundSize
Set how the image will display in the slide container.
Options are auto,cover,contain

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontColor
Set the color for the title and text parameters

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
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
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text
Add text as sub title for the slide

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

### -TextPosition
Set the position of the text.
options are left,center,right

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
Set the title text for the slide

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TitlePosition
Set the position of the title.
options are left,center,right

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Url
Set the url that will be invoke when the button is click

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 11
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

