---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard
online version: 
schema: 2.0.0
---

# New-UDModal

## SYNOPSIS
Creates a modal.

## SYNTAX

```
New-UDModal [[-Id] <String>] [[-Header] <String>] [[-Content] <ScriptBlock>] [<CommonParameters>]
```

## DESCRIPTION
Creates a modal.

## EXAMPLES

### Example 1
```
PS C:\> New-UDModal -Header "My modal" -Content {
    New-UDCard -Title "My Content"
}
```

Creates a modal with the header My modal and a card as the content.

## PARAMETERS

### -Content
The content of the modal.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Header
The header for the modal.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The ID of the modal.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 0
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

