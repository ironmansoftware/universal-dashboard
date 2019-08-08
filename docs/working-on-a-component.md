# Working on a Component

This document is intended to help you add a feature or fix a bug in a component.

## Step 1: Build Universal Dashboard

Run the build script in VS Code using the 'Build Debug' task or by running the build script manually. 

```
.\src\build.ps1 -Configuration Debug -NoHelp
```

You won't have to do this every time you want to edit a component.

## Step 2: Start the Materialize Webpack Dev Server

You can start the Materialize Webpack Dev Server by running the 'Start Materialize Webpack Dev Server' task in VS Code or by running npm directly. 

```
cd .\src\UniversalDashboard.Materialize
npm run dev
```

## Step 3: Modify the component 

The component code is in the `Components` folder and the PowerShell script is in the `Scripts` folder for the components.

```
cd .\src\UniversalDashboard.Materialize\Components
cd .\src\UniversalDashboard.Materialize\Scripts
```

## Step 4: Validate the Component

You should write a test case that reproduces the bug or uses the new feature in the `.\src\UniversalDashboard.Materialize\Tests` folder. Once you have the test stubbed out, you can then run the test. 

An example test stub would look like this. 

```
    Context "Floating" {
        Set-TestDashboard {
            New-UDButton -Text "Click Me" -Id "button" -Floating
        } 
        
        It "is floating" {
            
        }
    }
```

When you run the test, the browser will open and the button will quickly be shown. If you wish to leave the browser open so that you can work on your test or component, use `Wait-Debugger` to pause the test. 

```
    Context "Floating" {
        Set-TestDashboard {
            New-UDButton -Text "Click Me" -Id "button" -Floating
        } 
        
        It "is floating" {
            Wait-Debugger
        }
    }
```

You can now edit the JSX file for the component and the webpack dev server will automatically recompile the component. 

If you edit the PowerShell script, you will have to restart your test script. 
