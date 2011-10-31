class oxford(
  $conn_type   = 'ldap',
  $ldap_host   = '',
  $ldap_port   = '',
  $ldap_method = 'plain',
  $ldap_base   = '',
  $ldap_user   = '',
  $ldap_pass   = ''
) {
  include stdlib
  include oxford::params

  if $ldap_host == '' { $REAL_ldap_host = $oxford::params::od_ldap_host }
  else { $REAL_ldap_host = $ldap_host }

  if $ldap_port == '' { $REAL_ldap_port = $oxford::params::od_ldap_port }
  else { $REAL_ldap_port = $ldap_port }

  if $ldap_base == '' { $REAL_ldap_base = $oxford::params::od_ldap_base }
  else { $REAL_ldap_base = $ldap_base }

  if $ldap_user == '' { $REAL_ldap_user = $oxford::params::od_ldap_user }
  else { $REAL_ldap_user = $ldap_user }

  if $ldap_pass == '' { $REAL_ldap_pass = $oxford::params::od_ldap_pass }
  else { $REAL_ldap_pass = $ldap_pass }

  case $conn_type {
    ldap:    { $REAL_conn_type = $conn_type }
    default: { fail('unrecgonized connection type') }
  }

  case $ldap_method {
    plain,ssl: { $REAL_ldap_method = $ldap_method }
      default: { fail('unrecgonized ldap connection method') }
  }

  anchor { 'oxford::begin': }
  -> class { 'oxford::package': }
  -> class { 'oxford::config': 
    conn_type   => $REAL_conn_type,
    ldap_host   => $REAL_ldap_host,
    ldap_port   => $REAL_ldap_port,
    ldap_method => $REAL_ldap_method,
    ldap_base   => $REAL_ldap_base,
    ldap_user   => $REAL_ldap_user,
    ldap_pass   => $REAL_ldap_pass,
  }
  -> class { 'oxford::service': }
  -> anchor { 'oxford::end': }
}
