---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: https://go.microsoft.com/fwlink/?LinkID=217032
schema: 2.0.0
---

# New-UDEndpointInitialization

## SYNOPSIS
New-UDEndpointInitialization is used to configure the runspaces that Universal Dashboard uses to run Endpoints.

## SYNTAX

```
New-UDEndpointInitialization [-Variable <String[]>] [-Module <String[]>] [-Function <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION
New-UDEndpointInitialization is used to configure the runspaces that Universal Dashboard uses to run Endpoints. The cmdlet creates a InitialSessionState object to automatically import variables, functions and modules. You can further customize this object to using the properties and methdos of the InitialSessionState class.

For more information, visit: https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.runspaces.initialsessionstate?view=powershellsdk-1.1.0

## EXAMPLES

### Example 1
```
PS C:\> $MyVariable = "Test"
PS C:\> $EI = New-UDEndpointInitialization -Variable "MyVariable"
PS C:\> $Dashboard = New-UDDashboard -Title "EI" -Content {} -EndpointInitialization $EI
```

Initializes the runspaces with the $MyVariable variable. 

### Example 2
```
PS C:\> $MyVariable = "Test"
PS C:\> $MyOtherVariable = "Test2"
PS C:\> $EI = New-UDEndpointInitialization -Variable @("MyVariable", "MyOtherVariable")
PS C:\> $Dashboard = New-UDDashboard -Title "EI" -Content {} -EndpointInitialization $EI
```

Initializes the runspaces with the $MyVariable and $MyOtherVariable variables. 

### Example 3
```
PS C:\> function Get-Stuff {}
PS C:\> $EI = New-UDEndpointInitialization -Function "Get-Stuff"
PS C:\> $Dashboard = New-UDDashboard -Title "EI" -Content {} -EndpointInitialization $EI
```

Initializes the runspaces with the Get-Stuff function.

### Example 4
```
PS C:\> $EI = New-UDEndpointInitialization -Module "HyperV"
PS C:\> $Dashboard = New-UDDashboard -Title "EI" -Content {} -EndpointInitialization $EI
```

Initializes the runspaces with the HyperV module.

### Example 5
```
PS C:\> $EI = New-UDEndpointInitialization 
PS C:\> $EI.StartupScripts.Add("C:\test.ps1")
PS C:\> $Dashboard = New-UDDashboard -Title "EI" -Content {} -EndpointInitialization $EI
```

Initializes the runspaces with a startup script. 

## PARAMETERS

### -Function
Functions to import by default into the runspaces used for endpoints.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Module
Modules to import by default into the runspaces used for endpoints.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Variable
Variables to import by default into the runspaces used for endpoints.

```yaml
Type: String[]
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

