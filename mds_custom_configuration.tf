resource "oci_mysql_mysql_configuration" "FoggyKitchenMDSConfiguration" {
    count = var.mds_custom_configuration_enabled && !(var.mds_shape == "MySQL.Free") && !(var.mds_channel_enabled) && !(var.mds_replica_enabled) ? 1 : 0
    compartment_id = var.mds_compartment_ocid 
    shape_name = var.heatwave_cluster_enabled ? var.heatwave_shape : var.mds_shape
    defined_tags = var.mds_defined_tags
    description = var.mds_configuration_description
    display_name = var.mds_configuration_display_name
    freeform_tags = var.mds_freeform_tags
    
    variables {
        binlog_expire_logs_seconds = var.mds_config_binlog_expire_logs_seconds 
    }

}