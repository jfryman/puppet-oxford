class oxford::package(
  $version,
  $use_pm_ruby 
) {
  Exec { 
    path    => '/bin:/sbin:/usr/bin:/usr/sbin',
    unless  => "${oxford::params::od_gem_path}/gem list | grep oxford | grep ${version}",
  }
 
  if $use_pm_ruby == 'true' {
    exec { 'download-oxford-gem':
      command => "wget -O /tmp/oxford.gem ${oxford::params::od_gem_http}/oxford-${version}.gem",
      creates => "/tmp/oxford.gem",
    }
    exec { 'uninstall-old-oxford':
      command => "${oxford::params::od_gem_path}/gem uninstall oxford",
      onlyif  => "${oxford::params::od_gem_path}/gem list | grep oxford",
      require => Exec['download-oxford-gem'],
    }
    exec { 'install-oxford':
      command => "${oxford::params::od_gem_path}/gem install /tmp/oxford.gem --no-ri --no-rdoc",
      require => Exec['uninstall-old-oxford'],
    }
    file { '/tmp/oxford.gem':
      ensure  => absent,
      require => Exec['install-oxford'],
    }
  } 
  else {
    package { 'oxford':
      ensure   => $version,
      provider => 'gem',
    }
  }
}
