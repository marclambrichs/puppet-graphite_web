class graphite_web::config (
  $auto_refresh_interval          = $::graphite_web::config_auto_refresh_interval,
  $carbon_caches                  = $::graphite_web::carbon_caches,
  $carbon_metric_prefix           = $::graphite_web::config_carbon_metric_prefix,
  $carbonlink_hashing_type        = $::graphite_web::config_carbonlink_hashing_type,
  $carbonlink_retry_delay         = $::graphite_web::config_carbonlink_retry_delay,
  $carbonlink_timeout             = $::graphite_web::config_carbonlink_timeout,
  $config_dir                     = $::graphite_web::config_dir,
  $databases                      = $::graphite_web::config_databases,
  $database_engine                = 'postgresql',
  $date_format                    = $::graphite_web::config_date_format,
  $db_file                        = $::graphite_web::db_file,
  $debug                          = $::graphite_web::config_debug,
  $graphite_root                  = $::graphite_web::config_graphite_root,
  $index_file                     = $::graphite_web::config_index_file,
  $log_cache_performance          = $::graphite_web::config_log_cache_performance,
  $log_dir                        = $::graphite_web::config_log_dir,
  $log_rendering_performance      = $::graphite_web::config_log_rendering_performance,
  $log_rotation                   = $::graphite_web::config_log_rotation,
  $log_rotation_count             = $::graphite_web::config_log_rotation_count,
  $max_tag_length                 = $::graphite_web::config_max_tag_length,
  $replication_factor             = $::graphite_web::config_replication_factor,
  $secret_key                     = $::graphite_web::config_secret_key,
  $storage_dir                    = $::graphite_web::config_storage_dir,
  $time_zone                      = $::graphite_web::config_time_zone,
  $url_prefix                     = $::graphite_web::config_url_prefix,
  $use_remote_user_authentication = $::graphite_web::config_use_remote_user_authentication,
  $whisper_dir                    = $::graphite_web::config_whisper_dir,
) {
    
  $config_file = "${config_dir}/local_settings.py"

  file { $config_dir:
    path   => $config_dir,
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  
  concat { $config_file:
    owner => 'root',
    group => 'root',
    mode => '0644',
  }

  ###
  ### local_settings.py - general
  ###
  concat::fragment { 'graphite_web config general':
    target  => $config_file,
    content => template('graphite_web/etc/graphite-web/local_settings.py.general.erb'),
    order   => '01',
  }

  ###
  ### local_settings.py - filesystem paths
  ###
  concat::fragment { 'graphite_web config filesystem paths':
    target  => $config_file,
    content => template('graphite_web/etc/graphite-web/local_settings.py.filesystem.erb'),
    order   => '02',
  }
  
  ###
  ### local_settings.py - email configuration
  ###

  ###
  ### local_settings.py - authentication configuration
  ###

  ###
  ### local_settings.py - authorization for dashboard
  ###

  ###
  ### local_settings.py - database configuration
  ###
  concat::fragment { 'graphite_web config database configuration':
    target  => $config_file,
    content => template('graphite_web/etc/graphite-web/local_settings.py.database.erb'),
    order   => '07',
  }  

  ###
  ### local_settings.py - cluster configuration
  ###
  concat::fragment { 'graphite_web config cluster':
    target  => $config_file,
    content => template('graphite_web/etc/graphite-web/local_settings.py.cluster.erb'),
    order   => '08',
  }  
  
  ###
  ### local_settings.py - additional django settings
  ###

  case $database_engine {
    'postgresql': {
      package { 'python-psycopg2':
        ensure => installed,
      }
      
      exec { 'fill postgresql database':
        command     => '/bin/graphite-manage syncdb --noinput',
        cwd         => "${graphite_root}/webapp",
        require     => [Concat::Fragment['graphite_web config database configuration'],
                        Package['python-psycopg2']]
      }
    }
    default: {
      exec {'create database':
        command     => 'graphite-manage syncdb --noinput',
        environment => 'PYTHONPATH=/usr/share/graphite/webapp',
        creates     => "${graphite_root}/storage/graphite.db",
        refreshonly => true,        
        require     => Concat[$config_file],
      }
    }
  }
}  
