#
class unattended_upgrades::params {
  if $facts['os']['family'] != 'Debian' {
    fail('This module only works on Debian or derivatives like Ubuntu')
  }

  $default_auto                 = { 'fix_interrupted_dpkg' => true, 'remove' => true, 'reboot' => false, 'reboot_withusers' => true, 'clean' => 0, 'reboot_time' => 'now', }
  $default_mail                 = { 'only_on_error'        => true, }
  $default_backup               = { 'archive_interval'     => 0, 'level'     => 3, }
  $default_age                  = { 'min'                  => 2, 'max'       => 0, }
  $default_upgradeable_packages = { 'download_only'        => 0, 'debdelta'  => 1, }

  case downcase($facts['os']['name']) {
    'debian', 'raspbian': {
      case fact('os.distro.codename') {
        'bullseye': {
          $origins            = [
            'origin=Debian,codename=${distro_codename},label=Debian', #lint:ignore:single_quote_string_with_variables
            'origin=Debian,codename=${distro_codename}-security,label=Debian-Security', #lint:ignore:single_quote_string_with_variables
          ]
        }
        default: {
          $origins            = [
            'origin=Debian,codename=${distro_codename},label=Debian', #lint:ignore:single_quote_string_with_variables
            'origin=Debian,codename=${distro_codename},label=Debian-Security', #lint:ignore:single_quote_string_with_variables
          ]
        }
      }
    }
    'ubuntu', 'neon': {
      # Ubuntu: https://ubuntu.com/about/release-cycle and https://wiki.ubuntu.com/Releases
      # Ubuntu 18.04 and up do allow the use of Origins-Pattern; 16.04 is out of support for Vox Pupuli.
      $origins            = [
        'origin=${distro_id},suite=${distro_codename}', #lint:ignore:single_quote_string_with_variables
        'origin=${distro_id},suite=${distro_codename}-security', #lint:ignore:single_quote_string_with_variables
        'origin=${distro_id}ESMApps,suite=${distro_codename}-apps-security', #lint:ignore:single_quote_string_with_variables
        'origin=${distro_id}ESM,suite=${distro_codename}-infra-security', #lint:ignore:single_quote_string_with_variables
      ]
    }
    'LinuxMint': {
      $origins = ['origin=${distro_id},suite=${distro_codename}-security',] #lint:ignore:single_quote_string_with_variables
    }
    default: {
      $origins       = undef
    }
  }
}
