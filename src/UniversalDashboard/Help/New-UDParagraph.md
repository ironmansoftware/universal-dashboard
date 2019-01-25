---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# New-UDParagraph

## SYNOPSIS
Creates a new paragraph block.

## SYNTAX

### content
```
New-UDParagraph [-Content <ScriptBlock>] [-Color <DashboardColor>] [<CommonParameters>]
```

### text
```
New-UDParagraph [-Text <String>] [-Color <DashboardColor>] [<CommonParameters>]
```

## DESCRIPTION
Creates a new paragraph block.

## EXAMPLES

### Example 1
```
PS C:\> New-UDParagraph -Content {
    "This is a paragraph of text"
}
```

Creates a new paragraph of text.

## PARAMETERS

### -Color
Text color for this paragraph.

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
The content for this paragraph. 

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

### -Text
Text for this paragraph.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

