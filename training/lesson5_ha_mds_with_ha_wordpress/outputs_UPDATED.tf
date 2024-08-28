output "mds_database" {
  value = {
    mds_id         = module.oci-fk-mds.mds_database.mds_id
    mds_ip_address = module.oci-fk-mds.mds_database.mds_ip_address
    mds_port       = module.oci-fk-mds.mds_database.mds_port
    mds_port_x     = module.oci-fk-mds.mds_database.mds_port_x
  }
}

output "wordpress_home_URL" {
  value = "http://${module.oci-fk-wordpress.public_ip[0]}/"
}

output "wordpress_wp-admin_URL" {
  value = "http://${module.oci-fk-wordpress.public_ip[0]}/wp-admin/"
}

output "generated_ssh_private_key" {
  value     = module.oci-fk-wordpress.generated_ssh_private_key
  sensitive = true
}

