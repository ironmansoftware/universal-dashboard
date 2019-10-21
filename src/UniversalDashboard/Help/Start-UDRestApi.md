---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# Start-UDRestApi

## SYNOPSIS
Starts a REST API server.

## SYNTAX

```
Start-UDRestApi [-Endpoint <Endpoint[]>] [-Name <String>] [-Port <Int32>] [-Wait]
 [-Certificate <X509Certificate2>] [-CertificateFile <String>] [-CertificateFilePassword <SecureString>]
 [-EndpointInitialization <InitialSessionState>] [-AutoReload] [-PublishedFolder <PublishedFolder[]>] [-Force]
 [-ListenAddress <IPAddress>] [-DisableTelemetry] [<CommonParameters>]
```

## DESCRIPTION
Starts a REST API server. This server consists only of REST endpoints. Unlike Start-UDDashboard, this type of server has no user interface. 

## EXAMPLES

### Example 1
```
PS C:\> Start-UDRestApi -Port 1000 -Endpoint @(
	New-UDEndpoint -Url "user" -Method "GET" -Endpoint {
		@("Adam", "Sarah", "Bill") | ConvertTo-Json
	}
)
Invoke-RestMethod http://localhost:1000/api/user
```

Starts a new REST API with a "user" endpoint that returns Adam, Sarah and Bill as a JSON array.

## PARAMETERS

### -AutoReload
Whether to AutoReload this REST API on changes. 

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
Certificate for HTTPS. 

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
Certificate file for HTTPS.

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
Certificate file password for HTTPS.

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

### -DisableTelemetry
Disables telemetry collection.

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

### -Endpoint
An array of endpoints created with New-UDEndpoint. 

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

### -EndpointInitialization
The initial session state for endpoints of this dashboard. Use New-UDEndpointInitialization to create an object for this parameter.

```yaml
Type: InitialSessionState
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Starts a REST API and stops any servers listening on that port. 

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

### -ListenAddress
The IP Address to listen on.

```yaml
Type: IPAddress
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name of the REST API server.

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
The port the REST API server listens on. 

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

### -PublishedFolder
A collection of published folders. You can generate these folders with Publish-UDFolder.

```yaml
Type: PublishedFolder[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Wait
This causes this cmdlet to block the terminal.

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

