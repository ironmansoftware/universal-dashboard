---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version:https://github.com/ironmansoftware/universal-dashboard/blob/master/src/UniversalDashboard/Help/New-UDTabContainer.md
schema: 2.0.0
---

# New-UDTabContainer

## SYNOPSIS
Creates a tab container.

## SYNTAX

```
New-UDTabContainer -Tabs <ScriptBlock> [-Id <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates a tab container. Use New-UDTab to create tabs within the tab container.

## EXAMPLES

### Basic Tabs
```powershell
New-UDTabContainer -Tabs {
    New-UDTab -Text 'Tab 1' -Content { New-UDHeading -Text 'Tab 1 Content' }
    New-UDTab -Text 'Tab 2' -Content { New-UDHeading -Text 'Tab 2 Content' }
    New-UDTab -Text 'Tab 3' -Content { New-UDHeading -Text 'Tab 3 Content' }
}
```

Creates a tab container with 3 tabs.

## PARAMETERS

### -Id
ID of this component.

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

### -Tabs
The tabs for this container. Use New-UDTab to create the tabs.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
