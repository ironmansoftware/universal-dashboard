---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard
online version: 
schema: 2.0.0
---

# Stop-UDRestApi

## SYNOPSIS
Stops a REST API server.

## SYNTAX

### ByServer
```
Stop-UDRestApi [-Server] <Server> [<CommonParameters>]
```

### ByName
```
Stop-UDRestApi [-Name] <String> [<CommonParameters>]
```

## DESCRIPTION
Stops a REST API server started with Start-UDRestApi

## EXAMPLES

### Example 1
```
PS C:\> Get-UDRestApi | Stop-UDRestApi
```

Stops all running REST API servers.

## PARAMETERS

### -Name
The name of the REST API server to stop.

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

### -Server
The server object to stop. This is returned by Get-UDRestApi and Start-UDRestApi.

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

### UniversalDashboard.Server

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

