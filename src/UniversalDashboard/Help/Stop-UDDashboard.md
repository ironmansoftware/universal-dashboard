---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# Stop-UDDashboard

## SYNOPSIS
Stops a dashboard returned by Start-UDDashboard.

## SYNTAX

### ByServer
```
Stop-UDDashboard [-Server] <Server> [<CommonParameters>]
```

### ByName
```
Stop-UDDashboard [-Name] <String> [<CommonParameters>]
```

### ByPort
```
Stop-UDDashboard [-Port] <Int32> [<CommonParameters>]
```

## DESCRIPTION
Stops a dashboard returned by Start-UDDashboard.

## EXAMPLES

### Example 1
```
PS C:\> $DashboardServer = Start-UDDashboard -Content { New-UDDashboard {} }
PS C:\> Stop-UDDashboard -Server $DashboardServer
```

Stops a dashboard returned by Start-UDDashboard.

### Example 2
```
PS C:\> Stop-UDDashboard -Name "MyDashboard"
```

Stops the dashboard named "MyDashboard".

## PARAMETERS

### -Name
Name of the dashboard to stop.

```yaml
Type: String
Parameter Sets: ByName
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Port
Stops the dashboard by port number.

```yaml
Type: Int32
Parameter Sets: ByPort
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Server
The dashboard server to stop. This is returned by Start-UDDashboard.

```yaml
Type: Server
Parameter Sets: ByServer
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
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

