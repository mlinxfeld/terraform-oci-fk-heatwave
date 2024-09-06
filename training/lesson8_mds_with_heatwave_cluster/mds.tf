module "oci-fk-free-mds-heatwave" {
  source                                = "github.com/mlinxfeld/terraform-oci-fk-heatwave"
  mds_admin_password                    = var.mds_admin_password
  mds_availability_domain               = var.mds_availability_domain
  mds_compartment_ocid                  = var.mds_compartment_ocid
  mds_shape                             = "MySQL.Free"
  mds_display_name                      = "FoggyKitchenMDSHeatwave"
  mds_description                       = "FoggyKitchenMySQL/Heatwave Database System"
  use_existing_vcn                      = true
  subnet_id                             = oci_core_subnet.FoggyKitchenPrivateSubnet.id
  heatwave_cluster_enabled              = var.mds_heatwave_enabled
  heatwave_shape                        = "HeatWave.Free" 
  heatwave_cluster_size                 = 1
}
