# == Class: graphite-web
#
# Class for installing graphite-web, the graphite frontend.
#
# === Parameters
#
# @param carbon_caches
# @param config_auto_refresh_interval
# @param config_carbon_metric_prefix
# @param config_carbonlink_hashing_type
# @param config_carbonlink_retry_delay
# @param config_carbonlink_timeout
# @param config_database_engine
# @param config_databases
# @param config_date_format
# @param config_debug
# @param config_dir
# @param config_graphite_root
# @param config_index_file
# @param config_log_cache_performance
# @param config_log_dir
# @param config_log_rendering_performance
# @param config_log_rotation
# @param config_log_rotation_count
# @param config_max_tag_length
# @param config_replication_factor
# @param config_secret_key
# @param config_storage_dir
# @param config_time_zone
# @param config_url_prefix
# @param config_use_remote_user_authentication
# @param config_whisper_dir
# @param graphite_web_ensure
# @param graphite_web_pkgs
# @param group
# @param manage_pkg
# @param user
#
# === Authors
#
# Marc Lambrichs <marc.lambrichs@gmail.com>
#
# === Copyright
#
# Copyright 2017 Marc Lambrichs, unless otherwise noted
#
class graphite_web (
  $carbon_caches                         = $::graphite_web::params::carbon_caches,
  $config_auto_refresh_interval          = $::graphite_web::params::config_auto_refresh_interval,
  $config_carbon_metric_prefix           = $::graphite_web::params::config_carbon_metric_prefix,
  $config_carbonlink_hashing_type        = $::graphite_web::params::config_carbonlink_hashing_type,
  $config_carbonlink_retry_delay         = $::graphite_web::params::config_carbonlink_retry_delay,
  $config_carbonlink_timeout             = $::graphite_web::params::config_carbonlink_timeout,
  $config_database_engine                = $::graphite_web::params::config_database_engine,
  $config_databases                      = $::graphite_web::params::config_databases,
  $config_date_format                    = $::graphite_web::params::config_date_format,
  $config_debug                          = $::graphite_web::params::config_debug,
  $config_dir                            = $::graphite_web::params::config_dir,
  $config_graphite_root                  = $::graphite_web::params::config_graphite_root,
  $config_index_file                     = $::graphite_web::params::config_index_file,
  $config_log_cache_performance          = $::graphite_web::params::config_log_cache_performance,
  $config_log_dir                        = $::graphite_web::params::config_log_dir,
  $config_log_rendering_performance      = $::graphite_web::params::config_log_rendering_performance,
  $config_log_rotation                   = $::graphite_web::params::config_log_rotation,
  $config_log_rotation_count             = $::graphite_web::params::config_log_rotation_count,
  $config_max_tag_length                 = $::graphite_web::params::config_max_tag_length,
  $config_replication_factor             = $::graphite_web::params::config_replication_factor,
  $config_secret_key                     = $::graphite_web::params::config_secret_key,
  $config_storage_dir                    = $::graphite_web::params::config_storage_dir,
  $config_time_zone                      = $::graphite_web::params::config_time_zone,
  $config_url_prefix                     = $::graphite_web::params::config_url_prefix,
  $config_use_remote_user_authentication = $::graphite_web::params::config_use_remote_user_authentication,
  $config_whisper_dir                    = $::graphite_web::params::config_whisper_dir,
  $graphite_web_ensure                   = $::graphite_web::params::graphite_web_ensure,
  $graphite_web_pkgs                     = $::graphite_web::params::graphite_web_pkgs,
  $group                                 = $::graphite_web::params::group,
  $manage_pkg                            = $::graphite_web::params::manage_pkg,
  $user                                  = $::graphite_web::params::user,
) inherits graphite_web::params {

  member( ['carbon_ch', 'fnv1a_ch'], $config_carbonlink_hashing_type )
  member( ['mysql', 'oracle', 'postgresql', 'sqlite3'], $config_database_engine )

  anchor { 'graphite_web::begin': }
  -> class { '::graphite_web::install': }
  -> class { '::graphite_web::config': }
  -> anchor { 'graphite_web::end': }

}
