type Unattended_upgrades::Auto = Struct[
  {
    Optional['clean']                => Integer[0],
    Optional['fix_interrupted_dpkg'] => Boolean,
    Optional['reboot']               => Boolean,
    Optional['reboot_time']          => String,
    Optional['remove']               => Boolean,
  }
]
