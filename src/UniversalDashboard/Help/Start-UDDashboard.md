---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard
online version: 
schema: 2.0.0
---

# Start-UDDashboard

## SYNOPSIS
Starts a dashboard defined by New-UDDashboard.

## SYNTAX

### Dashboard (Default)
```
Start-UDDashboard [-Dashboard <Dashboard>] [-Endpoint <Endpoint[]>] [-Name <String>] [-Port <Int32>] [-Wait]
 [-AutoReload] [-Certificate <X509Certificate2>] [-CertificateFile <String>]
 [-CertificateFilePassword <SecureString>] [-UpdateToken <String>] [-AllowHttpForLogin] [<CommonParameters>]
```

### Content
```
Start-UDDashboard [-Content <ScriptBlock>] [-Endpoint <Endpoint[]>] [-Name <String>] [-Port <Int32>] [-Wait]
 [-AutoReload] [-Certificate <X509Certificate2>] [-CertificateFile <String>]
 [-CertificateFilePassword <SecureString>] [-UpdateToken <String>] [-AllowHttpForLogin] [<CommonParameters>]
```

### DashboardFile
```
Start-UDDashboard [-FilePath <String>] [-Endpoint <Endpoint[]>] [-Name <String>] [-Port <Int32>] [-Wait]
 [-AutoReload] [-Certificate <X509Certificate2>] [-CertificateFile <String>]
 [-CertificateFilePassword <SecureString>] [-UpdateToken <String>] [-AllowHttpForLogin] [<CommonParameters>]
```

## DESCRIPTION
Starts a dashboard defined by New-UDDashboard.

## EXAMPLES

### Example 1
```
PS C:\> Start-UDDashboard -Content {
	New-UDDashboard -Title "Groovy Dashboard" 
}
```

Starts a new dashboard based on the specified ScriptBlock with the title Groovy Dashboard on port 80.

### Example 2
```
PS C:\> $Dashboard = New-UDDashboard -Title "Groovy Dashboard" 
PS C:\> Start-UDDashboard -Dashboard $Dashboard -Port 1000
```

Starts a new dashboard based on the specified dashboard created by New-Dashboard with the title Groovy Dashboard on port 1000.

### Example 3
```
PS C:\> Start-UDDashboard -Name "MyDashboard" -Content {
	New-UDDashboard -Title "Groovy Dashboard" 
}
```

Starts a new dashboard with the name "MyDashboard".

## PARAMETERS

### -AllowHttpForLogin
Allows for HTTP to be used with a LoginPage.

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

### -AutoReload
Reloads the dashboard automatically when changes are made to the script containing the dashboard. The dashboard must be saved as a file. 

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

### -Certificate
The certificate to use encrypt HTTPS traffic. The webserver will listen on HTTPS. 

```yaml
Type: X509Certificate2
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CertificateFile
The certificate file to use encrypt HTTPS traffic. The webserver will listen on HTTPS. 

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

### -CertificateFilePassword
The certificate file password to use encrypt HTTPS traffic. The webserver will listen on HTTPS. 

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Content
A ScriptBlock that calls New-UDDashboard.

```yaml
Type: ScriptBlock
Parameter Sets: Content
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Dashboard
The dashboard to start. This dashboard is created with New-UDDashboard.

```yaml
Type: Dashboard
Parameter Sets: Dashboard
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Endpoint
An array of REST endpoints to expose with this dashboard. They can be generated with New-UDEndpoint.

```yaml
Type: Endpoint[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
The path to a file that returns a dashboard. This file should return a dashboard with New-UDDashboard. 

```yaml
Type: String
Parameter Sets: DashboardFile
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the dashboard.

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

### -Port
The port to use for the dashboard. Defaults to 80.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UpdateToken
A token used to authenticate update requests. 

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

### -Wait
Blocks execution and waits for the web server to run. 

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

