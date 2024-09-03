resource "oci_mysql_channel" "FoggyKitchenMDSChannel" {
  count          = var.mds_channel_enabled ? 1 : 0  
  display_name   = var.mds_channel_display_name
  
  source {
    hostname    = var.mds_channel_source_mysql_database_hostname
    source_type = var.mds_channel_source_mysql_database_source_type
    username    = var.mds_channel_source_mysql_database_replication_user_name
    password    = var.mds_channel_source_mysql_database_replication_user_password
    ssl_mode    = var.mds_channel_source_mysql_database_ssl_mode

    anonymous_transactions_handling {
      policy = "ERROR_ON_ANONYMOUS"
    }
  }

  target {
    target_type  = var.mds_channel_target_target_type
    db_system_id = var.mds_channel_target_db_system_id
    channel_name = var.mds_channel_target_channel_name
    delay_in_seconds = var.mds_channel_target_delay_in_seconds
    tables_without_primary_key_handling = var.mds_channel_target_tables_without_primary_key_handling
  }
}

