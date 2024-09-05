resource "oci_mysql_replica" "FoggyKitchenMDSReplica" {
    count               = var.mds_replica_enabled ? 1 : 0
    db_system_id        = var.mds_replica_source_db_system_id
    defined_tags        = var.mds_defined_tags
    description         = var.mds_replica_description
    display_name        = var.mds_replica_display_name
    freeform_tags       = var.mds_freeform_tags
    is_delete_protected = var.mds_replica_is_delete_protected

    dynamic "replica_overrides" {
        for_each = var.mds_replica_overrides ? [1] : []
        content {
            configuration_id = (var.mds_replica_enabled) && (var.mds_replica_overrides_configuration_id == "") ? oci_mysql_mysql_configuration.FoggyKitchenMDSConfiguration[0].id : var.mds_replica_overrides_configuration_id
            mysql_version    = var.replica_replica_overrides_mysql_version
            shape_name       = var.mds_replica_overrides_shape
        }
    }
}