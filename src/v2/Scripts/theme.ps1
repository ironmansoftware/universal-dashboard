function New-UDTheme {
    param(
        [Parameter(Mandatory, Position = 1)]
		[string]$Name,
        [Parameter(Mandatory, Position = 2)]
		[Hashtable]$Definition,
		[Parameter(Position = 3)]
		[string]$Parent
    )

    @{
        name = $Name
        definition = $Definition
        parent = $Parent
    }
}

$Themes = @()

$ThemePath = "$PSScriptRoot/Themes"
if (-not (Test-Path $ThemePath))
{
    $ThemePath = "$PSScriptRoot/../Themes"
}

Get-ChildItem $ThemePath -File | ForEach-Object {
    $Themes += Invoke-Expression (Get-Content $_.FullName -Raw)
}

function Get-UDTheme {
    param(
        [Parameter(Position = 1)]
        [string]$Name
    )

    if($Name) {
        $Themes | Where-Object Name -eq $Name
    }
    else {
        $Themes
    }
    
}

$cssMap = @{}
$cssMap.Add("udcard", @(".ud-card"))
$cssMap.Add("udchart", @(".ud-chart"))
$cssMap.Add("udcollapsible", @(".ud-collapsible"))
$cssMap.Add("udcollapsibleitem", @(".ud-collapsible-item"))
$cssMap.Add("udcolumn", @(".ud-column"));
$cssMap.Add("udcounter", @(".ud-counter"));
$cssMap.Add("uddashboard", @(".ud-dashboard"));
$cssMap.Add("udfooter", @(".ud-footer"));
$cssMap.Add("udgrid", @(".ud-grid"));
$cssMap.Add("udimage", @(".ud-image"));
$cssMap.Add("udinput", @(".ud-input", ".datepicker-table td.is-today", ".datepicker-table td.is-selected", ".datepicker-date-display", ".datepicker-modal", ".datepicker-controls", ".datepicker-done", ".datepicker-cancel"));
$cssMap.Add("udlink", @(".ud-link"));
$cssMap.Add("udmonitor", @(".ud-monitor"));
$cssMap.Add("udnavbar", @(".ud-navbar"));
$cssMap.Add("udpagenavigation", @(".ud-page-navigation"));
$cssMap.Add("udrow", @(".ud-row"));
$cssMap.Add("udtable", @(".ud-table"));
$cssMap.Add("udtabs", @("nav.mdc-tab-bar", ".mdc-tab-bar"));
$cssMap.Add("udtab", @(".mdc-tab.mdc-tab__text-label"));
$cssMap.Add("udtabactive", @("button.mdc-tab--active.mdc-ripple-upgraded.mdc-ripple-upgraded--background-focused.mdc-tab--active.mdc-tab", "button.mdc-tab--active.mdc-ripple-upgraded.mdc-tab--active.mdc-tab > div.mdc-tab__content > span", "button.mdc-tab--active.mdc-ripple-upgraded.mdc-tab--active.mdc-tab"));
$cssMap.Add("udtabindicator", @(".mdc-tab-indicator--active .mdc-tab-indicator__content"));
$cssMap.Add("udtabicon", @(".mdc-tab.mdc-tab__icon"));
$cssMap.Add("udtabactiveicon", @("button.mdc-tab--active.mdc-ripple-upgraded.mdc-tab--active.mdc-tab > div.mdc-tab__content > i", ".mdc-tab .mdc-tab__icon"));
$cssMap.Add("udimagecarouselindicator", @(".slider .indicators .indicator-item", ".slider .indicators .indicator-item.active"));
$cssMap.Add("udimagecarouselindicatoractive", @(".slider .indicators .indicator-item.active"));
$cssMap.Add("backgroundcolor", @("background-color"));
$cssMap.Add("fontfamily", @("font-family"));
$cssMap.Add("fontcolor", @("color"));
$cssMap.Add("activefontcolor", @("color"));
$cssMap.Add("activebackgroundcolor", @("background-color"));
$cssMap.Add("indicatorcolor", @("border-color"));
$cssMap.Add("indicatorheight", @("border-top-width"));
$cssMap.Add("boxshadow", @("box-shadow"));
$cssMap.Add("height", @("height"));
$cssMap.Add("lineheight", @("line-height"))
$cssMap.Add("width", @("width"))

function ConvertTo-UDThemeCss {
    param(
        [Parameter(Mandatory)]
        [PSCustomObject]$Theme
    )

    $hashtable = $Theme.Definition
    $parentTheme = $Themes | Where-Object Name -eq $Theme.Parent
    
    if ($null -ne $parent)
    {
        $hashtable = Join-Hashtable -Child $hashtable -Parent $parentTheme.Definition
    }

    $stringBuilder = [System.Text.StringBuilder]::new()
    foreach($key in $hashtable.Keys)
    {
        $value = $hashtable[$key.ToLower()]

        if ($cssMap.ContainsKey($key.ToLower()))
        {
            $ids = $cssMap[$key.ToLower()]
            foreach ($id in $ids)
            {
                $stringBuilder.AppendLine($id + " {") > $null
                ConvertTo-UDCSSValue -Hashtable $value -StringBuilder $stringBuilder
                $stringBuilder.AppendLine("}")> $null
            }
        }
        else
        {
            $stringBuilder.AppendLine($key + " {")> $null
            ConvertTo-UDCSSValue -Hashtable $value -StringBuilder $stringBuilder
            $stringBuilder.AppendLine("}")> $null
        }
    }

    $stringBuilder.ToString()
}

function Join-HashTable
{
    param(
        [Parameter(Mandatory)]
        [Hashtable]$Child,
        [Parameter(Mandatory)]
        [Hashtable]$Parent
    )

    $mergedTable = @{}

    foreach ($key in $parent.Keys)
    {
        if ($child.ContainsKey($key))
        {
            $value = $child[$key]
            if ($value -is [string])
            {
                $mergedTable.Add($key, $value);
            }

            $parentHashtableValue = $parent[$key]
            if ($value -is [Hashtable] -and $parentHashtableValue -is [Hashtable])
            {
                
                $mergedTableValue = Join-Hashtable -Child $value -Parent $parent
                $mergedTable.Add($key, $mergedTableValue)
            }
        }
        else
        {
            $mergedTable.Add($key, $parent[$key])
        }
    }

    foreach ($key in $child.Keys)
    {
        if (-not $parent.ContainsKey($key))
        {
            mergedTable.Add($key, $child[$key])
        }
    }
}

function ConvertTo-UDCSSValue {
    param(
        [Parameter(Mandatory)]
        $Hashtable,
        [Parameter(Mandatory)]
        $stringBuilder
    )

    foreach ($section in $hashtable.Keys)
    {
        $identifier = $section
        $value = $hashtable[$identifier];

        if ($cssMap.ContainsKey($identifier.ToLower()))
        {
            $identifier = $cssMap[$identifier.ToLower()] | Select-Object -First 1
        }

        if ($value -is [string])
        {
            $stringBuilder.AppendLine("`t" + $identifier + " : " + $value + ";") > $null
            continue;
        }

        if ($value -is [Hashtable])
        {
            $stringBuilder.AppendLine($identifier + " {") > $null
            ConvertTo-UDCSSValue -Hashtable $value -StringBuilder $stringBuilder
            $stringBuilder.AppendLine("}") > $null
            continue;
        }
    }
}