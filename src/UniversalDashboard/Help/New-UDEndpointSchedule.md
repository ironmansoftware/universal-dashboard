---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard
online version: 
schema: 2.0.0
---

# New-UDEndpointSchedule

## SYNOPSIS
Creates a schedule for an endpoint.

## SYNTAX

### EverySecond
```
New-UDEndpointSchedule -Every <Int32> [-Second] [<CommonParameters>]
```

### EveryMinute
```
New-UDEndpointSchedule -Every <Int32> [-Minute] [<CommonParameters>]
```

### EveryHour
```
New-UDEndpointSchedule -Every <Int32> [-Hour] [<CommonParameters>]
```

### EveryDay
```
New-UDEndpointSchedule -Every <Int32> [-Day] [<CommonParameters>]
```

### Cron
```
New-UDEndpointSchedule [-Cron <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates a schedule for an endpoint.

## EXAMPLES

### Example 1
```
PS C:\> $EndpointSchedule = New-UDEndpointSchedule -Every 10 -Second
PS C:\> $Endpoint = New-UDEndpoint -Schedule $Schedule -Endpoint {
    $Cache:Computers = Get-ADComputer
}
```

Gets a list of computers from Active Directory and stores it in the cache every ten seconds. 

## PARAMETERS

### -Cron
A CRON expression to run the schedule under.

```yaml
Type: String
Parameter Sets: Cron
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Day
Switches the Every value to days.

```yaml
Type: SwitchParameter
Parameter Sets: EveryDay
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Every
Number of time units. 

```yaml
Type: Int32
Parameter Sets: EverySecond, EveryMinute, EveryHour, EveryDay
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Hour
Switches the Every value to hours.

```yaml
Type: SwitchParameter
Parameter Sets: EveryHour
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Minute
Switches the Every value to minutes.

```yaml
Type: SwitchParameter
Parameter Sets: EveryMinute
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Second
Switches the Every value to seconds.

```yaml
Type: SwitchParameter
Parameter Sets: EverySecond
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

