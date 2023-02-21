# Unattended Upgrades module for Puppet

[![Build Status](https://github.com/voxpupuli/puppet-unattended_upgrades/workflows/CI/badge.svg)](https://github.com/voxpupuli/puppet-unattended_upgrades/actions?query=workflow%3ACI)
[![Release](https://github.com/voxpupuli/puppet-unattended_upgrades/actions/workflows/release.yml/badge.svg)](https://github.com/voxpupuli/puppet-unattended_upgrades/actions/workflows/release.yml)
[![Puppet Forge](https://img.shields.io/puppetforge/v/puppet/unattended_upgrades.svg)](https://forge.puppetlabs.com/puppet/unattended_upgrades)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/puppet/unattended_upgrades.svg)](https://forge.puppetlabs.com/puppet/unattended_upgrades)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/puppet/unattended_upgrades.svg)](https://forge.puppetlabs.com/puppet/unattended_upgrades)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/puppet/unattended_upgrades.svg)](https://forge.puppetlabs.com/puppet/unattended_upgrades)
[![puppetmodule.info docs](http://www.puppetmodule.info/images/badge.png)](http://www.puppetmodule.info/m/puppet-unattended_upgrades)
[![AGPL v3 License](https://img.shields.io/github/license/voxpupuli/puppet-unattended_upgrades.svg)](LICENSE)

#### Table of Contents

1. [Overview](#overview)
1. [Module Description](#module-description)
1. [Setup](#setup)
1. [Usage](#usage)
1. [Reference](#reference)
    * [Classes](#classes)
    * [Parameters](#parameters)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [License](#license)

## Overview

The unattended\_upgrades module allows for the installation and configuration
of automatic security (and other) updates through apt.

This functionality used to be part of the puppetlabs-apt module but was split
off into its own module.

## Module Description

The unattended\_upgrades module automates the configuration of apt package updates.

## Setup

### What unattended\_upgrades affects

* Package/configuration for unattended\_upgrades

### Beginning with unattended\_upgrades

All you need to do is include the apt module, `include apt`, and this module,
`include unattended_upgrades` for it to work.

This module relies on the [apt](https://forge.puppetlabs.com/puppetlabs/apt)
module and will not work without it.

## Usage

Using unattended\_upgrades simply consists of including the module and if needed
altering some of the default settings.

## Reference

### Classes

* `unattended_upgrades`: Main class, installs the necessary packages and writes
  the configuration.

### Parameters

#### unattended\_upgrades

* `age` (`{}`): A hash of settings with two possible keys:
  * `min` (`2`): Minimum age of a cache package file. File younger than `min` will
    not be deleted.
  * `max` (`0`): Maximum allowed age of a cache package file. File older than `max`
    will be deleted.

  Any of these keys can be specified and will be merged into the defaults:

  ```puppet
  class { 'unattended_upgrades':
    age => { 'max' => 10 },
  }
  ```

* `auto` (`{}`): A hash of settings with these possible keys:
  * `clean`(`0`): Remove packages that can no longer be downloaded from cache every X days (`0` = disabled).
    Also supports 'always' as value to execute this operation every time the script is executed.
  * `fix_interrupted_dpkg`(`true`): Try to fix package installation state.
  * `reboot`(`false`): Reboot system after package update installation.
  * `reboot_withusers`(`true`): If automatic reboot is enabled and needed, reboot even if there are users currently logged in.
  * `reboot_time`(`now`): If automatic reboot is enabled and needed, reboot at the
    specific time (instead of immediately). Expects a string in the format "HH:MM", using the 24 hour clock with leading zeros. Examples:  "16:37" for 37 minutes past 4PM, or "02:03" for 3 minutes past 2AM.
  * `remove`(`true`): Remove unneeded dependencies after update installation.

  Any of these keys can be specified and will be merged into the defaults:

  ```puppet
  class { 'unattended_upgrades':
    auto => { 'reboot' => true },
  }
  ```

* `backup` (`{}`): A hash with two possible keys:
  * `archive_interval` (`0`): Backup after n-days if archive contents changed.
  * `level` (`3`): Backup level.

  Any of these keys can be specified and will be merged into the defaults:

  ```puppet
  class { 'unattended_upgrades':
    backup => { 'level' => 5 },
  }
  ```

* `blacklist`(`[]`): A list of packages to **not** automatically upgrade.
* `dl_limit`(`undef`): Use a bandwidth limit for downloading, specified in kb/sec.
* `enable` (`1`): Enable the automatic installation of updates.
* `install_on_shutdown` (`false`): Install updates on shutdown instead of in the
  background.
* `mail`: A hash to configure email behaviour with the following possible keys:
  * `report` (`undef`): Possible values are "always", "only-on-error" or "on-change". Defaults to "on-change". Note that "never" is achieved by not setting any `to` address.
  * `only_on_error` (`true`): Only send mail when something went wrong. Deprecated in unattended-upgrades 1.13 and newer in favor of `report`.
  * `to` (`undef`): Email address to send email too

  If the default for `to` is kept you will not receive any mail at all. You'll
  likely want to set this parameter.

  Any of these keys can be specified and will be merged into the defaults:

  ```puppet
  class { 'unattended_upgrades':
    mail => { 'to' => 'admin@domain.tld', },
  }
  ```

* `minimal_steps` (`true`): Split the upgrade process into sections to allow
  shutdown during upgrade.
* `origins`: The repositories from which to automatically upgrade included packages.

  The default origins can be replaced with contents of an array:
  ```puppet
  class { 'unattended_upgrades':
    origins => [
      'origin=${distro_id},suite=${distro_codename}',
      'origin=${distro_id},suite=${distro_codename}-security',
      'origin=${distro_id},suite=${distro_codename}-backports',
      'origin=${distro_id},suite=${distro_codename}-updates',
    ],
  }
  ```

* `extra_origins`: Additional repositories from which upgrades should be included. Can be used, if the default `origins` should be kept.
* `package_ensure` (`installed`): The ensure state for the 'unattended-upgrades'
  package.
* `random_sleep` (`undef`): Maximum amount of time (in seconds) that the apt cron
  job can sleep before the execution. The exact amount of time will be random but
  up to the value specified. The purpose is to avoid that servers/mirrors get
  hammered at exactly the same time when a lot of machines are switched on, e.g.
  9:00 in the morning. Note: If this is left unset, the default value in the apt
  cron job applies, which is 1800 seconds.
* `size` (`0`): Maximum size of the cache in MB.
* `update` (`1`): Do "apt-get update" automatically every n-days.
  Also supports 'always' as value to execute this operation every time the script is executed.
* `upgrade` (`1`): Run the "unattended-upgrade" security upgrade script every n-days.
  Also supports 'always' as value to execute this operation every time the script is executed.
* `days` (`[]`): Set the days of the week that updates should be applied. The days can be specified as localized abbreviated or full names. Or as integers where "0" is Sunday, "1" is Monday etc.
* `upgradeable_packages` (`{}`): A hash with two possible keys:
  * `download_only` (`0`): Do "apt-get upgrade --download-only" every n-days.
    Also supports 'always' as value to execute this operation every time the script is executed.
  * `debdelta` (`1`): Use debdelta-upgrade to download updates if available.

  Any of these keys can be specified and will be merged into the defaults:

  ```puppet
  class { 'unattended_upgrades':
    upgradeable_packages => { 'debdelta' => 1, },
  }
  ```

* `verbose` (`0`): Send report mail to root.
* `remove_new_unused_deps` (`undef`): Automatic removal of newly unused dependencies after the upgrade.
* `remove_unused_kernel` (`undef`): Remove unused automatically installed kernel-related packages.
* `syslog_enable` (`undef`): Enable logging to syslog. Default is False.
* `syslog_facility` (`undef`): Specify syslog facility. Default is `daemon`.
* `only_on_ac_power` (`undef`): Download and install upgrades only on AC power. Default is `true`.
* `allow_downgrade` (`undef`): Allow package downgrade if Pin-Priority exceeds 1000. Default is `false`.

## Limitations

This module should work across all versions of Debian, Ubuntu, and Linux Mint.

## License

The original code for this module comes from Evolving Web and was licensed under
the MIT license. Code added since the fork of that module into puppetlabs-apt is
covered under the Apache License version 2 as is any code added since it was split
off into this separate unattended\_upgrades module.

The LICENSE contains both licenses.
