---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard
online version: 
schema: 2.0.0
---

# New-UDIFrame

## SYNOPSIS
Creates a new iframe.

## SYNTAX

```
New-UDIFrame [[-Id] <String>] [[-Uri] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Creates a new iframe.

## EXAMPLES

### Example 1
```
PS C:\> New-UDIFrame -Uri https://www.google.com
```

Creates an iframe that embeds Google.

## PARAMETERS

### -Id
The ID of the iframe.

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

### -Uri
The URI of the embedded website.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: False
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

