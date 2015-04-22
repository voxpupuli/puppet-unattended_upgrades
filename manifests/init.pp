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
  $size                 = {},
  $update               = 1,
  $upgrade              = 1,
  $upgradeable_packages = {},
  $verbose              = 0,
) inherits ::unattended_upgrades::params {

  include ::apt

  validate_bool(
    $install_on_shutdown,
    $legacy_origin,
    $minimal_steps,
  )
  validate_array($blacklist)
  validate_array($origins)
  validate_hash($auto)
  $_auto = merge($auto, $::unattended_upgrades::default_auto)
  validate_hash($mail)
  if $mail['only_on_error'] {
    validate_bool($mail['only_on_error'])
  }
  $_mail = merge($mail, $::unattended_upgrades::default_mail)
  validate_hash($backup)
  $_backup = merge($backup, $::unattended_upgrades::default_backup)
  validate_hash($age)
  $_age = merge($age, $::unattended_upgrades::default_age)
  validate_hash($size)
  $_size = merge($size, $::unattended_upgrades::default_size)
  validate_hash($upgradeable_packages)
  $_upgradeable_packages = merge($upgradeable_packages, $::unattended_upgrades::upgradeable_packages)

  package { 'unattended-upgrades':
    ensure => $package_ensure,
  }

  apt::conf { 'unattended-upgrades':
    priority => 50,
    content  => template("${module_name}/unattended-upgrades.erb"),
    require  => Package['unattended-upgrades'],
  }

  apt::conf { 'periodic':
    priority => 10,
    content  => template("${module_name}/periodic.erb"),
    require  => Package['unattended-upgrades'],
  }

  apt::conf { 'auto-upgrades':
    ensure   => absent,
    priority => 20,
    require  => Package['unattended-upgrades'],
  }

}
