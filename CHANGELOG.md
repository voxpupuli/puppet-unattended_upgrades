# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v9.0.0](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v9.0.0) (2025-09-10)

[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v8.2.0...v9.0.0)

**Breaking changes:**

- Drop puppet, update openvox minimum version to 8.19 [\#263](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/263) ([TheMeier](https://github.com/TheMeier))

**Implemented enhancements:**

- metadata.json: Add OpenVox [\#259](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/259) ([jstraw](https://github.com/jstraw))

## [v8.2.0](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v8.2.0) (2024-12-25)

[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v8.1.0...v8.2.0)

**Implemented enhancements:**

- Add skip\_updates\_on\_metered\_connection option [\#255](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/255) ([rrotter](https://github.com/rrotter))
- puppetlabs/apt: Allow 10.x [\#254](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/254) ([rrotter](https://github.com/rrotter))
- Support passing dpkg options [\#251](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/251) ([deric](https://github.com/deric))
- More specific type for `extra_origins` [\#245](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/245) ([davidmhewitt](https://github.com/davidmhewitt))

**Closed issues:**

- buildin function merge got deprecated in puppet 8 [\#228](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/228)

**Merged pull requests:**

- lint false positive [\#248](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/248) ([sebbASF](https://github.com/sebbASF))

## [v8.1.0](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v8.1.0) (2023-10-30)

[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v8.0.0...v8.1.0)

**Implemented enhancements:**

- Add Debian 12 support [\#236](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/236) ([weaselp](https://github.com/weaselp))

## [v8.0.0](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v8.0.0) (2023-06-23)

[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v7.1.0...v8.0.0)

**Breaking changes:**

- Drop Puppet 6 support [\#226](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/226) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Add ubuntu 22.04 support [\#232](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/232) ([bastelfreak](https://github.com/bastelfreak))
- puppetlabs/stdlib: Allow 9.x [\#231](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/231) ([bastelfreak](https://github.com/bastelfreak))
- Add puppet 8 support [\#230](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/230) ([bastelfreak](https://github.com/bastelfreak))
- Add allow\_downgrade option to unattended-upgrades.erb [\#219](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/219) ([wiemk](https://github.com/wiemk))

**Fixed bugs:**

- Fix default LinuxMint origins so they pass validation [\#218](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/218) ([djmofcourse](https://github.com/djmofcourse))

**Closed issues:**

- document the origin configurations in README [\#105](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/105)

**Merged pull requests:**

- README.md: add example for `origins` parameter [\#224](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/224) ([clambertus](https://github.com/clambertus))
- Fix broken Apache-2 license [\#223](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/223) ([bastelfreak](https://github.com/bastelfreak))

## [v7.1.0](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v7.1.0) (2022-08-28)

[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v7.0.0...v7.1.0)

**Implemented enhancements:**

- Add reboot\_withusers option to unattended-upgrades.erb [\#214](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/214) ([jps-help](https://github.com/jps-help))
- Support the option Unattended-Upgrade::Package-Whitelist-Strict [\#213](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/213) ([ghost](https://github.com/ghost))

**Fixed bugs:**

- types/origin: fix typo in comment [\#212](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/212) ([kenyon](https://github.com/kenyon))

**Merged pull requests:**

- puppetlabs/apt: Allow 9.x [\#215](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/215) ([bastelfreak](https://github.com/bastelfreak))

## [v7.0.0](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v7.0.0) (2022-06-16)

[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v6.0.0...v7.0.0)

**Breaking changes:**

- Replace legacy Allowed-Origins with Origins-Pattern on all distros [\#204](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/204) ([towo](https://github.com/towo))
- retire options support [\#190](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/190) ([anarcat](https://github.com/anarcat))

**Implemented enhancements:**

- Cleanup legacy fact usage [\#210](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/210) ([bastelfreak](https://github.com/bastelfreak))
- Add only\_on\_ac\_power option to unattended-upgrades.erb [\#208](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/208) ([jps-help](https://github.com/jps-help))

**Fixed bugs:**

- Add missing 'always' value support to periodic parameters \(every n-days\) [\#206](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/206) ([Hufschmidt](https://github.com/Hufschmidt))
- params: debian default: re-add main origin [\#201](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/201) ([kenyon](https://github.com/kenyon))

**Closed issues:**

- \[Ubuntu 20.04.3\] Traceback when running unattended-upgrades --debug --dry-run [\#202](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/202)

**Merged pull requests:**

- README: remove legacy\_origin [\#205](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/205) ([kenyon](https://github.com/kenyon))

## [v6.0.0](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v6.0.0) (2021-09-29)

[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v5.1.0...v6.0.0)

**Breaking changes:**

- Drop support for Ubuntu 19.10 \(EOL\) [\#198](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/198) ([smortex](https://github.com/smortex))
- Drop support of Puppet 5 \(EOL\) [\#196](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/196) ([smortex](https://github.com/smortex))
- Drop support for Debian 8, 9 and Ubuntu 16.04 \(EOL\) [\#195](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/195) ([smortex](https://github.com/smortex))

**Implemented enhancements:**

- Add support for Puppet 7 [\#197](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/197) ([smortex](https://github.com/smortex))
- Add support for Debian 11 [\#193](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/193) ([sboyd-m](https://github.com/sboyd-m))
- add support for Package-Whitelist [\#188](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/188) ([moritz-makandra](https://github.com/moritz-makandra))
- add SyslogEnable and SyslogFacility options to unattended-upgrades.erb [\#182](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/182) ([kenyon](https://github.com/kenyon))
- add the Unattended-Upgrade::MailReport setting to unattended-upgrades.erb [\#181](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/181) ([kenyon](https://github.com/kenyon))
- Support Ubuntu Extended Security Maintenance \(ESM\) [\#180](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/180) ([raoulbhatia](https://github.com/raoulbhatia))

**Fixed bugs:**

- disable by default and deprecate dpkg "options" parameter [\#191](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/191) ([anarcat](https://github.com/anarcat))

**Closed issues:**

- Debian 11 changes name of security suite [\#187](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/187)

**Merged pull requests:**

- Add a basic acceptance test [\#194](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/194) ([smortex](https://github.com/smortex))
- Allow stdlib 8.0.0 [\#192](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/192) ([smortex](https://github.com/smortex))
- Update dependencies [\#189](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/189) ([saz](https://github.com/saz))
- README: fix wording about the mail hash [\#183](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/183) ([kenyon](https://github.com/kenyon))

## [v5.1.0](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v5.1.0) (2020-08-23)

[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v5.0.0...v5.1.0)

**Implemented enhancements:**

- Add support for Debian 10  [\#150](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/150)
- Support Remove-New-Unused-Dependencies [\#106](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/106)
- Add new options remove\_new\_unused\_deps and remove\_unused\_kernel [\#177](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/177) ([gfa](https://github.com/gfa))

**Closed issues:**

- No version of 'puppet-unattended\_upgrades' can satisfy all dependencies [\#167](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/167)

**Merged pull requests:**

- unattended-upgrades.erb: update signal comment [\#178](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/178) ([kenyon](https://github.com/kenyon))
- Revert "Add Puppet management headers in the config files" [\#173](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/173) ([smortex](https://github.com/smortex))
- Add Debian 10 support [\#172](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/172) ([ekohl](https://github.com/ekohl))

## [v5.0.0](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v5.0.0) (2020-05-22)

[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v4.0.0...v5.0.0)

**Breaking changes:**

- Drop EOL Linux Mint versions 13 and 17 [\#168](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/168) ([ekohl](https://github.com/ekohl))
- Drop Ubuntu 14.04 [\#164](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/164) ([ekohl](https://github.com/ekohl))
- Update Ubuntu releases per official support/EOL list [\#160](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/160) ([raoulbhatia](https://github.com/raoulbhatia))
- drop Ubuntu 14.04 support [\#149](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/149) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Allow additional origins without replacing the default one. [\#142](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/142) ([fetzerms](https://github.com/fetzerms))

**Fixed bugs:**

- incorrect Debian OS origin string [\#145](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/145)

**Closed issues:**

- new release [\#158](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/158)
- Typo in Readme [\#155](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/155)
- License in metadata.json doesn't match the dual licensing documented in the README. [\#93](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/93)

**Merged pull requests:**

- Unify specs for all supported operating systems [\#170](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/170) ([ekohl](https://github.com/ekohl))
- Correct tests for catalog compilation failure [\#169](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/169) ([ekohl](https://github.com/ekohl))
- Remove the $xfacts variable [\#165](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/165) ([ekohl](https://github.com/ekohl))
- Drop file mode checking [\#163](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/163) ([mmoll](https://github.com/mmoll))
- Add Puppet management headers in the config files [\#162](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/162) ([arthurbarton](https://github.com/arthurbarton))
- Spec: Follow puppetlabs-apt "MODULES-10548: make files readonly" [\#161](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/161) ([raoulbhatia](https://github.com/raoulbhatia))
- Fixed README typo.  `archive_internal` to `archive_interval` [\#156](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/156) ([jhawz](https://github.com/jhawz))
- Allow puppetlabs/stdlib 6.x [\#154](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/154) ([dhoppe](https://github.com/dhoppe))
- Remove duplicate CONTRIBUTING.md file [\#152](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/152) ([dhoppe](https://github.com/dhoppe))
- Update README.md [\#151](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/151) ([thepro101](https://github.com/thepro101))
-  \* fix: debian origins since archive name changes, moved to codename … [\#148](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/148) ([deubert-it](https://github.com/deubert-it))
- Allow puppetlabs/apt 7.x [\#147](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/147) ([scoopex](https://github.com/scoopex))
- Additional sanitization of params [\#143](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/143) ([fetzerms](https://github.com/fetzerms))

## [v4.0.0](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v4.0.0) (2019-04-15)

[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v3.2.1...v4.0.0)

**Breaking changes:**

- modulesync 2.7.0 and drop puppet 4 [\#140](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/140) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Add support for Unattended-Upgrade::Update-Days [\#139](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/139) ([ostavnaas](https://github.com/ostavnaas))
- Support support for the KDE Neon distribution [\#138](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/138) ([smortex](https://github.com/smortex))

**Closed issues:**

- Support puppetlabs-apt \> 5 [\#133](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/133)

## [v3.2.1](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v3.2.1) (2018-10-14)

[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v3.2.0...v3.2.1)

**Merged pull requests:**

- modulesync 2.2.0 and allow puppet 6.x [\#134](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/134) ([bastelfreak](https://github.com/bastelfreak))
- Allow puppetlabs-apt 5 & 6 [\#132](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/132) ([JayH5](https://github.com/JayH5))
- allow puppetlabs/stdlib 5.x [\#130](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/130) ([bastelfreak](https://github.com/bastelfreak))
- Update README.md [\#129](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/129) ([TheLimey](https://github.com/TheLimey))

## [v3.2.0](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v3.2.0) (2018-06-12)

[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v3.1.0...v3.2.0)

**Implemented enhancements:**

- Allow configuration of Unattended-Upgrade::Sender parameter [\#119](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/119)
- Optional argument for specifing the Unattended-Upgrade::Sender config flag [\#120](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/120) ([LarsErikP](https://github.com/LarsErikP))

**Closed issues:**

- \(Confirm\) Ubuntu 18.04 support [\#124](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/124)
- Typo - README.md - Reference/options "force\_connew" [\#109](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/109)

**Merged pull requests:**

- Add Ubuntu 18.04 LTS "bionic" to the list of supported OSes \(fixes \#124\) [\#125](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/125) ([mpdude](https://github.com/mpdude))
- Remove docker nodesets [\#123](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/123) ([bastelfreak](https://github.com/bastelfreak))
- drop EOL OSs; fix puppet version range [\#121](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/121) ([bastelfreak](https://github.com/bastelfreak))
- Fix typo [\#117](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/117) ([6uhrmittag](https://github.com/6uhrmittag))

## [v3.1.0](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v3.1.0) (2017-12-09)

[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v3.0.1...v3.1.0)

**Closed issues:**

- Duplicate declaration due to contain ::apt [\#110](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/110)

**Merged pull requests:**

- release 3.1.0 [\#116](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/116) ([bastelfreak](https://github.com/bastelfreak))
- Add Ubuntu artful [\#115](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/115) ([danielhoherd](https://github.com/danielhoherd))

## [v3.0.1](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v3.0.1) (2017-10-28)

[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v3.0.0...v3.0.1)

**Closed issues:**

- Allowed-Origins contains ${distro\_id}:${distro\_codename} [\#107](https://github.com/voxpupuli/puppet-unattended_upgrades/issues/107)

**Merged pull requests:**

- Don't `contain` `apt` but `include` instead [\#111](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/111) ([alexjfisher](https://github.com/alexjfisher))

## [v3.0.0](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v3.0.0) (2017-07-07)

[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v2.2.0...v3.0.0)

**Breaking changes:**

- Use Data Types instead of validate\_\* functions [\#90](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/90) ([raphink](https://github.com/raphink))

**Implemented enhancements:**

- Add Debian 9 - Stretch Support [\#102](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/102) ([petems](https://github.com/petems))
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
- Default `notify_update` to false [\#51](https://github.com/voxpupuli/puppet-unattended_upgrades/pull/51) ([daenney](https://github.com/daenney))

## [v1.1.1](https://github.com/voxpupuli/puppet-unattended_upgrades/tree/v1.1.1) (2016-01-11)

[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/v1.1.0...v1.1.1)

**Merged pull requests:**

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

[Full Changelog](https://github.com/voxpupuli/puppet-unattended_upgrades/compare/886245f2cb7614a8c749d34e6f08ee17b92c970f...1.0.0)

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



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
