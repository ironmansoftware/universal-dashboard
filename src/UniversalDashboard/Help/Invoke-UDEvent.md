---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: https://go.microsoft.com/fwlink/?LinkID=217032
schema: 2.0.0
---

# Invoke-UDElement

## SYNOPSIS
Performs a clientside "click" event on the specified id, if the element is clickable.

## SYNTAX

```
Invoke-UDElement -id <String> -event <string> [<CommonParameters>]
```


## DESCRIPTION
Performs a clientside "click" event on the specified id, if the element is clickable.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-UDElement -id "someid" -event "onClick"
```

Performs a clientside "click" event on the specified id, if the element is clickable.

## PARAMETERS

### -id
The id of the event to trigger.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: True
Accept wildcard characters: False
```

### -event
The typeof event to trigger

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: onClick 

Required: True
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

