output "mds_database" {
  value = {
    mds_id         = var.mds_channel_enabled || var.var.mds_channel_repl_user_setup_enabled ? "" : var.mds_cross_region_manual_backup_enabled ? "" : oci_mysql_mysql_db_system.FoggyKitchenMDS[0].id
    mds_ip_address = var.mds_channel_enabled || var.var.mds_channel_repl_user_setup_enabled ? "" : var.mds_cross_region_manual_backup_enabled ? "" : oci_mysql_mysql_db_system.FoggyKitchenMDS[0].endpoints[0].ip_address
    mds_port       = var.mds_channel_enabled || var.var.mds_channel_repl_user_setup_enabled ? "" : var.mds_cross_region_manual_backup_enabled ? "" : oci_mysql_mysql_db_system.FoggyKitchenMDS[0].endpoints[0].port
    mds_port_x     = var.mds_channel_enabled || var.var.mds_channel_repl_user_setup_enabled ? "" : var.mds_cross_region_manual_backup_enabled ? "" : oci_mysql_mysql_db_system.FoggyKitchenMDS[0].endpoints[0].port_x
    mds_hostname   = var.mds_channel_enabled || var.var.mds_channel_repl_user_setup_enabled ? "" : var.mds_cross_region_manual_backup_enabled ? "" : oci_mysql_mysql_db_system.FoggyKitchenMDS[0].endpoints[0].hostname
    mds_subnet_id  = var.mds_channel_enabled || var.var.mds_channel_repl_user_setup_enabled ? "" : var.mds_cross_region_manual_backup_enabled ? "" : var.subnet_id != "" ? var.subnet_id : var.use_public_subnet ? oci_core_subnet.FoggyKitchenPublicSubnet[0].id : oci_core_subnet.FoggyKitchenPrivateSubnet[0].id
  }
}

output "mds_backup" {
   value = {
     mds_backup_id = var.mds_channel_enabled || var.var.mds_channel_repl_user_setup_enabled ? "" : var.mds_cross_region_manual_backup_enabled ? "" : var.mds_manual_backup_enabled ? oci_mysql_mysql_backup.FoggyKitchenMDSManualBackup[0].id : ""
     mds_cross_region_backup_id = var.mds_channel_enabled || var.var.mds_channel_repl_user_setup_enabled ? "" : var.mds_cross_region_manual_backup_enabled ? oci_mysql_mysql_backup.FoggyKitchenMDSCrossRegionBackup[0].id : ""
   }
}

output "mds_channel" {
   value = {
      mds_channel_id = var.mds_channel_enabled || var.var.mds_channel_repl_user_setup_enabled ? oci_mysql_channel.FoggyKitchenMDSChannel[0].id : ""
   }
}