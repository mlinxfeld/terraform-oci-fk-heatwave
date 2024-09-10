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
}

module "oci-fk-x-region-mds-backup" {   
  count                                  = var.mds_cross_region_manual_backup_enabled ? 1 : 0  
  providers = {
    oci = oci.region2
  }
  source                                = "github.com/mlinxfeld/terraform-oci-fk-heatwave"
  mds_cross_region_manual_backup_enabled = true
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
  use_existing_vcn                      = false
  use_public_subnet                     = true
  mds_vcn_cidr_block                    = "172.16.0.0/24"
  mds_subnet_cidr_block                 = "172.16.0.128/25"
}