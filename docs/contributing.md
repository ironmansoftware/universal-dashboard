# Contributing

Universal Dashboard is comprised of PowerShell, C# and JavaScript. This document is intended to provide the details necessary to configure your environment and develop features and fix bugs in the Universal Dashboard repository. 

## Configuring your Environment

You will need the following installed on your machine. 

- [.NET Core v2.2 SDK](https://dotnet.microsoft.com/download)
- [Visual Studio](https://visualstudio.microsoft.com/free-developer-offers/) or [Visual Studio Code](https://code.visualstudio.com/)
- [NodeJS](https://nodejs.org/en/)
- [Firefox](https://www.mozilla.org/en-US/firefox/new/) - For integration tests

## Executing the Build

You can execute the build using the [build.ps1](https://github.com/ironmansoftware/universal-dashboard/blob/master/src/build.ps1) in the `src` folder.

By the default, the build will execute in the Debug configuration. If you are producing a build for development purposes, this configuration is what you will want to use. If you are producing a build for release purposes, use the Release configuration.

```
.\build.ps1 -Configuration Release
```

When building the module, PlatyPS is used to generate the MAML help files from markdown. This is a time consuming process due to performance issues with the PlatyPS module. You can avoid building the hep with the `-NoHelp` switch.

```
.\build.ps1 -NoHelp
```

The output from the build will be staged into the `.\src\output`. 

### Executing the Build in VS Code

To execute the build in VS Code, you can use the 'Build Debug' and 'Build Release' tasks. 

## Running Tests

The test suite is primarily comprised of Selenium tests written using the Selenium PowerShell module and Pester. You will need to have Firefox installed to execute the test suite. The test suite is divided into several different sections.

### Running the Core tests

 The core tests can be found in the [src\UniversalDashboard.UITest](https://github.com/ironmansoftware/universal-dashboard/tree/master/src/UniversalDashboard.UITest) folder.  

 To run the entire test suite, execute the `shebang.tests.ps1` with the `-Integration` switch.

 `.\src\UniversalDashboard.UITest\shebang.tests.ps1 -Integration`

 ### Running the Materialize Tests

 The Materialize tests execute tests against the Materialize components. You can run the Materialize tests in release and debug modes. In debug mode, you can run the webpack dev server to allow for live updates to the code. Your browser will refresh when you make changes. 

 To run the tests, execute the `driver.ps1` file in the [Materialize tests folder](https://github.com/ironmansoftware/universal-dashboard/tree/master/src/UniversalDashboard.Materialize/Tests).

 To run in release mode, use the `-Release` switch.

 ```
 .\src\UniversalDashboard.Materialize\Tests\driver.ps1 -Release
 ```

 To run in debug mode, first start the webpack-dev-server and the execute the driver without the release flag. Any changes you make in the Materialize folder will cause webpack to rebuild the JSX files and reload the browser. This is the fastest way to develop controls for Materialize. 

 You will need to start a new terminal to run the webpack-dev-server because it will block the console. 

_First Terminal_

 ```
 cd .\src\UniversalDashboard.Materialize
 npm run dev
 ```

 _Second Terminal_

 ```
.\src\UniversalDashboard.Materialize\Tests\driver.ps1
 ```

You can run tests for a single component by using the `-Control` parameter. Just provide the name of the control you'd like to run tests for. 

```
.\src\UniversalDashboard.Materialize\Tests\driver.ps1 -Control fab
```

To output an Nunit XML file with the test results, use the `-OutputTestResultXml`.

```
.\src\UniversalDashboard.Materialize\Tests\driver.ps1 -OutputTestResultXml
```

### Running the tests in VS Code

To run the tests in VS Code, you can first run the 'Run Materialize Webpack Server' command and then run the 'Run Materialize Test' command. The `Run Materialize Test` command will ask for the name of the control you'd like to run. 

 ### Running the Material UI Tests

 The MaterialUI tests execute tests against the MaterialUI components. You can run the MaterialUI tests in release and debug modes. In debug mode, you can run the webpack dev server to allow for live updates to the code. Your browser will refresh when you make changes. 

 To run the tests, execute the `driver.ps1` file in the [MaterialUI tests folder](https://github.com/ironmansoftware/universal-dashboard/tree/master/src/UniversalDashboard.MaterialUI/Tests).

 To run in release mode, use the `-Release` switch.

 ```
 .\src\UniversalDashboard.MaterialUI\Tests\driver.ps1 -Release
 ```

 To run in debug mode, first start the webpack-dev-server and the execute the driver without the release flag. Any changes you make in the MaterialUI folder will cause webpack to rebuild the JSX files and reload the browser. This is the fastest way to develop controls for MaterialUI. 

 You will need to start a new terminal to run the webpack-dev-server because it will block the console. 

_First Terminal_

 ```
 cd .\src\UniversalDashboard.MaterialUI
 npm run dev
 ```

 _Second Terminal_

 ```
.\src\UniversalDashboard.MaterialUI\Tests\driver.ps1
 ```

You can run tests for a single component by using the `-Control` parameter. Just provide the name of the control you'd like to run tests for. 

```
.\src\UniversalDashboard.MaterialUI\Tests\driver.ps1 -Control fab
```

To output an Nunit XML file with the test results, use the `-OutputTestResultXml`.

```
.\src\UniversalDashboard.MaterialUI\Tests\driver.ps1 -OutputTestResultXml
```

## Debugging the Webserver

The webserver is written in C# and is started when you execute `Start-UDDashboard`. In order to debug the webserver you will need to attach Visual Studio or Visual Studio Code to an instance of powershell.exe or pwsh.exe that has or will load the UD module. 

First, you should build the web server in debug. 

```
.\src\build.ps1 -Configuration Debug -NoHelp
```

You can now create your test dashboard. This can either be part of a Pester test or simply a PS1 script that loads the module from the output directory. You may need to uninstall UniversalDashboard from your PSModulePath.

```
Import-Module C:\src\UniversalDashboard.Community\src\output\UniversalDashboard.Community.psd1
Start-UDDashboard -Port 1000
```
