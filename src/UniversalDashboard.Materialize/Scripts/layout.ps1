function New-UDLayout {
    param(
        [Parameter(Mandatory = $true)]
        [int]$Columns,
        [Parameter(Mandatory = $true)]
        [ScriptBlock]$Content
    )

    $Components = $Content.Invoke()
    $LargeColumnSize = 12 / $Columns
    $MediumColumnSize = (12 / $Columns) * 2
    $SmallColumnSize = 12
    $Offset = 0
    $ComponentCount = ($Components | Measure-Object).Count

    while ($Offset -lt $ComponentCount) {
        $ColumnObjects = $Components | Select-Object -Skip $Offset -First $Columns | ForEach-Object {
            New-UDColumn -SmallSize $SmallColumnSize -MediumSize $MediumColumnSize -LargeSize $LargeColumnSize -Content {
                $_
            }
        }

        New-UDRow -Columns {
            $ColumnObjects
        }
        
        $Offset += $Columns
    }
}