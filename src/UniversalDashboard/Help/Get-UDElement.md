---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# Get-UDElement

## SYNOPSIS
Returns an element from the client. 

## SYNTAX

```
Get-UDElement -Id <String> [<CommonParameters>]
```

## DESCRIPTION
Returns an element from the client. This cmdlet can be used to return changes in state, like the value of a text box. 

## EXAMPLES

### Example 1
```
PS C:\>  $txtMessage = Get-UDElement -Id "message" 
PS C:\> $Message = "$(Get-Date) $User : $($txtMessage.Attributes['value'])"
```

Returns the "message" element from the client and gets the value of the text box and formats it into the message string. 

## PARAMETERS

### -Id
The ID of the element to get.

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

