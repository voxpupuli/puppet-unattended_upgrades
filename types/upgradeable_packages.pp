type Unattended_upgrades::Upgradeable_packages = Struct[
  {
    Optional['download_only'] => Variant[Integer[0], Enum['always']],
    Optional['debdelta']      => Integer[0],
  }
]
