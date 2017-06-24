class graphite_web::params {
  $carbon_caches                           = { a =>
    {
      cache_query_port => 7102
    }
  }
  $config_auto_refresh_interval            = 60
  $config_carbon_metric_prefix             = 'carbon'
  $config_carbonlink_hashing_type          = 'carbon_ch'
  $config_carbonlink_retry_delay           = 15
  $config_carbonlink_timeout               = '1.0'
  $config_database_engine                  = 'sqlite3'
  $config_databases                        = { 'default' =>
    {
      name     => '/var/lib/graphite-web/storage/graphite.db',
      engine   => 'django.db.backends.sqlite3',
      host     => '',
      password => '',
      port     => '',
      user     => '',
    }
  }
  $config_date_format                      = '%m/%d'
  $config_debug                            = 'False'
  $config_dir                              = '/etc/graphite-web'
  $config_graphite_root                    = '/var/lib/graphite-web'
  $config_index_file                       = '/var/lib/graphite-web/webapp/index'
  $config_log_cache_performance            = 'True'
  $config_log_dir                          = '/var/log/graphite-web'
  $config_log_rendering_performance        = 'True'
  $config_log_rotation                     = 'True'
  $config_log_rotation_count               = 1
  $config_max_tag_length                   = 50
  $config_replication_factor               = 1
  $config_secret_key                       = 'secret'
  $config_storage_dir                      = '/var/lib/graphite-web/storage'
  $config_time_zone                        = 'Europe/Amsterdam'
  $config_url_prefix                       = '/graphite'
  $config_use_remote_user_authentication   = 'False'
  $config_whisper_dir                      = '/var/lib/carbon/whisper'
  $graphite_web_ensure                     = present
  $graphite_web_pkgs                       = [ 'graphite-web',  ]
  $group                                   = 'graphite-web'
  $manage_pkg                              = true
  $config_memcached_default_cache_duration = 60
  $config_memcached_hosts                  = ['127.0.0.1:11211']
  $memcached_python_ensure                 = present
  $memcached_python_pkgs                   = [ 'python-memcached', ]
  $memcached_enabled                       = false
  $user                                    = 'graphite-web'
}
