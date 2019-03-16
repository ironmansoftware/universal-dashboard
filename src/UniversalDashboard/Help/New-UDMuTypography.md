---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# New-UDMuTypography

## SYNOPSIS
Create new text object

## SYNTAX

### text (Default)
```
New-UDMuTypography [-Id <String>] [-Variant <String>] [-Text <String>] [-Style <Hashtable>]
 [-ClassName <String>] [-Align <String>] [-IsEndPoint] [-GutterBottom] [-NoWrap] [-IsParagraph]
 [<CommonParameters>]
```

### endpoint
```
New-UDMuTypography [-Id <String>] [-Variant <String>] [-Content <ScriptBlock>] [-Style <Hashtable>]
 [-ClassName <String>] [-Align <String>] [-IsEndPoint] [-GutterBottom] [-NoWrap] [-IsParagraph] [-AutoRefresh]
 [-RefreshInterval <Int32>] [<CommonParameters>]
```

## DESCRIPTION
This command will let you generate text object, you can generate the content as static or dynamic.

## EXAMPLES

### Example 1
```powershell
PS C:\> New-UDMuTypography -Variant h5 -Text "Universal Dashboard MaterialUI" -Style @{ color = '#fff' } 
```

Create HTML h5 tag with "Universal Dashboard MaterialUI" as it content and the text color will be white.  

### Example 2
```powershell
PS C:\> New-UDMuTypography -Variant h5 -Content{
                    Get-Date -Format "HH:mm:ss"
                } -IsEndPoint -AutoRefresh -RefreshInterval 1 
```

Create HTML h5 tag with the current time as it content, this element content will be updated every 1 second.   

## PARAMETERS

### -Align
Set the position of the text.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: inherit, left, center, right, justify

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AutoRefresh
Whether to auto refresh the contents of this element.

```yaml
Type: SwitchParameter
Parameter Sets: endpoint
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClassName
Set the HTML class attribute for this element.

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

### -Content
The static content for this HTML node. This can be a string or another element.
If -IsEndpoint is true this content will be An endpoint that is called to load the content of this element.

```yaml
Type: ScriptBlock
Parameter Sets: endpoint
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GutterBottom
If true, the text will have a bottom margin.

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
The ID of the row. This is the HTML markup ID.

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

### -IsEndPoint
Will set the object as endpoint.

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

### -IsParagraph
If true, the text will have a bottom margin.

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

### -NoWrap
If true, the text will not wrap, but instead will truncate with an ellipsis.

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

### -RefreshInterval
The number of seconds between refreshes.

```yaml
Type: Int32
Parameter Sets: endpoint
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Style
The css style to apply

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text
Text for this object

```yaml
Type: String
Parameter Sets: text
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Variant
The text object type.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: h1, h2, h3, h4, h5, h6, subtitle1, subtitle2, body1, body2, caption, button, overline, srOnly, inherit, display4, display3, display2, display1, headline, title, subheading

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
