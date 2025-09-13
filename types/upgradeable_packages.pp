# @summary Options for upgradeable packages.
# @param download_only Only download packages, do not install.
# @param debdelta Use debdelta to download smaller delta files.
type Unattended_upgrades::Upgradeable_packages = Struct[
  {
    Optional['download_only'] => Variant[Integer[0], Enum['always']],
    Optional['debdelta']      => Integer[0],
  }
]
