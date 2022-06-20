function ConvertFrom-GeoJson {
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [PSCustomObject[]]$GeoJson,
        [Parameter()]
        [PSCustomObject[]]$Icons
    )

    Process {
        $Json = $GeoJson 

        $Json | ForEach-Object {
            if ($_.type -eq 'FeatureCollection') {
                $features = foreach($Feature in $_.features)
                {
                    $Feature | ConvertFrom-GeoJson -Icons $Icons
                }

                New-UDMapOverlay -Name $_.properties.name -Content {
                    New-UDMapFeatureGroup -Content { $features }
                } -Checked
            }

            if ($_.type -eq 'feature') {
                $Geometry = $_.geometry | ConvertFrom-GeoJson -Icons $Icons
                
                if ($_.properties.DisplayText) {
                    $Geometry.Popup = New-UDMapPopup -Content { New-UDHtml $_.properties.DisplayText }
                }

                if ($_.style.color -and $Geometry.type -ne "map-marker") {
                    $Geometry.FillColor = $_.style.color
                    $Geometry.Color = $_.style.color

                    if ($_.style.weight) {
                        $Geometry.Weight = $_.style.weight
                    }
                }

                if ($_.style.color -and $Geometry.type -eq "map-marker") {

                    $iconName = $_.style.color
                    $Icon = $Icons | Where-Object {
                        $_.IconName -eq $iconName
                    }

                    if ($null -ne $Icon) {
                        $Geometry.Icon = New-UDMapIcon -Url "http://emaps.papertransport.com/e_img/$($Icon.IconFileName)" -Width $Icon.IconWidth -Height $Icon.IconHeight -AnchorX $Icon.IconAnchorX -AnchorY $Icon.IconHeight -PopupAnchorX $Icon.IconPopupX -PopupAnchorY $Icon.IconPopupY
                    }
                }

                $Geometry
            }

            if ($_.type -eq 'polygon') {
                $Coordinates = @()
                $_.coordinates[0] | ForEach-Object {
                    $temp = $_[0]
                    $_[0] = $_[1]
                    $_[1] = $temp

                    $Coordinates += ,$_
                }

                New-UDMapVectorLayer -Polygon -Positions $Coordinates -FillOpacity .5
            }

            if ($_.type -eq 'point') {
                $Coordinates = $_.coordinates

                New-UDMapMarker -Latitude $coordinates[1] -Longitude $coordinates[0] -Zindex $_.style.zIndexOffset
            }

            if ($_.type -eq 'linestring') {
                $Coordinates = $_.coordinates

                New-UDMapMarker -Latitude $coordinates[1] -Longitude $coordinates[0] -Zindex $_.style.zIndexOffset
            }

            if ($_.type -eq 'MultiLineString') {
                $Coordinates = @()
                foreach($array in $_.coordinates) {
                    foreach($arrayInArray in $array) {
                        $temp = $arrayInArray[0]
                        $arrayInArray[0] = $arrayInArray[1]
                        $arrayInArray[1] = $temp
    
                        $Coordinates += ,$arrayInArray
                    }
                }

                New-UDMapVectorLayer -Polyline -Positions $Coordinates
            }
        }
    }
}