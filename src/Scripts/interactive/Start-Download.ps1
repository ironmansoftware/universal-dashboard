function Start-UDDownload {
    <#
    .SYNOPSIS
    Starts the download of a file within the dashboard.
    
    .DESCRIPTION
    Starts the download of a file within the dashboard. Only text files are supported
    
    .PARAMETER FileName
    The name of the file. 

    .PARAMETER StringData
    The data to be written to the file.

    .PARAMETER ContentType 
    The content type of the file.
    
    .EXAMPLE
    New-UDButton -Text 'Click Me' -OnClick {
        Start-UDDownload -FileName 'myfile.txt' -StringData 'Hello World' -ContentType 'text/plain'
    }
    #>
    param(
        [Parameter()]
        [string]$FileName = "text.txt",
        [Parameter(Mandatory)]
        [string]$StringData,
        [Parameter()]
        [string]$ContentType = "text/plain"
    )

    $Data = @{
        fileName    = $FileName
        stringData  = $StringData
        contentType = $ContentType
    }

    $DashboardHub.SendWebSocketMessage($ConnectionId, "download", $data)
}