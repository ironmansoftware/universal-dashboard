---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# Get-UDDashboard

## SYNOPSIS
Returns dashboards started with Start-UDDashboard.

## SYNTAX

```
Get-UDDashboard [-Name <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns dashboards started with Start-UDDashboard.

## EXAMPLES

### Example 1
```
PS C:\> Get-UDDashboard
```

Returns all dashboards stared with Start-UDDashboard.

### Example 2
```
PS C:\> Get-UDDashboard -Name "MyDashboard"
```

Returns a dashboard named "MyDashboard" started with Start-UDDashboard.

## PARAMETERS

### -Name
The name of the dashboard. 

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

