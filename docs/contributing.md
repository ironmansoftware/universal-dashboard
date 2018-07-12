# Contributing to Universal Dashboard

Universal Dashboard Community Edition as a free, open source platform for developing websites in PowerShell. In this post, we’ll go over some of the fundamentals of contributing to the platform from a source code perspective. 

## Requirements 

To build and run UD in a development environment you will need a couple of prerequisites. Universal Dashboard is built on .NET Core, ASP.NET Core, and React. To build and run the project, you’ll need the following. 

-	[.NET Core 2.0 + SDK](https://www.microsoft.com/net/download/windows)
-	[NodeJS](https://nodejs.org/en/)

## Building a release version

To build a release version, you can use the `build.ps1` script in the root of the `src` directory. 

To build release, use the following command line. 

```
.\build.ps1 -Configuration Release
```

If you don't want to wait for the help to build, you can use the `-NoHelp` script to skip building the help. 

## Build and Running in Debug Mode

To build in debug mode, you can run `dotnet build` from the `src` directory. 

```
cd .\src
dotnet build
```

To host the UI in the webpack dev server, you can run the npm task as follows.

```
cd .\src\client
npm run dev
```

The webpack dev server will run on port 10000. You should run your `Start-UDDashboard` commands on port 10001.

You can check out the integration tests to see how this is done. 

## Source Code Organization 

The source code is two parts. The first part is the PowerShell module. It is in the UniversalDashboard folder. It contains the cmdlets, providers, models and webserver. The JavaScript client portion of Universal Dashboard is stored in the client folder. 

