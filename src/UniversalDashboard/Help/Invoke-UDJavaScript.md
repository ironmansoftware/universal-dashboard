---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: https://go.microsoft.com/fwlink/?LinkID=217032
schema: 2.0.0
---

# Invoke-UDJavaScript

## SYNOPSIS
Execute javascript on client.

## SYNTAX

```
Invoke-UDJavaScript -Javascript <String> [<CommonParameters>]
```


## DESCRIPTION
Executes specified javascript on the client.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-UDJavaScript -JavaScript 'alert("hello world");'
```

Executes the "alert" function of Javascript on the client, and alerts the user with "hello world".

## PARAMETERS

### -JavaScript
The javascript "codeblock" in string format.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

