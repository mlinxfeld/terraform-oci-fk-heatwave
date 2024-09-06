output "mds_database" {
  value = {
    mds_id         = module.oci-fk-free-mds-heatwave.mds_database.mds_id
    mds_ip_address = module.oci-fk-free-mds-heatwave.mds_database.mds_ip_address
    mds_port       = module.oci-fk-free-mds-heatwave.mds_database.mds_port
    mds_port_x     = module.oci-fk-free-mds-heatwave.mds_database.mds_port_x
  }
}

output "FoggyKitchenBastionPublicIP" {
  value = [data.oci_core_vnic.FoggyKitchenBastion_VNIC1.public_ip_address]
}

output "generated_ssh_private_key" {
  value     = tls_private_key.public_private_key_pair.private_key_pem
  sensitive = true
}