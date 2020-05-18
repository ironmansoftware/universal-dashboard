Describe "Map" {
    Context "geoJSON" {
        Set-TestDashboard {
            New-UDMap -Id map -Endpoint {
                New-UDMapLayerControl -Id 'layercontrol' -Content {
                    New-UDMapBaseLayer -Name "Black and White" -Content {
                        New-UDMapRasterLayer -TileServer 'https://tiles.wmflabs.org/bw-mapnik/{z}/{x}/{y}.png' 
                    } -Checked

                    New-UDMapOverlay -Name 'test' -Content {
                        New-UDMapMarker -Latitude '43.0730553' -Longitude '-89.4569855' -Popup (New-UDMapPopup -Content {
                            
                            New-UDRow {   
                                New-UDHeading -Size 1 -Text ("Bus: $($Vehicle.VehicleLabel)")
                            }
                            New-UDRow {   
                                New-UDHeading -Text ("Time: $($Vehicle.TimeCurrent)")
                            }
                            New-UDRow {   
                                New-UDHeading -Text ("Route: $($Vehicle.RouteID)")
                            }
                            New-UDRow {   
                                New-UDHeading -Text ("Trip: $($Vehicle.TripID)")
                            }
                           
                            New-UDRow -Columns {            
                                New-UDColumn -Size 4 {
                                    New-UDHtml -Markup "<h1>Column 1 </h1>"
                                }
                                New-UDColumn -Size 4 {
                                    New-UDHtml -Markup "<h1>Column 2 </h1>"
                                }      
                                
                                New-UDColumn -Size 4 {
                                    New-UDHtml -Markup "<h1>Column 3 </h1>"
                                }   
                            }              
    
                            New-UDImage -Url 'https://media1.giphy.com/media/J1ZajKJKzD0PK/giphy.gif?cid=790b76115d1c03c92f6655656b893446&rid=giphy.gif'
    
                            } -MinWidth 1000 )
                    } -Checked 
                }
            } -Height '100vh' -Animate -Latitude 53.505 -Longitude -0.29 -Zoom 13

            New-UDButton -Text "Click me" -OnClick {
                $Map = Get-UDElement -Id map
                Show-UDToast -Message $Map.Attributes['bounds']
            }
        }
    }

    Wait-Debugger

    Context "plain map" {
        Set-TestDashboard {

            New-UDButton -Text 'Add Circle' -OnClick {
                Add-UDElement -ParentId 'Feature-Group' -Content {
                    New-UDMapVectorLayer -Id 'Vectors' -Circle -Latitude 51.505 -Longitude -0.09 -Radius 500 -Color blue -FillColor blue -FillOpacity .5 
                }
            }

            New-UDButton -Text 'Remove Circle' -OnClick {
                Remove-UDElement -Id 'Vectors' 
            }

            New-UDButton -Text 'Add Marker' -OnClick {
                Add-UDElement -ParentId 'Feature-Group' -Content {
                    New-UDMapMarker -Id 'marker' -Latitude 51.505 -Longitude -0.09 -Popup (
                        New-UDMapPopup -Content {
                            New-UDCard -Title "Test"
                        } -MaxWidth 600
                    ) 
                }
            }

            New-UDButton -Text 'Remove Marker' -OnClick {
                Remove-UDElement -Id 'marker' 
            }

            New-UDButton -Text 'Add Layer' -OnClick {
                Add-UDElement -ParentId 'layercontrol' -Content {
                    New-UDMapOverlay -Id 'MyNewLayer' -Name "MyNewLayer" -Content {
                        New-UDMapFeatureGroup -Id 'Feature-Group2' -Content {
                            1..100 | % {
                                New-UDMapVectorLayer -Id 'test' -Circle -Latitude "51.$_" -Longitude -0.09 -Radius 50 -Color red -FillColor blue -FillOpacity .5        
                            }
                        }
                    } -Checked
                    
                }
            }

            New-UDButton -Text 'Remove Layer' -OnClick {
                Remove-UDElement -Id 'MyNewLayer' 
            }

            New-UDButton -Text 'Move' -OnClick {
                Set-UDElement -Id 'map' -Attributes @{
                    latitude = 51.550
                    longitude = -0.09
                    zoom = 10
                }
            }

            New-UDButton -Text "Add marker to cluster" -OnClick {
                Add-UDElement -ParentId 'cluster-layer' -Content {
                    $Random = Get-Random -Minimum 0 -Maximum 100
                    $RandomLat = $Random + 400
                    New-UDMapMarker -Latitude "51.$RandomLat" -Longitude "-0.$Random"
                }
            }

            New-UDButton -Text "Clear cluster" -OnClick {
                Clear-UDElement -Id 'cluster-layer' 
            }

            New-UDButton -Text "Add points to heatmap" -OnClick {
                Add-UDElement -ParentId 'heatmap' -Content {
                    @(
                        @(51.505, -0.09, "625"),
                        @(51.505234, -0.0945654, "625"),
                        @(51.50645, -0.098768, "625"),
                        @(51.5056575, -0.0945654, "625"),
                        @(51.505955, -0.095675, "625"),
                        @(51.505575, -0.09657, "625"),
                        @(51.505345, -0.099876, "625"),
                        @(51.505768, -0.0923432, "625"),
                        @(51.505567, -0.02349, "625"),
                        @(51.50545654, -0.092342, "625"),
                        @(51.5045645, -0.09342, "625")
                    )
                }
            }

            New-UDButton -Text "Clear heatmap" -OnClick {
                Clear-UDElement -Id 'heatmap'
            }

            New-UDMap -Id 'map' -Endpoint {
                New-UDMapLayerControl -Id 'layercontrol' -Content {
                    New-UDMapBaseLayer -Name "Black and White" -Content {
                        New-UDMapRasterLayer -TileServer 'https://tiles.wmflabs.org/bw-mapnik/{z}/{x}/{y}.png' 
                    } 

                    New-UDMapBaseLayer -Name "Mapnik" -Content {
                        New-UDMapRasterLayer -TileServer 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png' 
                    } 

                    New-UDMapBaseLayer -Name "Bing" -Content {
                        New-UDMapRasterLayer -Bing -ApiKey 'AuhiCJHlGzhg93IqUH_oCpl_-ZUrIE6SPftlyGYUvr9Amx5nzA-WqGcPquyFZl4L' -Type Road
                    } -Checked

                    New-UDMapOverlay -Name "Markers" -Content {
                        New-UDMapFeatureGroup -Id 'Feature-Group' -Content {
                            New-UDMapMarker -Id 'marker' -Latitude 51.505 -Longitude -0.09
                        } -Popup (
                            New-UDMapPopup -Content {
                                New-UDCard -Title "Test123"
                            } -MaxWidth 600
                        )
                    } -Checked

                    New-UDMapOverlay -Name 'Vectors' -Content {
                        New-UDMapFeatureGroup -Id 'Vectors' -Content {
                            New-UDMapVectorLayer -Id 'Vectors' -Circle -Latitude 51.505 -Longitude -0.09 -Radius 500 -Color blue -FillColor blue -FillOpacity .5 
                        }
                    } -Checked

                    New-UDMapOverlay -Name "Heatmap" -Content {
                        New-UDMapHeatmapLayer -Id 'heatmap' -Points @() 
                    } -Checked 

                    New-UDMapOverlay -Name "Cluster" -Content {
                        New-UDMapMarkerClusterLayer -Id 'cluster-layer' -Markers @(
                            1..100 | ForEach-Object {
                                $Random = Get-Random -Minimum 0 -Maximum 100
                                $RandomLat = $Random + 400
                                New-UDMapMarker -Latitude "51.$RandomLat" -Longitude "-0.$Random"
                            }
                        )
                    } -Checked

                }
                
            } -Height '100vh' -Animate -Latitude 53.505 -Longitude -0.29 -Zoom 13
        }

        Wait-Debugger

        It "should show map" {
            Find-SeElement -Driver $Driver -ClassName 'leaflet-container' | should not be $null
        }

        
    }

}