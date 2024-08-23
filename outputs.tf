output "mds_database" {
  value = {
    mds_id         = oci_mysql_mysql_db_system.FoggyKitchenMDS.id
    mds_ip_address = oci_mysql_mysql_db_system.FoggyKitchenMDS.endpoints[0].ip_address
    mds_port       = oci_mysql_mysql_db_system.FoggyKitchenMDS.endpoints[0].port
    mds_port_x     = oci_mysql_mysql_db_system.FoggyKitchenMDS.endpoints[0].port_x
    mds_subnet_id  = var.subnet_id != "" ? var.subnet_id : var.use_public_subnet ? oci_core_subnet.FoggyKitchenPublicSubnet[0].id : oci_core_subnet.FoggyKitchenPrivateSubnet[0].id
  }
}