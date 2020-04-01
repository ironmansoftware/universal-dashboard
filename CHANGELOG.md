# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased 

### Added 

- Added -Key parameter to Clear-UDCache to clear a specific item (#1491) by [adamdriscoll](https://github.com/adamdriscoll)
- Added -LoadingComponent parameter to New-UDDynamic to allow for configuration of loading component (#1562) by [adamdriscoll](https://github.com/adamdriscoll)
- Added New-UDAutocomplete component by [adamdriscoll](https://github.com/adamdriscoll)
- Added support for OPTIONS endpoints by [adamdriscoll](https://github.com/adamdriscoll)
- Added -OnProcessing to New-UDForm to allow for custom loading dialogs by [adamdriscoll](https://github.com/adamdriscoll)
- Added -OnValidating to New-UDForm to support validating forms by [adamdriscoll](https://github.com/adamdriscoll)
- Added New-UDStepper and New-UDStep to support a wizard-like control by [adamdriscoll](https://github.com/adamdriscoll)
- Added New-UDSlider by [adamdriscoll](https://github.com/adamdriscoll)
- Added -FullScreen, -FullWidth, -MaxWidth to Show-UDModal by [adamdriscoll](https://github.com/adamdriscoll)
- Added -UseMesh to Nivo Line chart by [adamdriscoll](https://github.com/adamdriscoll)

### Changed 

- Fixed an issue where loading the module a second time would throw an error (#1569) by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed an issue where UD Enterprise would not successfully load pages when authentication was disabled by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed an issue where returning a PSCustomObject for use in a UDTable would not work by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed issue with Nivo chart keys and values being case sensitive (#691) by [adamdriscoll](https://github.com/adamdriscoll)

### Removed

- Removed -BackgroundColor, -FontColor, -BottomSheet, -FixedFoot from Show-UDModal by [adamdriscoll](https://github.com/adamdriscoll)
- Removed -UseDataColor from Nivo charts by [adamdriscoll](https://github.com/adamdriscoll)

## 3.0.0-beta1 - 3/28/2020

### Added 

- New-UDForm as a replacement for UDInput by [adamdriscoll](https://github.com/adamdriscoll)
- Support for vertical tabs in New-UDTabs by [adamdriscoll](https://github.com/adamdriscoll)
- New-UDDynamic for specifying dynamic sections of pages by [adamdriscoll](https://github.com/adamdriscoll)
- Multi-Select for New-UDSelect by [adamdriscoll](https://github.com/adamdriscoll)

### Changed

- UD now uses Material UI by default by [adamdriscoll](https://github.com/adamdriscoll)
- Implemented an enhanced JavaScript API for controls by [adamdriscoll](https://github.com/adamdriscoll)
- Implemented Material UI Controls by [adamdriscoll](https://github.com/adamdriscoll)
    - Expansion Panel 
    - Floating Action Button
    - Grid
    - Progress
    - Select 
    - Switch
    - Table 
    - Tabs
    - Textbox
    - TreeView 

## Unreleased (v2)

### Changed

- Fixed wrong definition of FontFamily in DefaultThight theme by [e1ze](https://github.com/e1ze)

## 2.9.0 - (2-14-2020)

### Added (Enterprise)

- Added login-page and login-card CSS classes so you can customize them via themes by [adamdriscoll](https://github.com/adamdriscoll)

### Changed

- Fixed an is where -ReplaceToast on Show-UDToast would not replace a toast (https://github.com/ironmansoftware/universal-dashboard/issues/1449) by [adamdriscoll](https://github.com/adamdriscoll)
- Changed web.config to use PowerShell.exe rather than UD.Server.exe by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed an issue where -background color of buttons wouldn't work by [BoSen29](https://github.com/BoSen29)

### Changed (Enterprise)

- Fixed issue where the login button wouldn't change font color by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed issue where $Session would be $null when using authorization policies and Windows Auth by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed a [security issue](https://www.linkedin.com/feed/update/urn:li:activity:6634158707653570560) with AdminMode by [adamdriscoll](https://github.com/adamdriscoll)

### Removed 

- Removed Publish-UDDashboard by [adamdriscoll](https://github.com/adamdriscoll)
- Removed UniversalDashboard.Server.exe by [adamdriscoll](https://github.com/adamdriscoll)

## 2.8.3 - (1-31-2020)

### Added 

- Community edition now exposes the $Session variable that was added in 2.8.2 Enterprise by [adamdriscoll](https://github.com/adamdriscoll)
- Added styling support to UD-Button by [BoSen29](https://github.com/BoSen29)

### Changed

- Fixed issue with DarkRounded theme - https://github.com/ironmansoftware/universal-dashboard/issues/1467 by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed issue with Azure theme - https://github.com/ironmansoftware/universal-dashboard/issues/1464 by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed issue with non-Default themes throwing exceptions - https://github.com/ironmansoftware/universal-dashboard/issues/1471 by [adamdriscoll](https://github.com/adamdriscoll)
- UniversalDashboard.renderComponent will now return already rendered components by [adamdriscoll](https://github.com/adamdriscoll)

### Changed (Enterprise)

- Fixed issue where the tabs on the Admin diagnostics page would not use the correct theme - https://github.com/ironmansoftware/universal-dashboard/issues/1472 by [adamdriscoll](https://github.com/adamdriscoll)
- Authorization policies can now be assigned to endpoints - https://github.com/ironmansoftware/universal-dashboard/issues/1442 by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed Azure theme to work with Admin Toolbar - #1465 - by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed issue where the signout link was missing - https://github.com/ironmansoftware/universal-dashboard/issues/1481 by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed an issue where signing out and signing back in would result in a blank screen by [adamdriscoll](https://github.com/adamdriscoll)

## 2.8.2 (1-20-2019)

### Added

- Added support for Set-UDElement, Remove-UDElement and Clear-UDElement events on New-UDCheckbox (#1368) by [BoSen29](https://github.com/BoSen29)
- Added support for UDTab load data when his the active tab (#1392, #1169) by [alongvili](https://github.com/alongvili)
- Allow Specification of Font in Themes
- Added -RenderWhenActive to New-UDTabContainer to only render tabs when they are active by [adamdriscoll](https://github.com/adamdriscoll)

### Added (Enterprise)
### Changed

- Extracted materialize from the core UD client libraries by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed JavaScript error when loading page by [adamdriscoll](https://github.com/adamdriscoll)
- Updated tests to correctly validate #1404 by [adamdriscoll](https://github.com/adamdriscoll)
- Fix Set-UDClipboard doesn't work inside modals. (#1292) by [alongvili](https://github.com/alongvili)
- Fix Remove-UDElement on textbox doesn't remove label (#1378) by [alongvili](https://github.com/alongvili)
- Fix New-CarouselItem URL parameter not functioning (#1417) by [alongvili](https://github.com/alongvili)
- Fix UDMUChip -OnDelete parameter not working (#1423) by [alongvili](https://github.com/alongvili)
- Connection management now uses a ConcurrentDictionary rather than locks by [adamdriscoll](https://github.com/adamdriscoll)
- Changed Active Tab Color and Font Slightly to be more uniform with rest of dashboard
- Fixed issue where Get-UDDashboard wouldn't return anything when hosting in IIS by [adamdriscoll](https://github.com/adamdriscoll)

### Changed (Enterprise)

- Changed how authorization policies are run by [adamdriscoll](https://github.com/adamdriscoll)
- Admin mode is now a toolbar rather than a floating action button by [adamdriscoll](https://github.com/adamdriscoll)
- Updated the look and feel of the admin mode licensing and diagnostics pages by [adamdriscoll](https://github.com/adamdriscoll)

### Removed
### Removed (Enterprise)

## 2.8.1 (12-20-2019)

### Added

- Add support for the PATCH verb for REST APIs (#1365) by [adamdriscoll](https://github.com/adamdriscoll)
- Invoke-UDEndpoint can now trigger scheduled endpoints (#1381) by [BoSen29](https://github.com/BoSen29)

### Added (Enterprise)

### Changed

- Asset Service now uses thread-safe collections to try to address #1387 by [adamdriscoll](https://github.com/adamdriscoll)
- Improved Error message when access the $Session scope outside of an endpoint (#1369) by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed warning about missing folder when starting dashboard (#1373) by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed issue where Enable-UDLogging would not work after running Disable-UDLogging (#1389) by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed the help for Set-UDCookie by [adamdriscoll](https://github.com/adamdriscoll)

### Changed (Enterprise)

- Fixed issue where authorization policies would run too frequently by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed issue where role-based access would not work when using Start-UDRestAPI by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed issue where the $ClaimsPrincipal variable would not be defined in a claims policy by [adamdriscoll](https://github.com/adamdriscoll)
### Removed

### Removed (Enterprise)
