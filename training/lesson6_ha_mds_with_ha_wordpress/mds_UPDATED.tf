module "oci-fk-mds" {
  source                                = "github.com/mlinxfeld/terraform-oci-fk-heatwave"
  mds_admin_password                    = var.mds_admin_password
  mds_availability_domain               = var.mds_availability_domain
  mds_compartment_ocid                  = var.mds_compartment_ocid
  mds_shape                             = "MySQL.2"
  mds_display_name                      = "FoggyKitchenMDSHA"
  mds_description                       = "FoggyKitchen High Available MySQL/Heatwave Database System"
  use_existing_vcn                      = true
  subnet_id                             = oci_core_subnet.FoggyKitchenPrivateSubnet.id
  mds_is_highly_available               = var.mds_is_highly_available
  mds_manual_backup_enabled             = true
}

