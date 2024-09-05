output "mds_database" {
  value = {
    mds_id         = module.oci-fk-free-mds.mds_database.mds_id
    mds_ip_address = module.oci-fk-free-mds.mds_database.mds_ip_address
    mds_port       = module.oci-fk-free-mds.mds_database.mds_port
    mds_port_x     = module.oci-fk-free-mds.mds_database.mds_port_x
  }
}
