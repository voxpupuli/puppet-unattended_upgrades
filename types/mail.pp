# @summary Mail notification options.
# @param report When to send an email report.
# @param only_on_error Send email only on error.
# @param to Email address to send reports to.
type Unattended_upgrades::Mail = Struct[
  {
    Optional['report']        => String,
    Optional['only_on_error'] => Boolean,
    Optional['to']            => String,
  }
]
