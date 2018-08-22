---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# Out-UDTableData

## SYNOPSIS
Outputs data as a table.

## SYNTAX

```
Out-UDTableData [-Data] <Object> [-Property] <String[]> [[-DateTimeFormat] <String>] [<CommonParameters>]
```

## DESCRIPTION
Outputs data as a table.

## EXAMPLES

### Example 1
```
PS C:\>  New-UDTable -Title "Process Ids" -Header @("Name", "Process Id") -Endpoint {
    Get-Process -Name Chrome | Out-UDTableData -Property @("name", "id")
}
```

Outputs data from Get-Process as a table. Selects the Name and ID property from each item.

## PARAMETERS

### -Data
The data to show in the table. 

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -DateTimeFormat
The DateTime format for cells in this table. 

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

### -Property
The properties, or columns, to display in the table. Should match the -Header parameter of New-UDTable.

```yaml
Type: String[]
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

### System.Object

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
