class oxford::package {
  Exec { 
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }
  exec { 'download-oxford-gem':
    command => "wget -O /tmp/oxford.gem ${oxford::params::od_oxford_gem}",
    creates => "/tmp/oxford.gem",
    unless  => "test -e ${oxford::params::od_oxford_path}",
  }
  exec { 'install-oxford':
    command => "${oxford::params::od_gem_path}/gem install /tmp/oxford.gem",
    unless  => "${oxford::params::od_gem_path}/gem list | grep oxford | grep ${oxford::params::od_oxford_ver}",
    require => Exec['download-oxford-gem'],
  }
  file { '/tmp/oxford.gem':
    ensure  => absent,
    require => Exec['install-oxford'],
  }
}
