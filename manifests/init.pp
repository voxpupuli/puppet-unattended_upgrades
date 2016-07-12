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
  $notify_update        = false,
  $options              = {},
) inherits ::unattended_upgrades::params {

  validate_hash($age)
  $_age = merge($::unattended_upgrades::default_age, $age)
  validate_integer($_age['min'], undef, 0)
  validate_integer($_age['max'], undef, 0)

  validate_hash($auto)
  $_auto = merge($::unattended_upgrades::default_auto, $auto)
  validate_integer($_auto['clean'], undef, 0)
  validate_bool($_auto['fix_interrupted_dpkg'])
  validate_bool($_auto['reboot'])
  validate_string($_auto['reboot_time'])
  validate_bool($_auto['remove'])

  validate_hash($backup)
  $_backup = merge($::unattended_upgrades::default_backup, $backup)
  validate_integer($_backup['archive_interval'], undef, 0)
  validate_integer($_backup['level'], undef, 0)

  validate_array($blacklist)

  if $dl_limit != undef {
    validate_integer($dl_limit, undef, 0)
  }

  validate_integer($enable, 1, 0)

  validate_bool($install_on_shutdown)

  validate_bool($legacy_origin)

  validate_hash($mail)
  $_mail = merge($::unattended_upgrades::default_mail, $mail)
  validate_bool($_mail['only_on_error'])

  validate_bool($minimal_steps)

  validate_array($origins)

  validate_string($package_ensure)

  if $random_sleep != undef {
    validate_integer($random_sleep, undef, 0)
  }

  validate_integer($size, undef, 0)

  validate_integer($update, undef, 0)

  validate_integer($upgrade, undef, 0)

  validate_hash($upgradeable_packages)
  $_upgradeable_packages = merge($::unattended_upgrades::default_upgradeable_packages, $upgradeable_packages)
  validate_integer($_upgradeable_packages['download_only'], undef, 0)
  validate_integer($_upgradeable_packages['debdelta'], undef, 0)

  validate_integer($verbose, undef, 0)

  validate_bool($notify_update)

  validate_hash($options)
  $_options = merge($unattended_upgrades::default_options, $options)
  validate_bool($_options['force_confdef'])
  validate_bool($_options['force_confold'])
  validate_bool($_options['force_confnew'])
  validate_bool($_options['force_confmiss'])

  package { 'unattended-upgrades':
    ensure => $package_ensure,
  }

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
  apt::conf { 'options':
    priority      => 10,
    content       => template("${module_name}/options.erb"),
    require       => Package['unattended-upgrades'],
    notify_update => $notify_update,
  }

}
