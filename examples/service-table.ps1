Start-UDDashboard -Content { 
    New-UDDashboard -Title "Server Performance Dashboard" -Color '#FF050F7F' -Content { 
        New-UDTable -Title "Server Information" -Headers @("Name", "CommandLine", "Status") -Endpoint {
              Get-Service | Select Name,CommandLine,Status | Out-UDTableData -Property @("Name", "CommandLine", "Status")
          }
      }
 } -Port 1001
         
