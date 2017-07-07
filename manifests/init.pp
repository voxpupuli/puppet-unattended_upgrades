class unattended_upgrades (
  Unattended_upgrades::Age                  $age                  = {},
  Unattended_upgrades::Auto                 $auto                 = {},
  Unattended_upgrades::Backup               $backup               = {},
  Array                                     $blacklist            = [],
  Optional[Integer[0]]                      $dl_limit             = undef,
  Integer[0, 1]                             $enable               = 1,
  Boolean                                   $install_on_shutdown  = false,
  Boolean                                   $legacy_origin        = $::unattended_upgrades::params::legacy_origin,
  Unattended_upgrades::Mail                 $mail                 = {},
  Boolean                                   $minimal_steps        = true,
  Array                                     $origins              = $::unattended_upgrades::params::origins,
  String                                    $package_ensure       = installed,
  Optional[Integer[0]]                      $random_sleep         = undef,
  Integer[0]                                $size                 = 0,
  Integer[0]                                $update               = 1,
  Integer[0]                                $upgrade              = 1,
  Unattended_upgrades::Upgradeable_packages $upgradeable_packages = {},
  Integer[0]                                $verbose              = 0,
  Boolean                                   $notify_update        = false,
  Unattended_upgrades::Options              $options              = {},
) inherits ::unattended_upgrades::params {

  # apt::conf settings require the apt class to work
  contain ::apt

  $_age = merge($::unattended_upgrades::default_age, $age)
  assert_type(Unattended_upgrades::Age, $_age)

  $_auto = merge($::unattended_upgrades::default_auto, $auto)
  assert_type(Unattended_upgrades::Auto, $_auto)

  $_backup = merge($::unattended_upgrades::default_backup, $backup)
  assert_type(Unattended_upgrades::Backup, $_backup)

  $_mail = merge($::unattended_upgrades::default_mail, $mail)
  assert_type(Unattended_upgrades::Mail, $_mail)

  $_upgradeable_packages = merge($::unattended_upgrades::default_upgradeable_packages, $upgradeable_packages)
  assert_type(Unattended_upgrades::Upgradeable_packages, $_upgradeable_packages)

  $_options = merge($unattended_upgrades::default_options, $options)
  assert_type(Unattended_upgrades::Options, $_options)

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
