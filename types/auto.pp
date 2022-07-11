type Unattended_upgrades::Auto = Struct[
  {
    Optional['clean']                => Variant[Integer[0], Enum['always']],
    Optional['fix_interrupted_dpkg'] => Boolean,
    Optional['reboot']               => Boolean,
    Optional['reboot_withusers']     => Boolean,
    Optional['reboot_time']          => String,
    Optional['remove']               => Boolean,
  }
]
