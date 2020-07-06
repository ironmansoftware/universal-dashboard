# PowerShell Universal Dashboard 

[![Build Status](https://dev.azure.com/ironmansoftware/universal-dashboard/_apis/build/status/ironmansoftware.universal-dashboard?branchName=master)](https://dev.azure.com/ironmansoftware/universal-dashboard/_build/latest?definitionId=1&branchName=master)

Create beautiful, interactive websites with PowerShell. Universal Dashboard is part of [PowerShell Universal](https://ironmansoftware.com/powershell-universal/).

![](/images/splash.png)

## Resources

- [Documentation](https://docs.universaldashboard.io) 
- [PowerShell Universal Documentation](https://docs.ironmansoftware.com)
- [Licensing](https://ironmansoftware.com/product/powershell-universal/) 
- [Live Preview](https://poshud.com/) 
- [YouTube Videos](https://www.youtube.com/playlist?list=PL-0mHH7DlSiSZ4ozleNTUSXNkF6dlySVz) 
- [Forums](https://forums.universaldashboard.io/) 

## License 

The Universal Dashboard project and module are licensed under the [GNU Lesser General Public License](https://www.gnu.org/licenses/lgpl-3.0.en.html). 

## Install

You can install PowerShell Universal by downloading it from our [Downloads](https://ironmansoftware.com/downloads/) page. 

## Key Features

- PowerShell module to develop cross-platform web sites
- Runs anywhere PowerShell Core and Windows PowerShell are available 
- Simple syntax to generate client and server side code
- Extreme customization 


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
- Issues should include PowerShell, module and browser version. Logs are preferable. 

## Building Universal Dashboard

The Universal Dashboard frameworks and components are JavaScript libraries built on React with PowerShell integration.

### Dependencies

- [Node JS](https://nodejs.org/en/)
- [InvokeBuild](https://www.powershellgallery.com/packages/InvokeBuild)

### Building 

You can build this entire repository by running the build.ps1 script in the root of the src directory.

```
Set-Location ./src
Invoke-Build Build
```

### Running Tests

To run tests, you can use the build.ps1 Test task.

```
Set-Location ./src
Invoke-Build Test
```
