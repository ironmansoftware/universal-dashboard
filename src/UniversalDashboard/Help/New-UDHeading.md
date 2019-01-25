---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# New-UDHeading

## SYNOPSIS
Creates a heading.

## SYNTAX

### Content
```
New-UDHeading [-Id <String>] [-Content <ScriptBlock>] [-Size <Object>] [-Color <DashboardColor>]
 [<CommonParameters>]
```

### Text
```
New-UDHeading [-Id <String>] [-Text <String>] [-Size <Object>] [-Color <DashboardColor>] [<CommonParameters>]
```

## DESCRIPTION
Creates a heading.

## EXAMPLES

### Example 1
```
PS C:\> New-UDHeading -Size 3 -Content { "Header" }
```

Creates the heading "Header" with a size of 3. 

## PARAMETERS

### -Color
Font color for the heading.

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
Content for the heading.

```yaml
Type: ScriptBlock
Parameter Sets: Content
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The ID of this heading.

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
Size of this heading from 1 to 6. 1 is the largest and 6 is the smallest.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 
Accepted values: 1, 2, 3, 4, 5, 6

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text
{{Fill Text Description}}

```yaml
Type: String
Parameter Sets: Text
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

