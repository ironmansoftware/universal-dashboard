---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard
online version: 
schema: 2.0.0
---

# Get-UDRestApi

## SYNOPSIS
Returns all running REST API servers.

## SYNTAX

```
Get-UDRestApi [-Name <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns all running REST API servers.

## EXAMPLES

### Example 1
```
PS C:\> Get-UDRestApi -Name "RestApi1"
```

Returns the REST API server named RestApi1.

## PARAMETERS

### -Name
The name of the REST API server to return.

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

