/*resource "oci_core_instance" "FoggyKitchenBastion" {
  availability_domain = var.mds_availability_domain == "" ? lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name") : var.mds_availability_domain
  compartment_id      = var.mds_compartment_ocid
  display_name        = "FoggyKitchenBastion"
  shape               = var.bastion_shape

  dynamic "shape_config" {
    for_each = local.is_flexible_shape ? [1] : []
    content {
      memory_in_gbs = var.bastion_flex_shape_memory
      ocpus         = var.bastion_flex_shape_ocpus
    }
  }

  source_details {
    source_type = "image"
    source_id   = lookup(data.oci_core_images.OSImage.images[0], "id")
  }

  metadata = {
    ssh_authorized_keys = tls_private_key.public_private_key_pair.public_key_openssh
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.FoggyKitchenPublicSubnet.id
    assign_public_ip = true
  }
}
*/