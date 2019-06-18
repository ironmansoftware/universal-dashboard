---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard
online version: 
schema: 2.0.0
---

# New-UDLoginPage

## SYNOPSIS
Creates a new login page. 

## SYNTAX

```
New-UDLoginPage -AuthenticationMethod <AuthenticationMethod[]> [-LoginFormFontColor <DashboardColor>]
 [-LoginFormBackgroundColor <DashboardColor>] [-PageBackgroundColor <DashboardColor>] [-Logo <Element>]
 [-WelcomeText <String>] [-LoadingText <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates a new login page. This enables authentication for a dashboard. This cmdlet is used in conjunction with New-UDDashboard.

## EXAMPLES

### Example 1
```
PS C:\> $LoginPage = New-UDLoginPage -AuthenticationMethod $AuthenticationMethod
```

Creates a new login page with authentication methods.

## PARAMETERS

### -AuthenticationMethod
An array of authentication methods to use. 

```yaml
Type: AuthenticationMethod[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LoadingText
Text to display after the user clicks the login button. This is useful for login proceses that may take a second or notifying users of other actions they may need to take.

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

### -LoginFormBackgroundColor
Color of the login form background. 

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LoginFormFontColor
Login form font color.

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Logo
An image used as a logo on the login page. Use New-UDImage to generate this logo. 

```yaml
Type: Element
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PageBackgroundColor
The login page background color.

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WelcomeText
Text to display above the login.

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

