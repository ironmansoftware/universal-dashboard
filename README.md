# Universal Dashboard 

[Documentation](https://docs.universaldashboard.io) | [Licensing](https://marketplace.universaldashboard.io/Pricing) | [Live Preview](https://poshud.com/) | [YouTube Videos](https://www.youtube.com/playlist?list=PL-0mHH7DlSiSZ4ozleNTUSXNkF6dlySVz) | [Forums](https://forums.universaldashboard.io/)


Create beautiful websites and dashboards using only PowerShell

![](/images/splash.png)

## License 

The Universal Dashboard project and module are licensed under the [GNU Lesser General Public License](https://www.gnu.org/licenses/lgpl-3.0.en.html). 

## Install

To install Universal Dashboard, you can use the following PowerShell command. 

```
Install-Module UniversalDashboard
```

To install Universal Dashboard Community Edition. you can use the following PowerShell command. 

```
Install-Module UniversalDashboard.Community
```

## Key Features

- PowerShell module to develop cross-platform, web-based dashboards
- Built in security using forms and OAuth
- Runs anywhere PowerShell Core and Windows PowerShell are available 
- Simple syntax to generate client and server side code
- Generate REST APIs with only PowerShell
- Extreme customization 

## Build Status

[![Build status](https://ci.appveyor.com/api/projects/status/ng3ye067j04eblwi?svg=true)](https://ci.appveyor.com/project/adamdriscoll/universal-dashboard)

## Examples

### [Chatroom](https://github.com/ironmansoftware/ud-chatroom)

Chat room created complete in Universal Dashboard

### [UDBGInfo](https://github.com/ironmansoftware/ud-bginfo)

BGInfo clone built using Universal Dashboard to display computer metrics. 

### [Clock](https://github.com/ironmansoftware/ud-clock)

Clock implementation built using SVG and Universal Dashboard. 

## Contribution Rules

Contributions are always welcome! Please follow the below rules. 

- Changes that alter the functionality, add features or fix bugs must have a Pester test validating the change. 
- Changes that add new parameters or cmdlets must document the cmdlets using or updating a Plaster markdown file. 
- PRs will not be accepted if they add functionality that would duplicate Enterprise Edition features or that render them inoperable. 
- Issues should include PowerShell, module and browser version. Logs are preferable. 

## Building Universal Dashboard

Universal Dashboard is a web application built on .NET Core, ASP.NET Core and React. You will need some build tools to get started. 

### Dependencies

- [.NET Core SDK 2.0+](https://www.microsoft.com/net/download/windows)
- [Node JS](https://nodejs.org/en/)

### Building 

To build the Universal Dashboard release build, run `build.ps1 -Configuration Release` from the root source directory. 

### Building and Debugging

Build the UniversalDashboard solution with `dotnet build`. 

```
dotnet build .\UniversalDashboard.sln
```

You can also build the .NET components of UD using Visual Studio 2017. 

Run the Webpack dev server. 

```
cd .\client
npm run dev
```

When building your dashboard in debug mode, make sure to use the port 10001. The Webpack dev server will listen on port 10000. If you open the dashboard in your browser, use the 10000 port. See the integration tests for examples. 



