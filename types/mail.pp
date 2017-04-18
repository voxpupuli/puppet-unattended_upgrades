type Unattended_upgrades::Mail = Struct[
  {
    Optional['only_on_error'] => Boolean,
    Optional['to']            => String,
  }
]
