---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# New-UDElement

## SYNOPSIS
Create new HTML and JavaScript elements. 

## SYNTAX

### HTML
```
New-UDElement -Tag <String> [-Attributes <Hashtable>] [-Content <ScriptBlock>] [-OnMount <String>]
 [-Endpoint <ScriptBlock>] [-ArgumentList <Object[]>] [-AutoRefresh] [-RefreshInterval <Int32>] [-Id <String>]
 [<CommonParameters>]
```

### JS
```
New-UDElement -JavaScriptPath <String> [-ComponentName <String>] [-ModuleName <String>]
 [-Properties <Hashtable>] [-Endpoint <ScriptBlock>] [-ArgumentList <Object[]>] [-AutoRefresh]
 [-RefreshInterval <Int32>] [-Id <String>] [<CommonParameters>]
```

## DESCRIPTION
Create new HTML and JavaScript elements. Create static and dynamic components.

## EXAMPLES

### Example 1
```
PS C:\> New-UDElement -Tag "a" -Attributes @{
    href = "https://www.google.com"
} -Content {
    "Google"
}
```

Creates a new anchor tag that links to Google.com.

## PARAMETERS

### -ArgumentList
Arguments to pass to the endpoint. They will be available via the $ArgumentList variable.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Attributes
A hashtable of attributes that will be set on the HTML tag.

```yaml
Type: Hashtable
Parameter Sets: HTML
Aliases:

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
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComponentName
The JavaScript component to include.

```yaml
Type: String
Parameter Sets: JS
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Content
The static content for this HTML node. This can be a string or another element.

```yaml
Type: ScriptBlock
Parameter Sets: HTML
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Endpoint
An endpoint that is called to load the content of this element.

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

### -Id
The ID for this element.

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

### -JavaScriptPath
Path to a JavaScript file that contains the JavaScript component to load.

```yaml
Type: String
Parameter Sets: JS
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ModuleName
The name of the JavaScript module.

```yaml
Type: String
Parameter Sets: JS
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OnMount
{{Fill OnMount Description}}

```yaml
Type: String
Parameter Sets: HTML
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Properties
Properties to pass into the JavaScript component.

```yaml
Type: Hashtable
Parameter Sets: JS
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RefreshInterval
The refresh interval on which to reload the content of this element, in seconds. 

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

### -Tag
The HTML tag to render.

```yaml
Type: String
Parameter Sets: HTML
Aliases:

Required: True
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
