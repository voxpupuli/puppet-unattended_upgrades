#
class unattended_upgrades::params {

  if $facts['os']['family'] != 'Debian' {
    fail('This module only works on Debian or derivatives like Ubuntu')
  }

  $default_auto                 = { 'fix_interrupted_dpkg' => true, 'remove' => true, 'reboot' => false, 'clean' => 0, 'reboot_time' => 'now', }
  $default_mail                 = { 'only_on_error'        => true, }
  $default_backup               = { 'archive_interval'     => 0, 'level'     => 3, }
  $default_age                  = { 'min'                  => 2, 'max'       => 0, }
  $default_upgradeable_packages = { 'download_only'        => 0, 'debdelta'  => 1, }
  $default_options              = { 'force_confdef'        => true,
                                    'force_confold'        => true,
                                    'force_confnew'        => false,
                                    'force_confmiss'       => false, }
  # prior to puppet 3.5.0, defined couldn't test if a variable was defined
  # strict variables wasn't added until 3.5.0, so this should be fine.
  if ! $::settings::strict_variables {
    $xfacts = {
      'lsbdistid'           => $facts['os']['distro']['id'],
      'lsbdistcodename'     => $facts['os']['distro']['codename'],
      'lsbmajdistrelease'   => $facts['os']['distro']['release']['major'],
      'lsbdistrelease'      => $facts['os']['distro']['release']['full'],
    }
  } else {
    # Strict variables facts lookup compatibility
    $xfacts = {
      'lsbdistid' => defined('$lsbdistid') ? {
        true    => $facts['os']['distro']['id'],
        default => undef,
      },
      'lsbdistcodename' => defined('$lsbdistcodename') ? {
        true    => $facts['os']['distro']['codename'],
        default => undef,
      },
      'lsbmajdistrelease' => defined('$lsbmajdistrelease') ? {
        true    => $facts['os']['distro']['release']['major'],
        default => undef,
      },
      'lsbdistrelease' => defined('$lsbdistrelease') ? {
        true    => $facts['os']['distro']['release']['full'],
        default => undef,
      },
    }
  }

  case $xfacts['lsbdistid'] {
    'debian', 'raspbian': {
      case $xfacts['lsbdistcodename'] {
        'squeeze', 'wheezy': {
          $legacy_origin      = true
          $origins            = [
            '${distro_id} ${distro_codename}-security', #lint:ignore:single_quote_string_with_variables
            '${distro_id} ${distro_codename}-lts', #lint:ignore:single_quote_string_with_variables
          ]
        }
        'buster': {
          $legacy_origin      = false
          $origins            = [
            'origin=Debian,codename=${distro_codename},label=Debian', #lint:ignore:single_quote_string_with_variables
            'origin=Debian,codename=${distro_codename},label=Debian-Security', #lint:ignore:single_quote_string_with_variables
          ]
        }
        default: {
          $legacy_origin      = false
          $origins            = [
            'origin=Debian,codename=${distro_codename},label=Debian-Security', #lint:ignore:single_quote_string_with_variables
          ]
        }
      }
    }
    'ubuntu', 'neon': {
      # Ubuntu: https://ubuntu.com/about/release-cycle and https://wiki.ubuntu.com/Releases
      case $xfacts['lsbdistcodename'] {
        # Ubuntu 12.04 LTS in ESM
        'precise': {
          $legacy_origin      = true
          $origins            = [
            '${distro_id}:${distro_codename}-security', #lint:ignore:single_quote_string_with_variables
          ]

        }
        # Ubuntu 14.04 LTS in ESM
        'trusty': {
          $legacy_origin      = true
          $origins            = [
            '${distro_id}:${distro_codename}-security', #lint:ignore:single_quote_string_with_variables
          ]
        }
        # Ubuntu 16.04 LTS, 18.04 LTS, 20.04 LTS in Standard Support
        'xenial', 'bionic', 'focal': {
          $legacy_origin      = true
          $origins            = [
            '${distro_id}:${distro_codename}', #lint:ignore:single_quote_string_with_variables
            '${distro_id}:${distro_codename}-security', #lint:ignore:single_quote_string_with_variables
          ]
        }
        # Ubuntu Interim Releases
        'eoan': {
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
    }
  }
}
