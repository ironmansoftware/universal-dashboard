---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# Enable-UDLogging

## SYNOPSIS
Enables logging for Universal Dashboard.

## SYNTAX

```
Enable-UDLogging [-Level <String>] [-FilePath <String>] [-Console] [<CommonParameters>]
```

## DESCRIPTION
Enables logging for Universal Dashboard.

## EXAMPLES

### Example 1
```
PS C:\> Enable-UDLogging -Level Debug -FilePath .\log.txt -Console
```

Outputs Debug messages and above to the log.txt file and the console. 

## PARAMETERS

### -Console
Logs to the console. 

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

### -FilePath
Logs to the specified file. 

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

### -Level
The log level to log. Will log the level specified and above. 

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: Error, Warning, Info, Debug

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

