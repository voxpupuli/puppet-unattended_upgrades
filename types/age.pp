# @summary Specifies the minimum and maximum age of packages to upgrade.
# @param min Minimum age of a package in days.
# @param max Maximum age of a package in days.
type Unattended_upgrades::Age = Struct[
  {
    Optional['min'] => Integer[0],
    Optional['max'] => Integer[0],
  }
]
