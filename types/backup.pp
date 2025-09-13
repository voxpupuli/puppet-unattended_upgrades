# @summary Backup options.
# @param archive_interval Interval in days to backup the package archives.
# @param level Backup level.
type Unattended_upgrades::Backup = Struct[
  {
    Optional['archive_interval'] => Integer[0],
    Optional['level']            => Integer[0],
  }
]
