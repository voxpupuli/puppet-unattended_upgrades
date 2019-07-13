#
class unattended_upgrades::params {

  if $::osfamily != 'Debian' {
    fail('This module only works on Debian or derivatives like Ubuntu')
  }

  # prior to puppet 3.5.0, defined couldn't test if a variable was defined
  # strict variables wasn't added until 3.5.0, so this should be fine.
  if ! $::settings::strict_variables {
    $xfacts = {
      'lsbdistid'           => $::lsbdistid,
      'lsbdistcodename'     => $::lsbdistcodename,
      'lsbmajdistrelease'   => $::lsbmajdistrelease,
      'lsbdistrelease'      => $::lsbdistrelease,
    }
  } else {
    # Strict variables facts lookup compatibility
    $xfacts = {
      'lsbdistid' => defined('$lsbdistid') ? {
        true    => $::lsbdistid,
        default => $facts['os']['name'],
      },
      'lsbdistcodename' => defined('$lsbdistcodename') ? {
        true    => $::lsbdistcodename,
        default => $facts['os']['lsb']['distcodename'],
      },
      'lsbmajdistrelease' => defined('$lsbmajdistrelease') ? {
        true    => $::lsbmajdistrelease,
        default => $facts['os']['release']['major'],
      },
      'lsbdistrelease' => defined('$lsbdistrelease') ? {
        true    => $::lsbdistrelease,
        default => $facts['os']['release']['full'],
      },
    }
  }

  case $xfacts['lsbdistid'] {
    'Debian', 'Raspbian': {
      $package_version_greater_1_0 = '10'
      case $xfacts['lsbdistcodename'] {
        'squeeze': {
          $legacy_origin       = true
          $origins             =  ['${distro_id} ${distro_codename}-security', #lint:ignore:single_quote_string_with_variables
                                  '${distro_id} ${distro_codename}-lts',] #lint:ignore:single_quote_string_with_variables
        }
        'wheezy': {
          $legacy_origin      = false
          $origins            = [
            'origin=Debian,archive=oldoldstable,label=Debian-Security',
          ]
        }
        'jessie': {
          $legacy_origin      = false
          $origins            = [
            'origin=Debian,archive=oldstable,label=Debian-Security',
          ]
        }
        'stretch': {
          $legacy_origin      = false
          $origins            = [
            'origin=Debian,archive=stable,label=Debian-Security',
          ]
        }
        default: {
          $legacy_origin      = false
          $origins            = ['origin=Debian,codename=${distro_codename},label=Debian-Security',] #lint:ignore:single_quote_string_with_variables
        }
      }
    }
    'Ubuntu', 'Neon': {
      $package_version_greater_1_0 = '18.04'
      case $xfacts['lsbdistcodename'] {
        'precise': {
          $legacy_origin      = true
          $origins            = [
            '${distro_id}:${distro_codename}-security', #lint:ignore:single_quote_string_with_variables
          ]

        }
        'trusty', 'wily': {
          $legacy_origin      = true
          $origins            = [
            '${distro_id}:${distro_codename}-security', #lint:ignore:single_quote_string_with_variables
          ]
        }
        'xenial', 'yakkety', 'zesty', 'artful', 'bionic': {
          $legacy_origin      = true
          $origins            = [
            '${distro_id}:${distro_codename}', #lint:ignore:single_quote_string_with_variables
            '${distro_id}:${distro_codename}-security', #lint:ignore:single_quote_string_with_variables
          ]
        }
        default: {
          warning("Ubuntu ${xfacts['lsbdistrelease']} \"${xfacts['lsbdistcodename']}\" has reached End of Life - please upgrade!")
          $legacy_origin      = true
          $origins            = [
            '${distro_id}:${distro_codename}-security', #lint:ignore:single_quote_string_with_variables
          ]
        }
      }
    }
    'LinuxMint': {
      $package_version_greater_1_0 = '19'
      case $xfacts['lsbmajdistrelease'] {
        # Linux Mint 13 is based on Ubuntu 12.04
        '13': {
          $legacy_origin      = true
          $origins            = [
            'Ubuntu:precise-security',
          ]
        }
        # Linux Mint 17* is based on Ubuntu 14.04.
        '17': {
          $legacy_origin      = true
          $origins            = [
            'Ubuntu:trusty-security',
          ]
        }
        # Linux Mint 18* is based on Ubuntu 16.04
        '18': {
          $legacy_origin      = true
          $origins            = [
            'Ubuntu:xenial-security',
          ]
        }
        default: {
          $legacy_origin      = true
          $origins            = [
            '${distro_id}:${distro_codename}-security', #lint:ignore:single_quote_string_with_variables
          ]
        }
      }
    }
    default: {
      $legacy_origin = undef
      $origins       = undef
      # Settings which are not supported by installed version do not prevent unattended-upgrades from running
      $package_version_greater_1_0 = '0'
    }
  }

  if $xfacts['lsbmajdistrelease'] != undef and versioncmp($xfacts['lsbmajdistrelease'], $package_version_greater_1_0) >=0 {
    $remove_new = true
    $remove_unused_kernel = true
  } else {
    $remove_new = false
    $remove_unused_kernel = false
  }

  $default_auto                 = { 'fix_interrupted_dpkg' => true,
                                    'remove'               => true,
                                    'remove-new'           => $remove_new,
                                    'remove-unused-kernel' => $remove_unused_kernel,
                                    'reboot'               => false,
                                    'clean'                => 0,
                                    'reboot_time'          => 'now', }
  $default_mail                 = { 'only_on_error'        => true, }
  $default_backup               = { 'archive_interval'     => 0, 'level'     => 3, }
  $default_age                  = { 'min'                  => 2, 'max'       => 0, }
  $default_upgradeable_packages = { 'download_only'        => 0, 'debdelta'  => 1, }
  $default_options              = { 'force_confdef'        => true,
                                    'force_confold'        => true,
                                    'force_confnew'        => false,
                                    'force_confmiss'       => false, }
}
