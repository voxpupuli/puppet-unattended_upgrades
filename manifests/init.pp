# @summary Installs and configures unattended-upgrades.
#
# This class installs and configures the unattended-upgrades package.
#
# @param age
#   See `Unattended_upgrades::Age` for details.
# @param auto
#   See `Unattended_upgrades::Auto` for details.
# @param backup
#   See `Unattended_upgrades::Backup` for details.
# @param blacklist
#   Array of packages to blacklist from automatic upgrades.
# @param whitelist
#   Array of packages to whitelist for automatic upgrades.
# @param dl_limit
#   Limit the download speed in KB/s.
# @param enable
#   Enable unattended-upgrades.
# @param install_on_shutdown
#   Install upgrades on shutdown.
# @param mail
#   See `Unattended_upgrades::Mail` for details.
# @param minimal_steps
#   Split the upgrade process into minimal steps.
# @param origins
#   Array of origins to allow automatic upgrades from.
# @param package_ensure
#   Ensure for the unattended-upgrades package.
# @param extra_origins
#   Array of extra origins to allow automatic upgrades from.
# @param random_sleep
#   Maximum random sleep in seconds.
# @param sender
#   Email sender address.
# @param size
#   Maximum size of the download in MB.
# @param update
#   Run `apt-get update` automatically. Accepts an integer (number of days),
#   the string 'always', or a time interval with suffixes ('s' for seconds,
#   'm' for minutes, 'h' for hours).
# @param upgrade
#   Run `apt-get upgrade` automatically. Accepts an integer (number of days),
#   the string 'always', or a time interval with suffixes ('s' for seconds,
#   'm' for minutes, 'h' for hours).
# @param upgradeable_packages
#   See `Unattended_upgrades::Upgradeable_packages` for details.
# @param verbose
#   Enable verbose logging.
# @param notify_update
#   Notify on package updates.
# @param days
#   Days of the week to run unattended-upgrades.
# @param remove_unused_kernel
#   Remove unused kernel packages.
# @param remove_new_unused_deps
#   Remove new unused dependencies.
# @param syslog_enable
#   Enable syslog logging.
# @param syslog_facility
#   Syslog facility to use.
# @param only_on_ac_power
#   Download and install upgrades only when on AC power.
# @param skip_updates_on_metered_connection
#   Skip updates on metered connections.
# @param whitelist_strict
#   Whether to apply the whitelist strictly.
# @param allow_downgrade
#   Allow downgrades.
# @param dpkg_options
#   Array of dpkg options.
#
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
  Variant[Integer[0], Enum['always'], Pattern[/^\d+[smh]$/]]       $update                 = 1,
  Variant[Integer[0], Enum['always'], Pattern[/^\d+[smh]$/]]       $upgrade                = 1,
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
