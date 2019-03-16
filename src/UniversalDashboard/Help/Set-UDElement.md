---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# Set-UDElement

## SYNOPSIS
Sets the state of an element. 

## SYNTAX

```
Set-UDElement -Id <String> [-Attributes <Hashtable>] [-Content <ScriptBlock>] [-Broadcast] [<CommonParameters>]
```

## DESCRIPTION
Sets the state of an element. If broadcast is specified, all connected users will get the element removed. 

## EXAMPLES

### Example 1
```
PS C:\> Set-UDElement -Id "message" -Attributes @{ 
                                type = "text"
                                value = ''
                                placeholder = "Type a chat message" 
                            }
```

Sets the "message" element to new attributes. 

## PARAMETERS

### -Attributes
The attributes to set. The attriubte hashtable is currently not merged so all attributes sent previously will be overridden. 

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

### -Content
The content of the element to update. Existing content will be replace with the content specified here. 

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The ID of the element to update. 

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
