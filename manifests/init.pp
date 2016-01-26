class unattended_upgrades (
  $age                  = {},
  $auto                 = {},
  $backup               = {},
  $blacklist            = [],
  $dl_limit             = undef,
  $enable               = 1,
  $install_on_shutdown  = false,
  $legacy_origin        = $::unattended_upgrades::params::legacy_origin,
  $mail                 = {},
  $minimal_steps        = true,
  $origins              = $::unattended_upgrades::params::origins,
  $package_ensure       = installed,
  $random_sleep         = undef,
  $size                 = 0,
  $update               = 1,
  $upgrade              = 1,
  $upgradeable_packages = {},
  $verbose              = 0,
  $notify_update        = undef,
  $manage_package       = true,
  $manage_aptconf       = true,
) inherits ::unattended_upgrades::params {

  if $legacy_origin == undef or $origins == undef {
    fail('Please explicitly specify unattended_upgrades::legacy_origin and unattended_upgrades::origins.')
  }

  validate_bool(
    $install_on_shutdown,
    $legacy_origin,
    $minimal_steps,
    $manage_package,
    $manage_aptconf,
  )
  validate_array($blacklist)
  validate_array($origins)
  validate_hash($auto)
  $_auto = merge($::unattended_upgrades::default_auto, $auto)
  validate_hash($mail)
  if $mail['only_on_error'] {
    validate_bool($mail['only_on_error'])
  }
  $_mail = merge($::unattended_upgrades::default_mail, $mail)
  validate_hash($backup)
  $_backup = merge($::unattended_upgrades::default_backup, $backup)
  validate_hash($age)
  $_age = merge($::unattended_upgrades::default_age, $age)
  validate_integer($size)
  validate_hash($upgradeable_packages)
  $_upgradeable_packages = merge($::unattended_upgrades::default_upgradeable_packages, $upgradeable_packages)

  if $manage_package {
    package { 'unattended-upgrades':
      ensure => $package_ensure,
    }
  }

  if $manage_aptconf {
    apt::conf { 'unattended-upgrades':
      priority      => 50,
      content       => template("${module_name}/unattended-upgrades.erb"),
      require       => Package['unattended-upgrades'],
      notify_update => $notify_update,
    }

    apt::conf { 'periodic':
      priority      => 10,
      content       => template("${module_name}/periodic.erb"),
      require       => Package['unattended-upgrades'],
      notify_update => $notify_update,
    }

    apt::conf { 'auto-upgrades':
      ensure        => absent,
      priority      => 20,
      require       => Package['unattended-upgrades'],
      notify_update => $notify_update,
    }
  }

}
