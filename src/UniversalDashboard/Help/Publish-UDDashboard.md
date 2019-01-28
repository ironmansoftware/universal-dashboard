---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# Publish-UDDashboard

## SYNOPSIS
Publishes the dashboard as service.

## SYNTAX

```
Publish-UDDashboard [-Manual] -DashboardFile <String> [-TargetPath <String>] [<CommonParameters>]
```

## DESCRIPTION
Publishes the dashboard as service.

## EXAMPLES

### Example 1
```
PS C:\> Publish-UDDashboard -DashboardFile .\dashboard.ps1 -TargetPath C:\UDService\
```

Publishes the Dashboard.ps1 file as a service and copies all the files into the UDService folder.

## PARAMETERS

### -DashboardFile
The dashboard to publish.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Manual
Whether the service is manually started on system startup.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetPath
The target path to copy the service files to. This will contain the dashboard and all the UD module files. 

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

