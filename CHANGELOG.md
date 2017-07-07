# Change log

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not impact the functionality of the module.

## [v3.0.0](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v3.0.0) (2017-07-07)
[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v2.2.0...v3.0.0)

**Implemented enhancements:**

- Add Debian 9 - Stretch Support [\#102](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/102) ([petems](https://github.com/petems))
- Use Data Types instead of validate\_\* functions [\#90](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/90) ([raphink](https://github.com/raphink))
- Ubuntu: Add 17.04 Zesty Zapus. [\#89](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/89) ([raoulbhatia](https://github.com/raoulbhatia))

**Fixed bugs:**

- Error when configuring unattended-upgrades [\#92](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/92)
- Adds ::apt containment to main class [\#103](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/103) ([petems](https://github.com/petems))

**Closed issues:**

- Not setting up a daily cron [\#87](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/87)

**Merged pull requests:**

- Update Debian upstream names [\#101](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/101) ([petems](https://github.com/petems))
- Refactor specs [\#100](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/100) ([petems](https://github.com/petems))
- Add tags to metadata.json [\#98](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/98) ([petems](https://github.com/petems))
- Allow newer apt modules to satisfy dependency [\#91](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/91) ([cpick](https://github.com/cpick))
- cleanup README - typos, remove splunk and fix ToC [\#83](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/83) ([pono](https://github.com/pono))
- Modulesync 0.18.0 [\#82](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/82) ([bastelfreak](https://github.com/bastelfreak))

## [v2.2.0](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v2.2.0) (2017-01-12)
[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v2.1.0...v2.2.0)

**Merged pull requests:**

- release 2.2.0 [\#81](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/81) ([bastelfreak](https://github.com/bastelfreak))
- Bump min version\_requirement for Puppet [\#79](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/79) ([juniorsysadmin](https://github.com/juniorsysadmin))
- Include the release pocket on Ubuntu Xenial and Yakkety. [\#75](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/75) ([MichaelGooden](https://github.com/MichaelGooden))
- Add missing badges [\#73](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/73) ([dhoppe](https://github.com/dhoppe))
- Fix order of options to prevent swapping of lines [\#72](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/72) ([leonkoens](https://github.com/leonkoens))

## [v2.1.0](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v2.1.0) (2016-10-05)
[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v2.0.0...v2.1.0)

**Implemented enhancements:**

- \[WIP\] Ubuntu updates [\#62](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/62) ([raoulbhatia](https://github.com/raoulbhatia))

**Closed issues:**

- Puppet 4 compatibility? [\#63](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/63)
- Version on Puppet Forge seems to be missing reboot\_time parameter in template [\#59](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/59)

**Merged pull requests:**

- Remove 'pe' requirement from metadata [\#66](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/66) ([alexjfisher](https://github.com/alexjfisher))
- Modulesync 0.9.1 [\#65](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/65) ([bastelfreak](https://github.com/bastelfreak))
- Make parameter validation more strict [\#64](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/64) ([pkkm](https://github.com/pkkm))
- LinuxMint: Add support for Linux Mint [\#61](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/61) ([raoulbhatia](https://github.com/raoulbhatia))

## [v2.0.0](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v2.0.0) (2016-05-26)
[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v1.1.1...v2.0.0)

**Implemented enhancements:**

- Dependency cycle error if sources are managed exclusively by puppet [\#28](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/28)

**Closed issues:**

- Documentation: random\_sleep [\#54](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/54)
- wrong documentation: legacy\_origin [\#50](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/50)
- unattended\_upgrades module not loading - breaks on Apt::Update dependency [\#48](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/48)

**Merged pull requests:**

- update default parameters for legacy\_origin option [\#58](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/58) ([GhostLyrics](https://github.com/GhostLyrics))
- Update from voxpupuli modulesync\_config [\#57](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/57) ([jyaworski](https://github.com/jyaworski))
- Add parameter to control reboot time [\#56](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/56) ([mpdude](https://github.com/mpdude))
- Small fix for random\_sleep documentation. The value is set to undef i… [\#55](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/55) ([spoofedpacket](https://github.com/spoofedpacket))
- add options support [\#52](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/52) ([b4ldr](https://github.com/b4ldr))
- Default `notify\_update` to false [\#51](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/51) ([daenney](https://github.com/daenney))

## [v1.1.1](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v1.1.1) (2016-01-11)
[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v1.1.0...v1.1.1)

**Merged pull requests:**

- release: 1.1.1 [\#47](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/47) ([daenney](https://github.com/daenney))
- Fix typo [\#46](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/46) ([mcanevet](https://github.com/mcanevet))

## [v1.1.0](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v1.1.0) (2016-01-09)
[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/1.0.3...v1.1.0)

**Fixed bugs:**

- content variable seems like it's required for the init file [\#18](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/18)

**Closed issues:**

- New release? [\#38](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/38)
- cannot set "install\_on\_shutdown" and "remove" [\#36](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/36)
- No way to define different keys for "auto" in different hiera sources [\#35](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/35)
- Clarify random\_sleep documentation [\#34](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/34)
- clean key of auto hash not documented [\#24](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/24)
- Not working on Ubuntu [\#22](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/22)
- potential dependency cycle for users [\#16](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/16)
- Unattended-Upgrade::Allowed-Origins variables don't work [\#15](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/15)
- unattended\_upgrades doesn't work with puppet \< 3.5.0 \(I think...\) [\#13](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/13)

**Merged pull requests:**

- prepare release of 1.1.0 [\#45](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/45) ([igalic](https://github.com/igalic))
- Doc and implementation fixes [\#44](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/44) ([daenney](https://github.com/daenney))
- Remediate rubocop offenses [\#43](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/43) ([rnelson0](https://github.com/rnelson0))
- cleanup\(params\) make linter happy [\#42](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/42) ([igalic](https://github.com/igalic))
- feat\(msync\) move secure line into .sync.yml [\#40](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/40) ([igalic](https://github.com/igalic))
- Rename reference to puppet-community [\#39](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/39) ([rnelson0](https://github.com/rnelson0))
- Include variable 'RandomSleep'. [\#33](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/33) ([fbarbeira](https://github.com/fbarbeira))
- Add optional notify\_update parameter [\#31](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/31) ([clauded](https://github.com/clauded))
- Small fix typo [\#27](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/27) ([fbarbeira](https://github.com/fbarbeira))
- Enhancements by merging Debian defaults, puppetlabs-apt and own research [\#26](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/26) ([raoulbhatia](https://github.com/raoulbhatia))
- Document auto -\> clean [\#25](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/25) ([zeha](https://github.com/zeha))
- Support for Raspbian [\#19](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/19) ([lbdr](https://github.com/lbdr))
- Check for strict\_variables setting before using defined\(\), fixes compatibility with Puppet \< 3.5.0 [\#17](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/17) ([apeeters](https://github.com/apeeters))
- unattended-upgrades are broken on Ubuntu by default due to origins typo [\#14](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/14) ([cpick](https://github.com/cpick))

## [1.0.3](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/1.0.3) (2015-04-23)
[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/1.0.2...1.0.3)

**Closed issues:**

- Duplicate declaration of Class\[Apt\] [\#12](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/12)

**Merged pull requests:**

- Gemfile: Upgrade to rspec-puppet 2.1.0 [\#11](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/11) ([daenney](https://github.com/daenney))

## [1.0.2](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/1.0.2) (2015-04-22)
[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/1.0.1...1.0.2)

## [1.0.1](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/1.0.1) (2015-04-22)
[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/1.0.0...1.0.1)

## [1.0.0](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/1.0.0) (2015-04-22)
**Closed issues:**

- Add a contributing.md [\#6](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/6)

**Merged pull requests:**

- Prepare 1.0.1 release: [\#10](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/10) ([daenney](https://github.com/daenney))
- Setup deploy [\#9](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/9) ([daenney](https://github.com/daenney))
- Rake travis changelog [\#8](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/8) ([daenney](https://github.com/daenney))
- Add metadata.json [\#7](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/7) ([underscorgan](https://github.com/underscorgan))
- travis: Test only latest Ruby and Puppet. [\#5](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/5) ([daenney](https://github.com/daenney))
- Test updates [\#4](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/4) ([underscorgan](https://github.com/underscorgan))
- Test fixes [\#1](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/1) ([underscorgan](https://github.com/underscorgan))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*