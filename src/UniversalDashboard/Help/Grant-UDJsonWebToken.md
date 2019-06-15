---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard
online version: 
schema: 2.0.0
---

# Grant-UDJsonWebToken

## SYNOPSIS
Grants a JSON web token for the specified user or application.

## SYNTAX

### user
```
Grant-UDJsonWebToken [-Audience <String>] [-Issuer <String>] [-SigningKey <String>] -UserName <String>
 [-Subject <String>] [-Expiry <DateTime>] [<CommonParameters>]
```

### app
```
Grant-UDJsonWebToken [-Audience <String>] [-Issuer <String>] [-SigningKey <String>] -Application <String>
 [-Subject <String>] [-Expiry <DateTime>] [<CommonParameters>]
```

## DESCRIPTION
Grants a JSON web token for the specified user. You can adjust the JSON web token parameters in addition to specifying the user.

## EXAMPLES

### Example 1
```
PS C:\> $Token = Grant-UDJsonWebToken -UserName "Adam"
PS C:\> Invoke-RestMethod http://localhost/api/resource -Headers @{ Authorization = "Bearer $Token"}
```

Creates a JSON web token for Adam and then uses that token to access a protected resource on the API.

## PARAMETERS

### -Application
The name of the application granted the token.

```yaml
Type: String
Parameter Sets: app
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Audience
The aud (audience) claim identifies the recipients that the JWT is intended for.  

See: https://self-issued.info/docs/draft-ietf-oauth-json-web-token.html#rfc.section.4.1.3

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

### -Expiry
The exp (expiration time) claim identifies the expiration time on or after which the JWT MUST NOT be accepted for processing. 

See: https://self-issued.info/docs/draft-ietf-oauth-json-web-token.html#rfc.section.4.1.4

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Issuer
The iss (issuer) claim identifies the principal that issued the JWT. 

See: https://self-issued.info/docs/draft-ietf-oauth-json-web-token.html#rfc.section.4.1.1

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

### -SigningKey
The secret key used to sign the web token. This should be treated as a password.

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

### -Subject
The sub (subject) claim identifies the principal that is the subject of the JWT. 

See: https://self-issued.info/docs/draft-ietf-oauth-json-web-token.html#rfc.section.4.1.2

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

### -UserName
The user name of the user the token is granted to.

```yaml
Type: String
Parameter Sets: user
Aliases: 

Required: True
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

