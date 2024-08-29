resource "oci_mysql_channel" "FoggyKitchenMDSChannel" {
  count          = var.mds_channel_enable ? 1 : 0  
  provider       = oci.region2  
  display_name   = "FoggyKitchenMDSChannel"
  
  source {
    hostname    = module.oci-fk-mds.mds_database.mds_ip_address
    password    = var.mds_admin_password
    source_type = "MYSQL"
    username    = var.mds_admin_username 
    ssl_mode    = "REQUIRED" 

    anonymous_transactions_handling {
      policy = "ERROR_ON_ANONYMOUS"
    }
  }

  target {
    db_system_id = module.oci-fk-mds-clone-from-x-region-backup[0].mds_database.mds_id
    target_type  = "DBSYSTEM"
    channel_name = "MySQLMDSChannel"

    filters {
      type = "REPLICATE_DO_DB"
      value = "value"
    }
    delay_in_seconds = "60"
    tables_without_primary_key_handling = "GENERATE_IMPLICIT_PRIMARY_KEY"
  }
}
