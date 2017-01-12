# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## 2017-01-12 - Release 2.2.0

This is the last release with Puppet 3 support!
- Fix several markdown issues
- Fix order of options to prevent swapping
- Add missing badges
- Add missing ToC
- Fix several rubocop issues
- Include the release pocket on Ubuntu Xenial and Yakkety.
- Bump min version_requirement for Puppet
- Modulesync with latest Vox Pupuli defaults

## 2016-10-05 - Release 2.1.0

- Modulesync with latest Vox Pupuli defaults
- Add support for Linux Mint
- Improve parameter validation and testing
- Add support for Ubuntu 16.04 and 16.10
- Ubuntu: Issue EOL warning for unsupported release

## 2016-05-26 - Release 2.0.0

- Drop Ruby1.8 Support
- Modulesync to latest Vox Pupuli defaults
- Improve spec tests
- Update documentation
- Add parameter to control reboot time
- Update default parameters for legacy_origin option
- Add options support

## 2016-01-11 - Release 1.1.1
### Changed

- CHANGELOG: Fixed comparison URL's for the releases
- CHANGELOG: Fixed changed header for 1.1.1
- Fix a facts lookup issue that caused us to break on Ubuntu

## 2016-01-08 - Release 1.1.0

### Added
- Support Raspbian
- Support for Debian Jessie and Ubuntu Wiley
- Documentation for `clean` parameter
- Clarification for `sleep`

### Fixed
- code is now `strict_variables` safe
- Fix bug that prevented us from working on Ubuntu

### Maintenance
- linter clean
- rubocop clean
- integrate in modulesync

## 2015-04-23 - Release 1.0.3

### Changed
- Tested on Puppet 4.
- Remove inclusion of `apt` class.

## 2015-04-22 - Release 1.0.2

### Changed
- Resolve some Travis related packaging issues.

## 2015-04-22 - Release 1.0.1

### Changed
- Resolve some Travis related packaging issues.

## 2015-04-22 - Release 1.0.0

### Added
- Full configuration of unattended-upgrades and all possible options for `APT::Periodic`.
- Test suite covering the current behaviour.
- README with full documentation.
- Boilerplate such as Gemfile, Travis configuration, LICENSE and so on.

[unreleased]: https://github.com/voxpupuli/puppet-unattended_upgrades/compare/HEAD...2.2.0
[2.2.0]: https://github.com/voxpupuli/puppet-unattended_upgrades/compare/2.2.0...2.1.0
[2.1.0]: https://github.com/voxpupuli/puppet-unattended_upgrades/compare/2.1.0...2.0.0
[2.0.0]: https://github.com/voxpupuli/puppet-unattended_upgrades/compare/2.0.0...1.1.1
[1.1.1]: https://github.com/voxpupuli/puppet-unattended_upgrades/compare/1.1.1...1.1.0
[1.1.0]: https://github.com/voxpupuli/puppet-unattended_upgrades/compare/1.1.0...1.0.2
[1.0.3]: https://github.com/voxpupuli/puppet-unattended_upgrades/compare/1.0.2...1.0.3
[1.0.2]: https://github.com/voxpupuli/puppet-unattended_upgrades/compare/1.0.1...1.0.2
[1.0.1]: https://github.com/voxpupuli/puppet-unattended_upgrades/compare/1.0.0...1.0.1
