---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard.Community
online version: https://go.microsoft.com/fwlink/?LinkID=217032
schema: 2.0.0
---

# New-UDSideNav

## SYNOPSIS
Allows for configuration of the side navigation menu.

## SYNTAX

### Endpoint
```
New-UDSideNav -Endpoint <Object> [-Fixed] [-Width <Int32>] [-Id <String>] [<CommonParameters>]
```

### Content
```
New-UDSideNav -Content <ScriptBlock> [-Fixed] [-Width <Int32>] [-Id <String>] [<CommonParameters>]
```

### None
```
New-UDSideNav [-None] [-Fixed] [-Width <Int32>] [-Id <String>] [<CommonParameters>]
```

## DESCRIPTION
Allows for configuration of the side navigation menu.

## EXAMPLES

### Example 1
```
$Page1 = New-UDPage -Name "Page Name" -Content { New-UDCard -Id 'page-1' }
$Page2 = New-UDPage -Name "Page Name 2" -Content { New-UDCard -Id 'page-2'}

$Navigation = New-UDSideNav -Content {
    New-UDSideNavItem -Text "My First Page" -PageName "Page Name" -Icon group
    New-UDSideNavItem -Text "My Second Page" -PageName "Page Name 2" -Icon User
    New-UDSideNavItem -Text "Google" -Url 'https://www.google.com' -Icon Users
}

$Dashboard = New-UDDashboard -Title "Navigation" -Pages @($Page1, $Page2) -Navigation $Navigation
```

Creates a static navigation menu based on the SideNavItems listed in the content.

### Example 2
```
$Page1 = New-UDPage -Name "Page Name" -Content { New-UDCard -Id 'page-1' }
$Page2 = New-UDPage -Name "Page Name 2" -Content { New-UDCard -Id 'page-2'}

$Navigation = New-UDSideNav -None

New-UDDashboard -Title "Navigation" -Pages @($Page1, $Page2) -Navigation $Navigation
```

Hides the side navigation menu and hamburger icon.

### Example 3
```
$Page1 = New-UDPage -Name "Page Name" -Content { New-UDCard -Id 'page-1' }
$Page2 = New-UDPage -Name "Page Name 2" -Content { New-UDCard -Id 'page-2'}

$Navigation = New-UDSideNav -Content {
    New-UDSideNavItem -Text "Section" -Children {
        New-UDSideNavItem -Text "My Second Page" -PageName "Page Name 2" -Icon User
        New-UDSideNavItem -Text "Google" -Url 'https://www.google.com' -Icon Users
    }
} -Fixed

New-UDDashboard -Title "Navigation" -Pages @($Page1, $Page2) -Navigation $Navigation
```

Creates a side navigation menu with nested items with a fixed menu.

### Example 4
```
$Page1 = New-UDPage -Name "Page Name" -Content { New-UDCard -Id 'page-1' }
$Page2 = New-UDPage -Name "Page Name 2" -Content { New-UDCard -Id 'page-2'}

$Navigation = New-UDSideNav -Content {
    New-UDSideNavItem -Text "My First Page" -PageName "Page Name" -Icon group
    New-UDSideNavItem -Subheader -Text "Subheader"
    New-UDSideNavItem -Text "My Second Page" -PageName "Page Name 2" -Icon User
    New-UDSideNavItem -Divider
    New-UDSideNavItem -Text "Google" -Url 'https://www.google.com' -Icon Users
} -Fixed

New-UDDashboard -Title "Navigation" -Pages @($Page1, $Page2) -Navigation $Navigation
```

Creates a side menu with sub headers and a divider.

### Example 5
```
$Page1 = New-UDPage -Name "Page Name" -Content { New-UDCard -Id 'page-1' }
$Page2 = New-UDPage -Name "Page Name 2" -Content { New-UDCard -Id 'page-2'}

$Navigation = New-UDSideNav -Endpoint {
    New-UDSideNavItem -Text "My First Page" -OnClick { Show-UDModal -Content { New-UDCard -Id "ModalCard" } } -Icon group
} -Fixed

New-UDDashboard -Title "Navigation" -Pages @($Page1, $Page2) -Navigation $Navigation
```

Loads a side menu dynamically from an endpoint.

## PARAMETERS

### -Content
The menu items for the side navigation menu. Use New-UDSideNavItem to add new items.

```yaml
Type: ScriptBlock
Parameter Sets: Content
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Endpoint
Load items dynamically from an endpoint. Use New-UDSideNavItem to add new items.

```yaml
Type: Object
Parameter Sets: Endpoint
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Fixed
Produces a fixed side navigation menu that does not include a popout hamburger menu.

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
The ID of the menu.

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

### -None
Hide the side navigation menu and hamburger menu button.

```yaml
Type: SwitchParameter
Parameter Sets: None
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Width
The width in pixels of the side navigation menu.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
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

