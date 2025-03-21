class unattended_upgrades (
  Unattended_upgrades::Age                  $age                    = {},
  Unattended_upgrades::Auto                 $auto                   = {},
  Unattended_upgrades::Backup               $backup                 = {},
  Array[String[1]]                          $blacklist              = [],
  Array[String[1]]                          $whitelist              = [],
  Optional[Integer[0]]                      $dl_limit               = undef,
  Integer[0, 1]                             $enable                 = 1,
  Boolean                                   $install_on_shutdown    = false,
  Unattended_upgrades::Mail                 $mail                   = {},
  Boolean                                   $minimal_steps          = true,
  Array[Unattended_upgrades::Origin]        $origins                = $unattended_upgrades::params::origins,
  String[1]                                 $package_ensure         = installed,
  Array[Unattended_upgrades::Origin]        $extra_origins          = [],
  Optional[Integer[0]]                      $random_sleep           = undef,
  Optional[String]                          $sender                 = undef,
  Integer[0]                                $size                   = 0,
  Variant[Integer[0], Enum['always']]       $update                 = 1,
  Variant[Integer[0], Enum['always']]       $upgrade                = 1,
  Unattended_upgrades::Upgradeable_packages $upgradeable_packages   = {},
  Integer[0]                                $verbose                = 0,
  Boolean                                   $notify_update          = false,
  Array[String[1]]                          $days                   = [],
  Optional[Boolean]                         $remove_unused_kernel   = undef,
  Optional[Boolean]                         $remove_new_unused_deps = undef,
  Optional[Boolean]                         $syslog_enable          = undef,
  Optional[String]                          $syslog_facility        = undef,
  Optional[Boolean]                         $only_on_ac_power       = undef,
  Optional[Boolean]                         $skip_updates_on_metered_connection = undef,
  Optional[Boolean]                         $whitelist_strict       = undef,
  Optional[Boolean]                         $allow_downgrade        = undef,
  Array[String[1]]                          $dpkg_options           = [],
) inherits unattended_upgrades::params {
  # apt::conf settings require the apt class to work
  include apt

  $_age = $unattended_upgrades::default_age + $age
  assert_type(Unattended_upgrades::Age, $_age)

  $_auto = $unattended_upgrades::default_auto + $auto
  assert_type(Unattended_upgrades::Auto, $_auto)

  $_backup = $unattended_upgrades::default_backup + $backup
  assert_type(Unattended_upgrades::Backup, $_backup)

  $_mail = $unattended_upgrades::default_mail + $mail
  assert_type(Unattended_upgrades::Mail, $_mail)

  $_upgradeable_packages = $unattended_upgrades::default_upgradeable_packages + $upgradeable_packages
  assert_type(Unattended_upgrades::Upgradeable_packages, $_upgradeable_packages)

  package { 'unattended-upgrades':
    ensure => $package_ensure,
  }

   $ensure_status = $enable ? { 0 => 'absent',  default  => 'present' }
  apt::conf { 'unattended-upgrades':
    ensure        => $ensure_status,
    priority      => 50,
    content       => template("${module_name}/unattended-upgrades.erb"),
    require       => Package['unattended-upgrades'],
    notify_update => $notify_update,
  }

  apt::conf { 'periodic':
    ensure        => $ensure_status,
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
