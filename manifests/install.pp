class graphite_web::install (
  $group               = $::graphite_web::group,
  $index_file          = $::graphite_web::config_index_file,
  $manage_pkg          = $::graphite_web::manage_pkg,
  $graphite_root       = $::graphite_web::config_graphite_root,
  $graphite_web_ensure = $::graphite_web::graphite_web_ensure,
  $graphite_web_pkgs   = $::graphite_web::graphite_web_pkgs,
  $log_dir             = $::graphite_web::config_log_dir,
  $user                = $::graphite_web::user,  
) {

  if $manage_pkg {
    package { $graphite_web_pkgs:
      ensure => $graphite_web_ensure,
    }
  }

  group { $group:
    ensure => present,
  } ->

  user { $user:
    ensure => 'present',
    groups => $group,
    shell  => '/sbin/nologin',
  }

  file { $log_dir:
    path    => $log_dir,
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => '0755',
    require => [User[$user], Group[$group], Package[$graphite_web_pkgs]],
  }

  file { $graphite_root:
    path => $graphite_root,
    ensure => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file { 'storage_dir':
    path    => "${graphite_root}/storage",
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => File[$graphite_root],    
  }

  file { 'webapp_dir':
    path   => "${graphite_root}/webapp",
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    require => File[$graphite_root],
  }

  file { 'index_file':
    path    => "${graphite_root}/webapp/index",
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['webapp_dir'],
  }

}
