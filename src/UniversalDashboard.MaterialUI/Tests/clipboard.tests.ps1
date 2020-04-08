Enter-SeUrl -Target $Driver -Url "http://localhost:10000/clipboard"

Describe "clipboard" {
    It 'should set item in clipboard' {
        Find-SeElement -Id 'btnClip' -Driver $Driver | Invoke-SeClick
        Find-SeElement -Id 'btnClip2' -Driver $Driver | Invoke-SeClick
        Get-Clipboard | Should be "hello world!"
    }
}