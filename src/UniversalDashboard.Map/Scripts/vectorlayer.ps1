function New-UDMapVectorLayer {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$Color = 'black',
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$FillColor = 'black',
        [Parameter()]
        [double]$FillOpacity = 0.5,
        [Parameter()]
        [int]$Weight = 3,
        [Parameter()]
        [double]$Opacity = 1.0,
        [Parameter(ParameterSetName = 'Circle', Mandatory)]
        [Switch]$Circle,
        [Parameter(ParameterSetName = 'Circle', Mandatory)]
        [double]$Latitude,
        [Parameter(ParameterSetName = 'Circle', Mandatory)]
        [double]$Longitude,
        [Parameter(ParameterSetName = 'Circle', Mandatory)]
        [int]$Radius,
        [Parameter(ParameterSetName = 'Polyline', Mandatory)]
        [Switch]$Polyline,
        [Parameter(ParameterSetName = 'Polygon', Mandatory)]
        [Switch]$Polygon,
        [Parameter(ParameterSetName = 'Polyline', Mandatory)]        
        [Parameter(ParameterSetName = 'Polygon', Mandatory)]        
        [object]$Positions,
        [Parameter(ParameterSetName = 'Rectangle', Mandatory)]
        [Switch]$Rectangle,
        [Parameter(ParameterSetName = 'Rectangle', Mandatory)]
        [double]$LatitudeTopLeft,
        [Parameter(ParameterSetName = 'Rectangle', Mandatory)]
        [double]$LongitudeTopLeft,
        [Parameter(ParameterSetName = 'Rectangle', Mandatory)]
        [double]$LatitudeBottomRight,
        [Parameter(ParameterSetName = 'Rectangle', Mandatory)]
        [double]$LongitudeBottomRight,
        [Parameter(ParameterSetName = 'Circle')]
        [object]$Popup,
        [Parameter(ParameterSetName = 'GeoJSON', Mandatory)]
        [string]$GeoJSON
    )

    if ($PSCmdlet.ParameterSetName -eq 'GeoJSON') {
        $Json = $GeoJSON | ConvertFrom-Json
        if ($Json.Geometry.Type -eq 'multilinestring') 
        {
            $Coordinates = @()
            foreach($array in $json.geometry.coordinates) {
                foreach($arrayInArray in $array) {
                    $temp = $arrayInArray[0]
                    $arrayInArray[0] = $arrayInArray[1]
                    $arrayInArray[1] = $temp
                }
                $Coordinates += ,$array
            }

            $Positions = $Coordinates
            $Polyline = [Switch]::Present
        }

        if ($Json.Geometry.Type -eq 'linestring') 
        {
            $Coordinates = @()
            $json.geometry.coordinates | ForEach-Object {
                $temp = $_[0]
                $_[0] = $_[1]
                $_[1] = $temp
                $Coordinates += ,$_
            }
            $Positions = $Coordinates
            $Polyline = [Switch]::Present
        }

        if ($Json.Geometry.Type -eq 'polygon') 
        {
            $Coordinates = @()
            $json.geometry.coordinates[0] | ForEach-Object {
                $temp = $_[0]
                $_[0] = $_[1]
                $_[1] = $temp
                $Coordinates += ,$_
            }
            $Positions = $Coordinates
            $Polygon = [Switch]::Present
        }
    }

    @{
        type = "map-vector-layer"
        isPlugin = $true
        assetId = $AssetId
        id = $Id

        color = $Color.HtmlColor
        fillColor = $FillColor.HtmlColor
        fillOpacity = $FillOpacity
        weight = $Weight
        opacity = $Opacity
        circle = $Circle.IsPresent
        latitude = $Latitude
        longitude = $Longitude
        radius = $Radius
        polyline = $Polyline.IsPresent
        polygon = $Polygon.IsPresent
        positions = $Positions
        rectangle = $Rectangle.IsPresent
        latitudeTopLeft = $LatitudeTopLeft
        longitudeTopLeft = $LongitudeTopLeft
        latitudeBottomRight = $LatitudeBottomRight
        longitudeBottomRight = $LongitudeBottomRight
        popup = $Popup
    }
}