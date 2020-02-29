---
external help file: UniversalDashboard.MaterialUI-help.xml
Module Name: UniversalDashboard.MaterialUI
online version:
schema: 2.0.0
---

# New-UDMuAvatar

## SYNOPSIS
Create materialUI avatar object.

## SYNTAX

```
New-UDMuAvatar [[-Id] <String>] [[-Image] <String>] [[-Alt] <String>] [[-ClassName] <String>]
 [[-Style] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION
Command for creating materialUI user avatar ( circle user photo ), you can style it using html style attribute.

## EXAMPLES

### Example 1
```powershell
PS C:\>New-UDMuAvatar -Image 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4' -Alt 'alon gvili avatar' -Id 'test-avatar' -Variant small
```

Create avatar image with custom size, the size will be 80px x 80px

### Example 2
```powershell
PS C:\>$AvatarProps = @{
                Image = 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4'
                Alt = 'alon gvili avatar'
                Id = 'test-avatar'
                variant = 'medium'
}
New-UDMuAvatar @AvatarProps
```

### Example 3
```powershell
PS C:\>$AvatarProps = @{
                Image = 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4'
                Alt = 'alon gvili avatar'
                Id = 'test-avatar'
                variant = 'large'
}
New-UDMuAvatar @AvatarProps
```

Create avatar image with custom size, the size will be 15px x 15px and change it to be a square using borderRadius property.

## PARAMETERS

### -Alt
provide an alt attribute for the rendered img element.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClassName
set the html class attribute on the img element. 

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
the id for the element.

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

### -Image
a url to the image location.

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

### -Style
Css properties that applied to the img element 

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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
