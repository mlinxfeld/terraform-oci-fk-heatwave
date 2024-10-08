output "mds_source" {
  value = {
    mds_id         = module.oci-fk-mds-source.mds_database.mds_id
    mds_ip_address = module.oci-fk-mds-source.mds_database.mds_ip_address
    mds_port       = module.oci-fk-mds-source.mds_database.mds_port
    mds_port_x     = module.oci-fk-mds-source.mds_database.mds_port_x
  }
}

output "mds_target_clone" {
  value = {
    mds_id         = var.mds_cross_region_clone_enabled ? module.oci-fk-mds-target-clone-from-x-region-backup[0].mds_database.mds_id : ""
    mds_ip_address = var.mds_cross_region_clone_enabled ? module.oci-fk-mds-target-clone-from-x-region-backup[0].mds_database.mds_ip_address : ""
    mds_port       = var.mds_cross_region_clone_enabled ? module.oci-fk-mds-target-clone-from-x-region-backup[0].mds_database.mds_port : ""
    mds_port_x     = var.mds_cross_region_clone_enabled ? module.oci-fk-mds-target-clone-from-x-region-backup[0].mds_database.mds_port_x : ""
  }
}

output "wordpress_home_URL" {
  value = "http://${module.oci-fk-wordpress.public_ip[0]}/"
}

output "wordpress_wp-admin_URL" {
  value = "http://${module.oci-fk-wordpress.public_ip[0]}/wp-admin/"
}

output "wordpress2_home_URL" {
  value = var.wordpress_on_mds_cross_region_clone_enabled ? "http://${module.oci-fk-wordpress2[0].public_ip[0]}/" : ""
}

output "wordpress2_wp-admin_URL" {
  value = var.wordpress_on_mds_cross_region_clone_enabled ? "http://${module.oci-fk-wordpress2[0].public_ip[0]}/wp-admin/" : ""
}

output "generated_ssh_private_key" {
  value     = tls_private_key.public_private_key_pair.private_key_pem
  sensitive = true
}

output "mds_channel" {
  value = {
    mds_channel_id = var.mds_channel_enabled ? module.oci-fk-mds-channel-source-to-target-clone[0].mds_channel.mds_channel_id : ""
  }
}
