---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard
online version: 
schema: 2.0.0
---

# Remove-UDElement

## SYNOPSIS
Removes an element from the website. 

## SYNTAX

```
Remove-UDElement -Id <String> [-Broadcast] [<CommonParameters>]
```

## DESCRIPTION
Removes an element from the website. If broadcast is specified, all connected users will get the element removed. 

## EXAMPLES

### Example 1
```
PS C:\> Remove-UDElement -Id "chatroom"
```

Removes the chatroom element from the connected clients website. 

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
The ID of the element to remove. 

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

