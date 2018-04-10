Import-Module UniversalDashboard

function Out-UDGridView {
<#
.SYNOPSIS
Creates a grid based on the data piped in.

.DESCRIPTION
Creates a grid based on the data piped in.

.PARAMETER InputObject
Object to output

.PARAMETER Title
Title for the grid and dashboard.

.EXAMPLE
Get-Process | Out-UDGridView
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        $InputObject,
        [Parameter()]
        $Title = ($PSCmdlet.MyInvocation.Line)
    )

    Begin {
        $Script:Items = @()
    }

    Process {
        $Script:Items += $InputObject
    }

    End {

        $Headers = @()
        $FormattedItems = @()

        $FormatData = Get-FormatData -TypeName (Get-Process | Get-Member).TypeName
        if ($FormatData -ne $null) {
            $TableControl  = $FormatData.FormatViewDefinition.Control | Where-Object { $_ -is [System.Management.Automation.TableControl] }
            if ($TableControl -ne $null) {

                $Row = $TableControl.Rows | Select-Object -First 1

                $i = 0
                foreach($Header in $TableControl.Headers) {
                    if ([String]::IsNullOrEmpty($Header.Label)) {
                        $Headers += $Row.Columns[$i].DisplayEntry.Value
                    }
                    else {
                        $Headers += $Header.Label
                    }
                    $i++
                }
            }

            foreach($Item in $Script:Items) {
                $FormattedItem = @{}
                $c = 0
                foreach($Column in $Row.Columns) {
                    if ($Column.DisplayEntry.ValueType -eq 'Property') {
                        $FormattedItem."p$c" = $Item.$($Column.DisplayEntry.Value)
                    } 
                    elseif ($Column.DisplayEntry.ValueType -eq 'ScriptBlock') {
                        $FormattedItem."p$c" = [ScriptBlock]::Create($Column.DisplayEntry.Value.Replace('$_', '$args[0]')).Invoke($Item) | Select-Object -First 1
                    }
                    $c++
                }
                $Properties = 0..$c | ForEach-Object { "p$_" }
                $FormattedItems += $FormattedItem
            }
        }
        else {
            $headers = $Script:Items | Get-Member -MemberType Property | Select-Object -ExpandProperty Name
            $Properties = $Script:Items | Get-Member -MemberType Property | Select-Object -ExpandProperty Name
            $FormattedItems = $Script:Items
        }

        $Dashboard = New-UDDashboard -Title $Title -Content {
            New-UDGrid -Headers $headers -Properties $Properties -Endpoint {
                $FormattedItems | Out-UDGridData 
            }
        }

        Get-UDDashboard -Name "OutUDGridView" | Stop-UDDashboard

        $Ports = Get-CimInstance -ClassName MSFT_NetTCPConnection -Namespace root\StandardCimv2 | Where-Object State -eq 'Listen'

        $Port = 10000
        foreach($Port in 10000..20000) {
            if (($Ports.LocalPort | Where-Object { $_ -eq $Port } | Measure-Object).Count -eq 0) 
            {
                break
            }
        }

        Start-UDDashboard -Dashboard $Dashboard -Port $Port -Name "OutUDGridView"
        Start-Process http://localhost:$Port
    }
}