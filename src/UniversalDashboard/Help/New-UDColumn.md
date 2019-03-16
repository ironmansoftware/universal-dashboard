---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# New-UDColumn

## SYNOPSIS
Creates a new column in the dashboard. This should be called within a New-UDRow's content or endpoint block. 

## SYNTAX

### content (Default)
```
New-UDColumn [-Id <String>] [-SmallSize <Int32>] [-LargeSize <Int32>] [-MediumSize <Int32>]
 [-SmallOffset <Int32>] [-MediumOffset <Int32>] [-LargeOffset <Int32>] [[-Content] <ScriptBlock>]
 [<CommonParameters>]
```

### endpoint
```
New-UDColumn [-Id <String>] [-SmallSize <Int32>] [-LargeSize <Int32>] [-MediumSize <Int32>]
 [-SmallOffset <Int32>] [-MediumOffset <Int32>] [-LargeOffset <Int32>] [-Endpoint <Object>] [-AutoRefresh]
 [-RefreshInterval <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Creates a new column in the dashboard. This should be called within a New-UDRow. Columns can be size 1-12. Size 12 would span the entire width of the page. 
If you had 12 size 1 columns, each would take up 1/12 of the page and they would be equally spaced along the row.

## EXAMPLES

### Example 1
```
PS C:\> New-UDRow -Columns { 
	New-UDColumn -Size 12 -Content  {
		New-UDChart ...
	}
}
```

Creats a new row with a column that spans the entire page. 

### Example 2
```
PS C:\> New-UDRow -Columns { 
	New-UDColumn -Size 4 -Content {
		New-UDChart ...
	}
	New-UDColumn -Size 4 -Content {
		New-UDChart ...
	}
	New-UDColumn -Size 4 -Content {
		New-UDChart ...
	}
}
```

Creates a new row with 3 columns that take up 1/3 of the page width each. 

## PARAMETERS

### -AutoRefresh
Whether this column should auto-refresh. The default interval is every 5 seconds. 

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

### -Content
The content of the column. This can be one or more controls. It can also be other another row of columns.

```yaml
Type: ScriptBlock
Parameter Sets: content
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Endpoint
The endpoint to call to generate the content of this column. This is mutually exclusive with Content.

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

### -Id
The ID of the column. This is the ID set in the HTML markup. 

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

### -LargeOffset
The number of columns to offset this column on large screens. Large screens are over 992px wide.

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

### -LargeSize
The size of this column on large screens. Large screens are over 992px wide.

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

### -MediumOffset
The number of columns to offset this column on medium screens. Medium screens are over 600px and less than 992px wide.

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

### -MediumSize
The size of this column on medium screens. Medium screens are over 600px and less than 992px wide.

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

### -RefreshInterval
How often this column refreshes.

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

### -SmallOffset
The number of columns to offset this column on small screens. Small screens are under 600px wide.

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

### -SmallSize
The size of this column on small screens. Small screens are under 600px wide.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Size

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
