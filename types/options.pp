type Unattended_upgrades::Options = Struct[
  {
    Optional['force_confdef']  => Boolean,
    Optional['force_confold']  => Boolean,
    Optional['force_confnew']  => Boolean,
    Optional['force_confmiss'] => Boolean,
  }
]
