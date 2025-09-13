# @summary Automatic upgrade options.
# @param clean Automatically remove unused dependency packages.
# @param fix_interrupted_dpkg Try to fix dpkg interruptions.
# @param reboot Automatically reboot after an upgrade.
# @param reboot_withusers Reboot even if users are logged in.
# @param reboot_time Time to reboot.
# @param remove Automatically remove unused new packages.
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
