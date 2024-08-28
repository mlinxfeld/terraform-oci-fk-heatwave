module "oci-fk-mds" { 
  providers = {
    oci = oci.region1
  }
  #source                                = "github.com/mlinxfeld/terraform-oci-fk-heatwave"
  source                                = "../../"
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

module "oci-fk-cross-region-mds-backup" {   
  count                                  = var.mds_cross_region_manual_backup_enabled ? 1 : 0  
  providers = {
    oci = oci.region2
  }
  #source                                = "github.com/mlinxfeld/terraform-oci-fk-heatwave"
  source                                 = "../../"
  mds_cross_region_manual_backup_enabled = true
  mds_compartment_ocid                   = var.mds_compartment_ocid
  mds_cross_region_backup_region         = var.region
  mds_cross_region_manual_backup_ocid    = module.oci-fk-mds.mds_manual_backup.mds_manual_backup_id
}

