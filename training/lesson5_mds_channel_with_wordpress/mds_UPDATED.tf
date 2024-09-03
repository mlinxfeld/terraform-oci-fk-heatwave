module "oci-fk-mds" { 
  providers = {
    oci = oci.region1
  }
  source                                = "github.com/mlinxfeld/terraform-oci-fk-heatwave"
  mds_admin_password                    = var.mds_admin_password
  mds_availability_domain               = var.mds_availability_domain
  mds_compartment_ocid                  = var.mds_compartment_ocid
  mds_shape                             = "MySQL.2"
  mds_display_name                      = "FoggyKitchenMDS"
  mds_description                       = "FoggyKitchen MySQL/Heatwave Database System"
  use_existing_vcn                      = true
  subnet_id                             = oci_core_subnet.FoggyKitchenPrivateSubnet.id
  mds_manual_backup_enabled             = var.mds_manual_backup_enabled
  mds_custom_configuration_enabled      = true
  mds_config_binlog_expire_logs_seconds = 10800 # 3 hours for binlog needed for successful replication via channel.
}

module "oci-fk-x-region-mds-backup" {   
  count                                  = var.mds_cross_region_manual_backup_enabled ? 1 : 0  
  providers = {
    oci = oci.region2
  }
  source                                = "github.com/mlinxfeld/terraform-oci-fk-heatwave"
  mds_cross_region_manual_backup_enabled = true
  mds_manual_backup_enabled              = false
  mds_compartment_ocid                   = var.mds_compartment_ocid
  mds_cross_region_backup_region         = var.region
  mds_cross_region_manual_backup_ocid    = module.oci-fk-mds.mds_backup.mds_backup_id
  mds_cross_region_backup_description    = "FoggyKitchen MDS Cross-Region Copy of Manual Backup"
  mds_cross_region_backup_display_name   = "FoggyKitchenMDSXRegionBackup" 
  use_existing_vcn                       = true
}

module "oci-fk-mds-clone-from-x-region-backup" { 
  count                                  = var.mds_cross_region_clone_enabled ? 1 : 0    
  providers = {
    oci = oci.region2
  }
  source                                = "github.com/mlinxfeld/terraform-oci-fk-heatwave"
  mds_defined_source_enabled            = true
  mds_defined_source_type               = "BACKUP"
  mds_defined_source_backup_ocid        = module.oci-fk-x-region-mds-backup[0].mds_backup.mds_cross_region_backup_id
  mds_admin_password                    = var.mds_admin_password
  mds_availability_domain               = var.mds_availability_domain2
  mds_compartment_ocid                  = var.mds_compartment_ocid
  mds_shape                             = "MySQL.2"
  mds_display_name                      = "FoggyKitchenMDSXRegionClone"
  mds_description                       = "FoggyKitchen MySQL/Heatwave Database System (X-Region Clone)"
  use_existing_vcn                      = true
  subnet_id                             = oci_core_subnet.FoggyKitchenPrivateSubnet2.id
}

module "oci-fk-mds-channel" { 
  count = var.mds_cross_region_clone_enabled ? 1 : 0    
  source = "github.com/mlinxfeld/terraform-oci-fk-heatwave"
  providers = {
    oci = oci.region2
  }
  mds_compartment_ocid                                        = var.mds_compartment_ocid
  mds_channel_enabled                                         = true
  mds_channel_source_mysql_database_hostname                  = module.oci-fk-mds.mds_database.mds_ip_address
  mds_channel_source_mysql_database_replication_user_name     = "wp_repl_user"
  mds_channel_source_mysql_database_replication_user_password = var.mds_admin_password
  mds_channel_target_db_system_id                             = module.oci-fk-mds-clone-from-x-region-backup[0].mds_database.mds_id
  mds_channel_target_delay_in_seconds                         = 1
}