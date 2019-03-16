---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# Clear-UDElement

## SYNOPSIS
Clears the children of the specified element. 

## SYNTAX

```
Clear-UDElement -Id <String> [-Broadcast] [<CommonParameters>]
```

## DESCRIPTION
Clears the children of the specified element. 

## EXAMPLES

### Example 1
```
PS C:\> Clear-UDElement -Id "chatroom"
```

Clears the chatroom element of all children. 

## PARAMETERS

### -Broadcast
Add the element to all connected clients. If you don't specify this Switch, the element will only be added to whoever is interacting with the website.

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

### -Id
The ID of the element to clear. 

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
