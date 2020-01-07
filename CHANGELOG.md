# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Added support for Set-UDElement, Remove-UDElement and Clear-UDElement events on New-UDCheckbox (#1368) by [BoSen29](https://github.com/BoSen29)

### Added (Enterprise)
### Changed

- Extracted materialize from the core UD client libraries by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed JavaScript error when loading page by [adamdriscoll](https://github.com/adamdriscoll)
- Updated tests to correctly validate #1404 by [adamdriscoll](https://github.com/adamdriscoll)
- Connection management now uses a ConcurrentDictionary rather than locks by [adamdriscoll](https://github.com/adamdriscoll)

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
