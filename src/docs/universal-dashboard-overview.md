# PowerShell Universal Dashboard

PowerShell Universal Dashboard is a PowerShell module for developing web-based dashboards and REST APIs. It's compatible with PowerShell Core and Windows PowerShell which enables cross-platform execution. Built on ASP.NET Core, it is capable of running self-hosted in the PowerShell command line or within Azure and IIS. Using a simple domain-specific language built around the structure of the dashboard, the look and feel as well as the backend endpoints are all developed in the same script. 

# Architecture

PowerShell Universal Dashboard is built on modern web technologies as well as .NET Core. Some of the technologies used in the product include: 

- PowerShell Core
- .NET Core
- ASP.NET Core
- ReactJS 
- ChartJS
- Griddle

# Getting started with Universal Dasbhboard 

Install the UniversalDashboard module. It is available on the PowerShell Gallery. 

```
Install-Module UniversalDashboard -Scope CurrentUser -Force 
```

Create and start a new basic dashboard. 

```
- Start-UDDashboard -Content {
     New-UDDashboard -Title "Hello, World!" -Content {
         New-UDCounter -Title "Random Number" -Icon user -Endpoint {
             Get-Random 
         }
     }
}
Start-Process http://localhost
```

# Available Components 

## Charts and Monitors

Chart data on line, bar, area and donut charts. Use multiple datasets to show different visualizations on the same chart. Use monitors to show constantly updating metrics like memory usage and CPU time. 

## Grids and tables

Display data in grid and table format. Use grid functionality to enable paging of data and table for a simple output without paging. 

## Layout 

Use built in layout functionality to organize the dashboard into rows and columns. The dashboard automatically adjusts for screen size and works well on mobile devices. 

## Pages

Create multi-page dashboards and cycle through them automatically. Develop dynamic pages that respond to user input and can render their content on the fly. 

## Input

Define endpoints that take input and automatically create client-side input controls based on the param block of your endpoint. Respond to input with messages, new content or redirecting to local or remote pages. 

## Other Components 

Links, images and cards are also available to further customize the dashboard. 

# Login Pages

Universal Dashboard supports login pages to authenticate users before allowing them to view the dashboard. Using basic forms authentication, you can pass credentials to a PowerShell script block and choose to authenticate the user however you see fit. 

Other OAuth providers are also available. They include: 

- Microsoft
- Facebook
- Twitter
- Google 

Once authenticated, Endpoints defined within the dashboard have access to the user name of the session that is making the request. 

# REST APIs

Universal Dashboard can also create REST APIs. Using custom routes you can take parameters from the URLs sent to the API and automatically pass route variables into PowerShell script blocks. 

To create simple REST API, you can do the following. 

```
Start-UDRestApi -Endpoints @(
    New-UDEndpoint -Url '/process' -Method GET -Endpoint {
        Get-Process | Select -Expand Name | ConvertTo-Json
    }

    New-UDEndpoint -Url '/process/:name' -Method POST -Endpoint {
        param($name)

        Start-Process $name -PassThru | Select -Expand Name | ConvertTo-Json
    }
)

Invoke-RestApi http://localhost/api/process 
```

# Roadmap 

More and more components are quickly being added to Universal Dashboard in addition to further customization of existing components. Increased performance and developer experience ar also a core target for anything done within Universal Dashboard. Some of the features coming soon include:

- Authentication for REST APIs
- Support for additional types of data visualizations
- Automatic import of modules and functions into endpoints
- Dynamic rows and columns