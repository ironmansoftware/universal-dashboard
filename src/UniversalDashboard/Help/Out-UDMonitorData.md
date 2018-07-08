---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard
online version: 
schema: 2.0.0
---

# Out-UDMonitorData

## SYNOPSIS
Outputs data for the New-UDMonitor components.

## SYNTAX

```
Out-UDMonitorData [[-Data] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Outputs data for the New-UDMonitor components. The data value should be a single data point. 

## EXAMPLES

### Example 1
```
PS C:\> New-UDMonitor -Type Line -Title "Available Memory" -RefreshInterval 1 -DataPointHistory 100 -Endpoint {
    Get-Counter '\Memory\Available MBytes' | Select-Object -ExpandProperty CounterSamples | Select -ExpandProperty CookedValue | Out-UDMonitorData
}
```

Outputs the available memory on the current machine. 

## PARAMETERS

### -Data
A single data point on the running monitor.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
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

