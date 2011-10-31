class oxford::service {
  cron { 'oxford':
    command => "${oxford::params::od_oxford_path} -c ${oxford::params::od_conf_file}",
    user    => 'root',
    minute  => "*/${oxford::params::od_cron_run}",
  }
}
