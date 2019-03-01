# Build for Tests

Build the UnviersalDashboard Core in release more. 

```
.\src\build.ps1 -Configuration Release -NoHelp
```

Build the Material-UD module

```
.\src\UniversalDashboard.MaterialUI\build.ps1
```

# Running Tests

To run tests, execute the driver.ps1 file. We could update this file to execute only the file you want to run. Use -NoClose to 
avoid closing the browser\dashboard after running.

```
.\src\UniversalDashboard.MaterialUI\Tests\driver.ps1
```