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
  $default_options              = {
    'force_confdef'        => true,
    'force_confold'        => true,
    'force_confnew'        => false,
    'force_confmiss'       => false,
  }

  case fact('lsbdistid') {
    'debian', 'raspbian': {
      case fact('lsbdistcodename') {
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
      $legacy_origin      = true
      $origins            = [
        '${distro_id}:${distro_codename}', #lint:ignore:single_quote_string_with_variables
        '${distro_id}:${distro_codename}-security', #lint:ignore:single_quote_string_with_variables
      ]
    }
    'LinuxMint': {
      case fact('lsbmajdistrelease') {
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
