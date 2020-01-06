---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: https://github.com/ironmansoftware/universal-dashboard/blob/master/src/UniversalDashboard/Help/New-UDTabContainer.md
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
```
New-UDTabContainer -Tabs {
    New-UDTab -Text 'Tab 1' -Content { New-UDHeading -Text 'Tab 1 Content' }
    New-UDTab -Text 'Tab 2' -Content { New-UDHeading -Text 'Tab 2 Content' }
    New-UDTab -Text 'Tab 3' -Content { New-UDHeading -Text 'Tab 3 Content' }
}
```

Creates a tab container with 3 tabs.

### Tab as endpoint
```
New-UDTabContainer -Tabs {

    New-UDTab -Text 'Tab 1' -Content { 
        $number = 0..50 | Get-Random     
        New-UDHeading -Text "Tab $number Content"
    } -IsEndpoint -RefreshWhenActive
    
    New-UDTab -Text 'Tab 2' -Content { 
        $number = 0..50 | Get-Random 
        New-UDHeading -Text "Tab $number Content" 
    } -IsEndpoint

    New-UDTab -Text 'Tab 3' -Content { 
        $number = 0..50 | Get-Random 
        New-UDHeading -Text "Tab $number Content" 
    } -IsEndpoint -RefreshWhenActive
}
```

Creates a tab container with 3 tabs and tab content is an endpoint.

### Tabs with icons and text
```
New-UDTabContainer -Tabs {

    New-UDTab -Text 'Tab 1' -Content { 
        New-UDHeading -Text "Gitkraken Tab"
    } -Icon (New-UDIcon -Icon gitkraken)
    
    New-UDTab -Text 'Tab 2' -Content { 
        New-UDHeading -Text "Github Tab" 
    } -Icon (New-UDIcon -Icon github)

    New-UDTab -Text 'Tab 3' -Content {  
        New-UDHeading -Text "Gitlab Tab" 
    } -Icon (New-UDIcon -Icon gitlab)
}
```

Creates a tab container with 3 tabs and icons.

### Tabs with icons and text in stacked position
```
New-UDTabContainer -Tabs {

    New-UDTab -Text 'Tab 1' -Content { 
        New-UDHeading -Text "Gitkraken Tab"
    } -Icon (New-UDIcon -Icon gitkraken) -Stacked
    
    New-UDTab -Text 'Tab 2' -Content { 
        New-UDHeading -Text "Github Tab" 
    } -Icon (New-UDIcon -Icon github) -Stacked

    New-UDTab -Text 'Tab 3' -Content {  
        New-UDHeading -Text "Gitlab Tab" 
    } -Icon (New-UDIcon -Icon gitlab) -Stacked
}
```

Creates a tab container with 3 tabs and icons.

### Tabs with icons only
```
New-UDTabContainer -Tabs {

    New-UDTab -Content { 
        New-UDHeading -Text "Gitkraken Tab"
    } -Icon (New-UDIcon -Icon gitkraken)
    
    New-UDTab -Content { 
        New-UDHeading -Text "Github Tab" 
    } -Icon (New-UDIcon -Icon github)

    New-UDTab -Content {  
        New-UDHeading -Text "Gitlab Tab" 
    } -Icon (New-UDIcon -Icon gitlab)
}
```

Creates a tab container with 3 tabs and icons only no labels.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

