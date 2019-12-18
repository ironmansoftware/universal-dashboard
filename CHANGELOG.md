# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Add support for the PATCH verb for REST APIs (#1365) by [adamdriscoll](https://github.com/adamdriscoll)
- Invoke-UDEndpoint can now trigger scheduled endpoints (#1381) by [BoSen29](https://github.com/BoSen29)

### Added (Enterprise)

### Changed

- Asset Service now uses thread-safe collections to try to address #1387 by [adamdriscoll](https://github.com/adamdriscoll)
- Improved Error message when access the $Session scope outside of an endpoint (#1369) by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed warning about missing folder when starting dashboard (#1373) by [adamdriscoll](https://github.com/adamdriscoll)

### Changed (Enterprise)

- Fixed issue where authorization policies would run too frequently by [adamdriscoll](https://github.com/adamdriscoll)
- Fixed issue where role-based access would not work when using Start-UDRestAPI by [adamdriscoll](https://github.com/adamdriscoll)

### Removed

### Removed (Enterprise)