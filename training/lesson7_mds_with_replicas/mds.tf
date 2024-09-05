module "oci-fk-mds" {
  source                                = "github.com/mlinxfeld/terraform-oci-fk-heatwave"
  mds_admin_password                    = var.mds_admin_password
  mds_availability_domain               = var.mds_availability_domain
  mds_compartment_ocid                  = var.mds_compartment_ocid
  mds_shape                             = "MySQL.2"
  mds_display_name                      = "FoggyKitchenMDS"
  mds_description                       = "FoggyKitchenMySQL/Heatwave Database System"
  use_existing_vcn                      = false
  mds_custom_configuration_enabled      = true
  mds_config_binlog_expire_logs_seconds = 10800
}

module "oci-fk-mds-replica" {
  count                                  = var.mds_replica_enabled ? 1 : 0  
  source                                 = "github.com/mlinxfeld/terraform-oci-fk-heatwave"
  mds_replica_enabled                    = true
  mds_admin_password                     = var.mds_admin_password
  mds_availability_domain                = var.mds_availability_domain
  mds_compartment_ocid                   = var.mds_compartment_ocid
  mds_replica_source_db_system_id        = module.oci-fk-mds.mds_database.mds_id
  mds_replica_display_name               = "FoggyKitchenMDSReplica"
  mds_replica_description                = "FoggyKitchenMySQL/Heatwave Database System Replica"
  mds_configuration_description          = "FoggyKitchen MDS Replica Custom Configuration"
  mds_configuration_display_name         = "FoggyKitchenMDSReplicaCustomConfiguration"
  mds_replica_overrides                  = true
  mds_replica_overrides_configuration_id = module.oci-fk-mds.mds_database.mds_configuration_id
  mds_replica_overrides_shape            = "MySQL.4"
  use_existing_vcn                       = true
  subnet_id                              = module.oci-fk-mds.mds_database.mds_subnet_id
}

