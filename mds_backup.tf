resource "oci_mysql_mysql_backup" "FoggyKitchenMDSManualBackup" {
    count             = var.mds_manual_backup_enabled && !(var.mds_shape == "MySQL.Free") && !(var.mds_channel_enabled) ? 1 : 0
    db_system_id      = oci_mysql_mysql_db_system.FoggyKitchenMDS[0].id
    backup_type       = var.mds_backup_backup_type
    defined_tags      = var.mds_defined_tags
    description       = var.mds_backup_description
    display_name      = var.mds_backup_display_name
    freeform_tags     = var.mds_freeform_tags
    retention_in_days = var.mds_backup_retention_in_days
}

resource "oci_mysql_mysql_backup" "FoggyKitchenMDSCrossRegionBackup" {
    count             = var.mds_cross_region_manual_backup_enabled  && !(var.mds_channel_enabled) ? 1 : 0
    source_details {
        region         = var.mds_cross_region_backup_region
        backup_id      = var.mds_cross_region_manual_backup_ocid
        compartment_id = var.mds_compartment_ocid 
    }
    defined_tags      = var.mds_defined_tags
    description       = var.mds_cross_region_backup_description
    display_name      = var.mds_cross_region_backup_display_name
    freeform_tags     = var.mds_freeform_tags
    retention_in_days = var.mds_backup_retention_in_days
}

