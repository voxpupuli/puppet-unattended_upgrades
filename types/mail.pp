type Unattended_upgrades::Mail = Struct[
  {
    Optional['report']        => String,
    Optional['only_on_error'] => Boolean,
    Optional['to']            => String,
  }
]
