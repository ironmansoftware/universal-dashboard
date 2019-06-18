---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: https://github.com/ironmansoftware/universal-dashboard/blob/master/src/UniversalDashboard/Help/New-UDCard.md
schema: 2.0.0
---

# New-UDCard

## SYNOPSIS
Creates a new Material Design card. 

## SYNTAX

### text (Default)
```
New-UDCard [-Id <String>] [-Title <String>] [-Text <String>] [-BackgroundColor <DashboardColor>]
 [-FontColor <DashboardColor>] [-Links <Link[]>] [-Image <Element>] [-Reveal <ScriptBlock>]
 [-RevealTitle <String>] [-Size <String>] [-Language <String>] [-TextAlignment <String>] [-TextSize <String>]
 [-Watermark <FontAwesomeIcons>] [-Horizontal] [<CommonParameters>]
```

### content
```
New-UDCard [-Id <String>] [-Title <String>] [-Content <ScriptBlock>] [-Text <String>]
 [-BackgroundColor <DashboardColor>] [-FontColor <DashboardColor>] [-Links <Link[]>] [-Image <Element>]
 [-Reveal <ScriptBlock>] [-RevealTitle <String>] [-Size <String>] [-Language <String>]
 [-TextAlignment <String>] [-TextSize <String>] [-Watermark <FontAwesomeIcons>] [-Horizontal]
 [<CommonParameters>]
```

### endpoint
```
New-UDCard [-Id <String>] [-Title <String>] [-Endpoint <Object>] [-Text <String>]
 [-BackgroundColor <DashboardColor>] [-FontColor <DashboardColor>] [-Links <Link[]>] [-Image <Element>]
 [-Reveal <ScriptBlock>] [-RevealTitle <String>] [-Size <String>] [-Language <String>]
 [-TextAlignment <String>] [-TextSize <String>] [-Watermark <FontAwesomeIcons>] [-Horizontal]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a new Material Design card. Provides a way to show information and links.

## EXAMPLES

### Basic Card
```
New-UDCard -Title "Details" -Text "These are some details about my dashboard" -Links @(New-UDLink -Url http://www.google.com -Text "Google a little more info")
```

Creates a new card with a title, some text and a link.

### Image Card
```
New-UDCard -Title 'Card Title' -Image (New-UDImage -Url 'https://i1.wp.com/ironmansoftware.com/wp-content/uploads/2019/01/login.png') -Content {
    'I am a very simple card. I am good at containing small bits of information. I am convenient because I require little markup to use effectively.'
} -Links @(
    New-UDLink -Text 'This is a link' -Url '#!'
    New-UDLink -Text 'This is a link' -Url '#!'
) -Size 'small'
```

Creates a card with an image.

### Reveal Card
```
New-UDCard -Title 'Card Title' -Image (New-UDImage -Url 'https://i1.wp.com/ironmansoftware.com/wp-content/uploads/2019/01/login.png' -Attributes @{className = 'activator'}) -Content {
    'Here is some basic text'
} -Reveal {
    "Here is some more information about this product that is only revealed once clicked on."
} -RevealTitle 'Reveal Title' -Size 'small'
```

Creates a card that you can click to reveal more information.

## PARAMETERS

### -BackgroundColor
The background color of the card. 

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
Allows for putting any content within a card. Best used with New-UDElement.

```yaml
Type: ScriptBlock
Parameter Sets: content
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Endpoint
An endpoint to retrieve the contents of the card from.

```yaml
Type: Object
Parameter Sets: endpoint
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontColor
The font color of the card.

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

### -Horizontal
{{Fill Horizontal Description}}

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
The ID of the card. 

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

### -Image
Image to display within the card. 

```yaml
Type: Element
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Language
If the language is specified, the card text will be highlighted in that programming language.

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

### -Links
Links to add to the action portion of the card. 

```yaml
Type: Link[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Reveal
Content of the reveal section of the card. When clicked, the card will slide up revealing this content.

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

### -RevealTitle
The title of the card after the reveal has been shown. 

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
The size of the card.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: small, medium, large

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text
Text to include in the body of the card.

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

### -TextAlignment
{{Fill TextAlignment Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: left, center, right

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TextSize
{{Fill TextSize Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: Small, Medium, Large

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
A title to include at the top of the card.

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

### -Watermark
A watermark for the card. 

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

