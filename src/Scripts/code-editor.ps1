

function New-UDCodeEditor {
    <#
    .SYNOPSIS
    Creates a new Monaco code editor control.
    
    .DESCRIPTION
    Creates a new Monaco code editor control.
    
    .PARAMETER Id
    The ID of this editor
    
    .PARAMETER Language
    The language to use for syntax highlighting.
    
    .PARAMETER Height
    The height of the editor.
    
    .PARAMETER Width
    The width of the editor.
    
    .PARAMETER HideCodeLens
    Hides code lens within th editor.
    
    .PARAMETER DisableCodeFolding
    Disables code folding.
    
    .PARAMETER FormatOnPaste
    Formats on paste.
    
    .PARAMETER GlyphMargin
    Seconds the size of the glyph margin
    
    .PARAMETER DisableLineNumbers
    Disables line numbers
    
    .PARAMETER DisableLinks
    Disables automatically highlighting links.
    
    .PARAMETER DisableBracketMatching
    Disables bracket matching. 
    
    .PARAMETER MouseWheelScrollSensitivity
    Sets the mouse wheel scroll sensitivity.
    
    .PARAMETER MouseWheelZoom
    Enables Ctrl+Scroll zooming. 
    
    .PARAMETER ReadOnly
    Sets the editor to readonly.
    
    .PARAMETER RenderControlCharacters
    Enables rendering of control characters.
    
    .PARAMETER ShowFoldingControls
    Controls how to show the folding controls. 
    
    .PARAMETER SmoothScrolling
    Enables smooth scrolling.
    
    .PARAMETER Theme
    Selects the theme. The default is the 'vs' theme. 
    
    .PARAMETER Code
    The code to show in the editor. 
    
    .EXAMPLE
    New-UDCodeEditor -Code 'Get-Process' -Theme 'vs-dark' -Language 'powershell' -Readonly 

    Creates a readonly code editor with PowerShell script. 
    #>
    
    [CmdletBinding(DefaultParameterSetName = "Standard")]
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [ValidateSet('apex', 'azcli', 'bat', 'clojure', 'coffee', 'cpp', 'csharp', 'csp', 'css', 'dockerfile', 'fsharp', 'go', 'handlebars', 'html', 'ini', 'java', 'javascript', 'json', 'less', 'lua', 'markdown', 'msdax', 'mysql', 'objective', 'perl', 'pgsql', 'php', 'postiats', 'powerquery', 'powershell', 'pug', 'python', 'r', 'razor', 'redis', 'redshift', 'ruby', 'rust', 'sb', 'scheme', 'scss', 'shell', 'solidity', 'sql', 'st', 'swift', 'typescript', 'vb', 'xml', 'yaml')]
        [string]$Language,
        [Parameter()]
        [string]$Height,
        [Parameter()]
        [string]$Width,
        [Parameter(ParameterSetName = 'Standard')]
        [Switch]$HideCodeLens,
        [Parameter(ParameterSetName = 'Standard')]
        [Switch]$DisableCodeFolding,
        [Parameter(ParameterSetName = 'Standard')]
        [Switch]$FormatOnPaste,
        [Parameter(ParameterSetName = 'Standard')]
        [Switch]$GlyphMargin,
        [Parameter(ParameterSetName = 'Standard')]
        [Switch]$DisableLineNumbers,
        [Parameter(ParameterSetName = 'Standard')]
        [Switch]$DisableLinks,
        [Parameter(ParameterSetName = 'Standard')]
        [Switch]$DisableBracketMatching,
        [Parameter(ParameterSetName = 'Standard')]
        [int]$MouseWheelScrollSensitivity = 1,
        [Parameter(ParameterSetName = 'Standard')]
        [Switch]$MouseWheelZoom,
        [Parameter(ParameterSetName = 'Standard')]
        [Switch]$ReadOnly,
        [Parameter(ParameterSetName = 'Standard')]
        [Switch]$RenderControlCharacters,
        [Parameter(ParameterSetName = 'Standard')]
        [ValidateSet("always", "mouseover")]
        [string]$ShowFoldingControls = "mouseover",
        [Parameter(ParameterSetName = 'Standard')]
        [Switch]$SmoothScrolling,
        [Parameter(ParameterSetName = 'Standard')]
        [ValidateSet("vs", "vs-dark", "hc-black")]
        [string]$Theme = 'vs',
        [Parameter()]
        [string]$Code,
        [Parameter()]
        [string]$Original,
        [Parameter(ParameterSetName = 'Standard')]
        [Switch]$Autosize,
        [Parameter(ParameterSetName = 'Options')]
        [Hashtable]$Options = @{},
        [Parameter()]
        [Switch]$CanSave,
        [Parameter()]
        [String]$Extension = 'txt'
    )

    End {

        # if ($Endpoint -is [scriptblock]) {
        #     $Endpoint = New-UDEndpoint -Endpoint $Endpoint -Id $Id
        # }
        # elseif ($Endpoint -isnot [UniversalDashboard.Models.Endpoint]) {
        #     throw "Endpoint must be a script block or UDEndpoint"
        # }

        if ($PSCmdlet.ParameterSetName -eq 'Options') {
            $Options["assetId"] = $AssetId
            $Options["isPlugin"] = $true 
            $Options["type"] = "ud-monaco"
            $Options["id"] = $Id 
            $Options["height"] = $Height 
            $Options["width"] = $Width 
            $Options["language"] = $Language 
            $Options["code"] = $code 
            $Options["original"] = $original 

            return $Options
        }

        @{
            assetId                     = $AssetId 
            isPlugin                    = $true 
            type                        = "ud-monaco"
            id                          = $Id

            height                      = $Height
            width                       = $Width
            language                    = $Language 
            codeLens                    = -not $HideCodeLens.IsPresent
            folding                     = -not $DisableCodeFolding.IsPresent
            formatOnPaste               = $FormatOnPaste.IsPresent
            glyphMargin                 = $GlyphMargin.IsPresent
            lineNumbers                 = if ($DisableLineNumbers.IsPresent) { "off" } else { "on" }
            links                       = -not $DisableLinks.IsPresent
            matchBrackets               = -not $DisableBracketMatching.IsPresent
            mouseWheelScrollSensitivity = $MouseWheelScrollSensitivity
            mouseWheelZoom              = $MouseWheelZoom.IsPresent
            readOnly                    = $ReadOnly.IsPresent
            renderControlCharacters     = $RenderControlCharacters.IsPresent
            showFoldingControls         = $ShowFoldingControls
            smoothScrolling             = $SmoothScrolling.IsPresent
            theme                       = $Theme
            code                        = $Code
            original                    = $Original
            autosize                    = $Autosize.IsPresent
            canSave                     = $CanSave.IsPresent
            extension                   = $Extension
        }
    }
}