---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# Sync-UDElement

## SYNOPSIS
Forces an element to update its state. 

## SYNTAX

```
Sync-UDElement -Id <String[]> [-Broadcast] [<CommonParameters>]
```

## DESCRIPTION
Forces an element to update its state.  This only works with elements (charts, monitors, counters, elements, etc) that have used the Endpoint parameter and not the content parameter.

## EXAMPLES

### Example 1
```
PS C:\>  New-UDButton -Text "Button" -Id "Button" -OnClick {
                $Session:Clicked = $true
                Sync-UDElement -Id 'Counter'
            }

            New-UDCounter -Title "Counter" -Id "Counter" -Endpoint {
                if ($Session:Clicked) {
                    1
                } else {
                    0
                }
            }
```

Forces the counter to update its state when the button is clicked. 

## PARAMETERS

### -Broadcast
Whether to broadcast this change to all connected clients. 

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
The element to force to update .

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
