type Unattended_upgrades::Upgradeable_packages = Struct[
  {
    Optional['download_only'] => Integer[0],
    Optional['debdelta']      => Integer[0],
  }
]
