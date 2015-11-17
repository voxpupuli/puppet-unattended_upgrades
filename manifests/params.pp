#
class unattended_upgrades::params {

  if $::osfamily != 'Debian' {
    fail('This module only works on Debian or derivatives like Ubuntu')
  }

  $default_auto                 = { 'fix_interrupted_dpkg' => true, 'remove' => true, 'reboot' => false, 'clean' => 0, }
  $default_mail                 = { 'only_on_error'        => true, }
  $default_backup               = { 'archive_interval'     => 0, 'level'     => 3, }
  $default_age                  = { 'min'                  => 2, 'max'       => 0, }
  $default_upgradeable_packages = { 'download_only'        => 0, 'debdelta'  => 1, }

  # prior to puppet 3.5.0, defined couldn't test if a variable was defined
  # strict variables wasn't added until 3.5.0, so this should be fine.
  if ! $::settings::strict_variables {
    $xfacts = {
      'lsbdistid'           => $::lsbdistid,
      'lsbdistcodename'     => $::lsbdistcodename,
    }
  } else {
    # Strict variables facts lookup compatibility
    $xfacts = {
      'lsbdistid' => defined('$lsbdistid') ? {
        true    => $::lsbdistid,
        default => undef,
      },
      'lsbdistcodename' => defined('$lsbdistcodename') ? {
        true    => $::lsbdistcodename,
        default => undef,
      },
    }
  }

  case $xfacts['lsbdistid'] {
    'debian', 'raspbian': {
      case $xfacts['lsbdistcodename'] {
        'squeeze': {
          $legacy_origin       = true
          $origins             = ['${distro_id} oldoldstable', #lint:ignore:single_quote_string_with_variables
                                  '${distro_id} ${distro_codename}-security', #lint:ignore:single_quote_string_with_variables
                                  '${distro_id} ${distro_codename}-lts',] #lint:ignore:single_quote_string_with_variables
        }
        'wheezy': {
          $legacy_origin      = false
          $origins            = ['origin=Debian,archive=stable,label=Debian-Security',
                                 'origin=Debian,archive=oldstable,label=Debian-Security',]
        }
        default: {
          $legacy_origin      = false
          $origins            = ['origin=Debian,codename=${distro_codename},label=Debian-Security',] #lint:ignore:single_quote_string_with_variables
        }
      }
    }
    'ubuntu': {
      # TODO do we really want to pull in ${distro_codename}-updates by default?
      case $distcodename {
        'precise': {
          $legacy_origin      = true
          $origins            = [
                                 '${distro_id}:${distro_codename}-security', #lint:ignore:single_quote_string_with_variables
                                 #'${distro_id}:${distro_codename}-updates', #lint:ignore:single_quote_string_with_variables
                                ]

        }
        'trusty', 'utopic', 'vivid', 'wily': {
          $legacy_origin      = true
          $origins            = [
                                 '${distro_id}:${distro_codename}-security', #lint:ignore:single_quote_string_with_variables
                                 #'${distro_id}:${distro_codename}-updates', #lint:ignore:single_quote_string_with_variables
                                ]
        }
        default: {
          $legacy_origin      = true
          $origins            = [
                                 '${distro_id}:${distro_codename}-security', #lint:ignore:single_quote_string_with_variables
                                 #'${distro_id}:${distro_codename}-updates', #lint:ignore:single_quote_string_with_variables
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
