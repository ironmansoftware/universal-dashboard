
class ThemeColors {
    [string]$primary
    [string]$secondary
    [string]$background
    [string]$text
    [string]$muted

    ThemeColors() { 
    }

    ThemeColors([string]$primary, [string]$secondary) {
        $this.primary = $primary
        $this.secondary = $secondary
    }

    ThemeColors([string]$primary, [string]$secondary, [string]$background, [string]$text, [string]$muted) {
        $this.Primary = $Primary
        $this.Secondary = $Secondary
        $this.Background = $Background
        $this.Text = $Text
        $this.Muted = $Muted
    }

}

class ThemeColorModes {
    [ThemeColors]$Dark

    ThemeColorModes() {
    }

    ThemeColorModes([ThemeColors]$Dark) {
        $this.Dark = $Dark
    }
}

function New-UDTheme {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$name,
        [Parameter()]
        [ThemeColors]$Colors,
        [Parameter()]
        [ThemeColorModes]$ColorModes,
        [Parameter()]
        [hashtable]$Variants
    )
    end {
        $theme = [ordered]@{
            name     = $Name
            colors   = if ($Colors) {
                $Colors 
            }
            else {
                [ThemeColors]::new() 
            }
            modes    = if ($ColorModes) {
                $ColorModes 
            }
            else {
                [ThemeColorModes]::new([ThemeColors]::new()) 
            }
            variants = $Variants
        }
        $Result = $theme | ConvertTo-Json -Depth 10 
        $Result
    }
}




