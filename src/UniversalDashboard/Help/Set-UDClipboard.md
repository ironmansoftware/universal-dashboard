---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: https://go.microsoft.com/fwlink/?LinkID=217032
schema: 2.0.0
---

# Set-UDClipboard

## SYNOPSIS
Sets the contents of the clipboard.

## SYNTAX

```
Set-UDClipboard -Data <String> [-toastOnSuccess] [-toastOnError] [<CommonParameters>]
```

## DESCRIPTION
Sets the contents of the clipboard.

## EXAMPLES

### Example 1
```
New-UDHeading -Size 5 -Text 'You just copy me!!'
New-UDButton -Floating -Icon clipboard -OnClick {
    Set-UDClipboard -Data 'You just copy me!!'
} 
```

Sets 'You just copy me!!' into the clipboard.

### Example 2
```
New-UDTextbox -Label "Textbox" -Placeholder "Enter your name" -Id 'textToCopy'
New-UDButton -Icon clipboard -OnClick {
    $Element = Get-UDElement -Id 'textToCopy'
    $text = $Element.Attributes.value
    Set-UDClipboard -Data $text
} 
```

Sets text box value into the clipboard.

### Example 3
```
New-UDTextbox -Label "Textbox" -Placeholder "Enter your name" -Id 'textToCopySuccess'
New-UDButton -Icon clipboard -OnClick {
    $Element = Get-UDElement -Id 'textToCopySuccess'
    $text = $Element.Attributes.value
    Set-UDClipboard -Data $text -toastOnSuccess
} 
```

Sets text box value into the clipboard and show toast message on success.

### Example 4
```
New-UDTextbox -Label "Textbox" -Placeholder "Enter your name" -Id 'textToCopyFail'
New-UDButton -Icon clipboard -OnClick {
    $Element = Get-UDElement -Id 'textToCopyFailed'
    $text = $Element.Attributes.value
    Set-UDClipboard -Data $text -toastOnError
} 
```

Sets text box value into the clipboard and show toast message on failed.

### Example 5
```
New-UDButton -Text "Show Modal" -OnClick {
    Show-UDModal -Header {
        New-UDHeading -Size 4 -Text "This is the text to copy"
    } -Content {
        'This is the text to copy'
        New-UDButton -Floating -Icon clipboard -OnClick {
            Set-UDClipboard -Data 'This is the text to copy' 
        } 
    }
}
```

Shows a modal with button that set text in the clipboard.

## PARAMETERS

### -Data
The text to set into the clipboard.

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

### -toastOnError
Creates a toast when it fails to set the clipboard text.

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

### -toastOnSuccess
Creates a toast when it succeeds to set the clipboard text.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

