---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard
online version: 
schema: 2.0.0
---

# New-UDLayout

## SYNOPSIS
Creates a new simple, column-based layout.

## SYNTAX

```
New-UDLayout [-Columns] <Int32> [-Content] <ScriptBlock> [<CommonParameters>]
```

## DESCRIPTION
Creates a new simple, column-based layout.

## EXAMPLES

### Example 1
```
PS C:\> New-UDLayout -Columns 3 {
	New-UDCard
	New-UDCard
	New-UDCard
}
```

Creates a three column layout with one row of cards.

### Example 2
```
PS C:\> New-UDLayout -Columns 3 {
	New-UDCard
	New-UDCard
	New-UDCard
	New-UDCard
	New-UDCard
	New-UDCard
}
```

Creates a three column layout with two rows of cards.

## PARAMETERS

### -Columns
The number of columns in the layout.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Content
The content of the layout.

```yaml
Type: ScriptBlock
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

