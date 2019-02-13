class graphite_web::install (
  $group                   = $::graphite_web::group,
  $index_file              = $::graphite_web::config_index_file,
  $manage_pkg              = $::graphite_web::manage_pkg,
  $graphite_root           = $::graphite_web::config_graphite_root,
  $graphite_web_ensure     = $::graphite_web::graphite_web_ensure,
  $graphite_web_pkgs       = $::graphite_web::graphite_web_pkgs,
  $log_dir                 = $::graphite_web::config_log_dir,
  $memcached_enabled       = $::graphite_web::memcached_enabled,
  $memcached_python_ensure = $::graphite_web::memcached_python_ensure,
  $memcached_python_pkgs   = $::graphite_web::memcached_python_pkgs,
  $user                    = $::graphite_web::user,
) {

  if $manage_pkg {
    package { $graphite_web_pkgs:
      ensure => $graphite_web_ensure,
    }
    if $memcached_enabled {
      package { $memcached_python_pkgs:
        ensure => $memcached_python_ensure,
      }
    }
  }

  group { $group:
    ensure => present,
  }
  -> user { $user:
    ensure => 'present',
    groups => $group,
    shell  => '/sbin/nologin',
  }

  file { $log_dir:
    ensure  => directory,
    path    => $log_dir,
    owner   => $user,
    group   => $group,
    mode    => '0755',
    require => [User[$user], Group[$group], Package[$graphite_web_pkgs]],
  }

  file { $graphite_root:
    ensure => directory,
    path   => $graphite_root,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { 'storage_dir':
    ensure  => directory,
    path    => "${graphite_root}/storage",
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => File[$graphite_root],
  }

  file { 'webapp_dir':
    ensure  => directory,
    path    => "${graphite_root}/webapp",
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => File[$graphite_root],
  }

  file { 'index_file':
    ensure  => file,
    path    => "${graphite_root}/webapp/index",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['webapp_dir'],
  }

}
