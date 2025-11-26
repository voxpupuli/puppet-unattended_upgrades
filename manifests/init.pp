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
#   Maximum random sleep in seconds. This parameter is deprecated and will be removed in a future release.
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
# @param service_ensure
#   Specifies whether the service should be running.
# @param service_enable
#   Specifies whether the service should be enabled at boot.
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
  Array[Unattended_upgrades::Origin]        $origins                = [
    'origin=Debian,codename=${distro_codename},label=Debian', #lint:ignore:single_quote_string_with_variables
    'origin=Debian,codename=${distro_codename}-security,label=Debian-Security', #lint:ignore:single_quote_string_with_variables
  ],
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
  Enum['running', 'stopped']                $service_ensure         = 'running',
  Boolean                                   $service_enable         = true,
) {
  # apt::conf settings require the apt class to work
  include apt

  $_age = {
    'min' => 2,
    'max' => 0,
  } + $age
  assert_type(Unattended_upgrades::Age, $_age)

  $_auto = {
    'fix_interrupted_dpkg' => true,
    'remove' => true,
    'reboot' => false,
    'reboot_withusers' => true,
    'clean' => 0,
    'reboot_time' => 'now',
  } + $auto
  assert_type(Unattended_upgrades::Auto, $_auto)

  $_backup = {
    'archive_interval' => 0,
    'level' => 3,
  } + $backup
  assert_type(Unattended_upgrades::Backup, $_backup)

  $_mail = {
    'only_on_error' => true,
  } + $mail
  assert_type(Unattended_upgrades::Mail, $_mail)

  $_upgradeable_packages = {
    'download_only' => 0,
    'debdelta' => 1,
  } + $upgradeable_packages
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

  # Emit a warning if the deprecated parameter `random_sleep` is used
  if $random_sleep != undef {
    warning('The parameter `random_sleep` is deprecated and will be removed in a future release.')
  }

  service { 'unattended-upgrades':
    ensure  => $service_ensure,
    enable  => $service_enable,
    require => Package['unattended-upgrades'],
  }
}
