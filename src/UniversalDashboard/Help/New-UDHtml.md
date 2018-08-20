---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# New-UDHtml

## SYNOPSIS
Creates a section of HTML.

## SYNTAX

```
New-UDHtml [-Markup] <String> [<CommonParameters>]
```

## DESCRIPTION
Creates a section of HTML.

## EXAMPLES

### Example 1
```
PS C:\> New-UDHtml -Markup '<h3>Hi! I'm HTML</h3>'
```

Creates header text in the dashboard.

## PARAMETERS

### -Markup
The HTML markup to create.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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
