class oxford::config(
  $conn_type   = '',
  $ldap_host   = '',
  $ldap_port   = '',
  $ldap_method = '',
  $ldap_base   = '',
  $ldap_user   = '',
  $ldap_pass   = ''
) {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { $oxford::params::od_conf_file:
    ensure  => 'file',
    content => template('oxford/oxford.conf.erb'),
  }
}
