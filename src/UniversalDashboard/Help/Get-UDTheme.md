---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# Get-UDTheme

## SYNOPSIS
Returns the pre-defined themes for Universal Dashboard.

## SYNTAX

```
Get-UDTheme [[-Name] <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns the pre-defined themes for Universal Dashboard.

## EXAMPLES

### Example 1
```
PS C:\> $Themes = Get-UDTheme
```

Returns all the themes for Universal Dashboard.

### Example 2
```
PS C:\> $Theme = Get-UDTheme -Name 'Azure'
```

Returns the Azure theme for Universal Dashboard.

## PARAMETERS

### -Name
The name of the theme to return.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
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

