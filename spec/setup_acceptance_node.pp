# Needed for os.distro.codebase fact on ubuntu 16/18 on puppet 6/7
if $facts['os']['name'] == 'Ubuntu' and versioncmp($facts['puppetversion'], '8.0.0') < 0 {
  package{'lsb-release':
    ensure => present,
  }
}
