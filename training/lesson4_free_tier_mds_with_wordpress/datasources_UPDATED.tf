data "oci_identity_availability_domains" "ADs" {
  compartment_id = var.tenancy_ocid
}

data "oci_core_images" "OSImage" {
  compartment_id           = var.mds_compartment_ocid
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  shape                    = var.wordpress_compute_shape

  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}
/*
data "oci_core_vnic_attachments" "FoggyKitchenBastion_VNIC1_attach" {
  availability_domain = var.mds_availability_domain == "" ? lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name") : var.mds_availability_domain
  compartment_id      = var.mds_compartment_ocid
  instance_id         = oci_core_instance.FoggyKitchenBastion.id
}

data "oci_core_vnic" "FoggyKitchenBastion_VNIC1" {
  vnic_id = data.oci_core_vnic_attachments.FoggyKitchenBastion_VNIC1_attach.vnic_attachments.0.vnic_id
}
*/