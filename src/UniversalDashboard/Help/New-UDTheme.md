---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard
online version: 
schema: 2.0.0
---

# New-UDTheme

## SYNOPSIS
Creates a new theme for a dashboard.

## SYNTAX

```
New-UDTheme [-Name] <String> [-Definition] <Hashtable> [[-Parent] <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates a new theme for a dashboard. Themes can be based on another parent theme.

## EXAMPLES

### Example 1
```
PS C:\> New-UDTheme -Name "Blue" -Definition @{
    UDDashboard = @{
        BackgroundColor = "blue"
    }
}
```

Creates a theme where the background color of the dashboard is blue.

### Example 2
```
PS C:\> New-UDTheme -Name "AzureEx" -Parent Azure -Definition @{
    UDDashboard = @{
        BackgroundColor = "blue"
    }
}
```

Creates a theme where the background color of the dashboard is blue and the rest of the dashboard colors are based on the Azure parent dashboard.

## PARAMETERS

### -Definition
The definition for the dashboard theme.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name of this theme.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Parent
The name of the parent theme. Use Get-UDTheme to get a list of available parent themes.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
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

