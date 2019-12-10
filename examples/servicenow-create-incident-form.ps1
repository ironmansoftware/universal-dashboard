Import-Module UniversalDashboard
$Dashboard = New-UDDashboard -Title "Report an Issue" -Content {

    New-UDInput -Title "Report an Issue" -Endpoint {
        param(
            [Parameter(Mandatory)]
            [string]$Summary,

            [Parameter(Mandatory)]
            [string]$Description,

            [Parameter(Mandatory)]
            [ValidateSet("Software", "Hardware", "Phone")]
            [string]$Category,
            
            [Parameter(Mandatory)]
            [ValidateSet("Low - Inconvenience", "Medium - Work Impacted", "High - I cannot complete my tasks")]
            [string]$Priority
        )

        $ServiceNowIncidentData = @{
            short_description = $Summary
            description       = $Description
            contact_type      = "UniversalDashboard"
            category          = $Category
            priority          = "3"
        }

        # Service NOW Configuration
        # Set headers
        $GlobalHeaders = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
        $GlobalHeaders.Add('Accept', 'application/json')
        $GlobalHeaders.Add('Content-Type', 'application/json')

        #Note - migrate this to local creds, vault, or other method
        $user = 'username'
        $pass = 'password'

        # Build & Set Auth header
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user, $pass)))
        $GlobalHeaders.Add('Authorization', ('Basic {0}' -f $base64AuthInfo))
    
        # Instance REST API - https://docs.servicenow.com/bundle/geneva-servicenow-platform/page/integrate/inbound_rest/task/t_GetStartedCreateInt.html
        $CreateIncidentURL = 'https://dev12345.service-now.com/api/now/table/incident'
        
        $PostResponse = Invoke-WebRequest -Headers $GlobalHeaders -Method "POST" -Uri $CreateIncidentURL -Body  ($ServiceNowIncidentData | ConvertTo-Json) -UseBasicParsing

        New-UDInputAction -Content {
            New-UDCard -Title "Incident: $(($PostResponse.Content | ConvertFrom-JSON).result.number) Created!" -Text "Your ticket for: ""$Summary"" has been submitted to the Service Desk!"
        }

    } -Validate
}

Start-UDDashboard -Dashboard $Dashboard -Port 10000