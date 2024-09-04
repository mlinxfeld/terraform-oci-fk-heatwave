
# With this module we are building source MDS instance with manual backup

module "oci-fk-mds-source" { 
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

# With this module we are creating cross-regional copy of the manual backup of the source MDS instance.

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
  mds_cross_region_manual_backup_ocid    = module.oci-fk-mds-source.mds_backup.mds_backup_id
  mds_cross_region_backup_description    = "FoggyKitchen MDS Cross-Region Copy of Manual Backup"
  mds_cross_region_backup_display_name   = "FoggyKitchenMDSXRegionBackup" 
  use_existing_vcn                       = true
}

# With this module we are creating target clone in another region based on the copied backup

module "oci-fk-mds-target-clone-from-x-region-backup" { 
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

# With this module we are setting up replication user on the source MDS instance.

module "oci-fk-mds-repl-user-setup" { 
  count = var.mds_channel_repl_user_setup_enabled ? 1 : 0    
  source = "github.com/mlinxfeld/terraform-oci-fk-heatwave"
  providers = {
    oci = oci.region1
  }
  mds_channel_repl_user_setup_enabled                         = true
  mds_admin_username                                          = var.mds_admin_username
  mds_admin_password                                          = var.mds_admin_password
  mds_channel_source_mysql_database_hostname                  = module.oci-fk-mds-source.mds_database.mds_ip_address
  mds_channel_source_ip_address_range                         = module.oci-fk-mds-target-clone-from-x-region-backup[0].mds_database.mds_ip_address
  mds_channel_source_mysql_database_replication_user_name     = var.mds_repl_username
  mds_channel_source_mysql_database_replication_user_password = var.mds_repl_password
  mds_channel_bastion_hostname                                = module.oci-fk-wordpress.public_ip[0]
  mds_channel_bastion_private_key                             = module.oci-fk-wordpress.generated_ssh_private_key
  mds_compartment_ocid                                        = var.mds_compartment_ocid
  use_existing_vcn                                            = true
}

# With this module we are creating channel for outbound cross-regional replication from the source to target clone.

module "oci-fk-mds-channel-source-to-target-clone" { 
  count = var.mds_channel_enabled ? 1 : 0    
  source = "github.com/mlinxfeld/terraform-oci-fk-heatwave"
  providers = {
    oci = oci.region2
  }
  mds_channel_enabled                                         = true
  mds_channel_source_mysql_database_hostname                  = module.oci-fk-mds-source.mds_database.mds_ip_address
  mds_channel_source_mysql_database_replication_user_name     = var.mds_repl_username
  mds_channel_source_mysql_database_replication_user_password = var.mds_repl_password  
  mds_channel_target_db_system_id                             = module.oci-fk-mds-target-clone-from-x-region-backup[0].mds_database.mds_id
  mds_channel_target_delay_in_seconds                         = 1
  use_existing_vcn                                            = true
  mds_compartment_ocid                                        = var.mds_compartment_ocid
}