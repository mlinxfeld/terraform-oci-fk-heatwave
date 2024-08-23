module "oci-fk-free-mds" {
  #source                                = "github.com/mlinxfeld/terraform-oci-fk-heatwave"
  source                                = "../../"
  mds_admin_password                    = var.mds_admin_password
  mds_availability_domain               = var.mds_availability_domain
  mds_compartment_ocid                  = var.mds_compartment_ocid
  mds_shape                             = "MySQL.Free"
  mds_display_name                      = "FoggyKitchenFreeTierMDS"
  mds_description                       = "FoggyKitchen Free Tier MySQL/Heatwave Database System"
  use_existing_vcn                      = true
  subnet_id                             = oci_core_subnet.FoggyKitchenPrivateSubnet.id
}

