---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: https://github.com/ironmansoftware/universal-dashboard/blob/master/src/UniversalDashboard/Help/New-UDTreeView.md
schema: 2.0.0
---

# New-UDTreeView

## SYNOPSIS
Creates a tree view control.

## SYNTAX

```
New-UDTreeView [[-Id] <String>] [-Node] <Hashtable> [[-OnNodeClicked] <Object>]
 [[-BackgroundColor] <DashboardColor>] [[-FontColor] <DashboardColor>]
 [[-ActiveBackgroundColor] <DashboardColor>] [[-ToggleColor] <DashboardColor>] [<CommonParameters>]
```

## DESCRIPTION
Creates a tree view control.

## EXAMPLES

### Basic Tree View
```
New-UDTreeView -Node (
    New-UDTreeNode -Name "Root Node" -Children {
        New-UDTreeNode -Name "Child 1"
        New-UDTreeNode -Name "Child 2"
        New-UDTreeNode -Name "Child 3"
    }
)
```

Creates a tree view with 3 children nodes. 

## PARAMETERS

### -ActiveBackgroundColor
Background color of an active node. 

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases: 

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BackgroundColor
The background color of the tree view. 

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontColor
The font color of the tree view. 

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The ID of this tree view. 

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

### -Node
The root node for this tree view. 

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OnNodeClicked
Event handler for when a node is clicked. This can be either a ScriptBlock or the result of New-UDEndpoint. 

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ToggleColor
The color for toggled nodes.

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases: 

Required: False
Position: 6
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

