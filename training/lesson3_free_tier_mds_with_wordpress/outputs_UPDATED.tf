output "mds_database" {
  value = {
    mds_id         = module.oci-fk-free-mds.mds_database.mds_id
    mds_ip_address = module.oci-fk-free-mds.mds_database.mds_ip_address
    mds_port       = module.oci-fk-free-mds.mds_database.mds_port
    mds_port_x     = module.oci-fk-free-mds.mds_database.mds_port_x
  }
}

output "wordpress_home_URL" {
  value = "http://${module.oci-fk-wordpress.public_ip[0]}/"
}

output "wordpress_wp-admin_URL" {
  value = "http://${module.oci-fk-wordpress.public_ip[0]}/wp-admin/"
}

output "generated_ssh_private_key" {
  value     = tls_private_key.public_private_key_pair.private_key_pem
  sensitive = true
}

