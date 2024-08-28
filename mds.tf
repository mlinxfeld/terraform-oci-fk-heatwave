resource "oci_mysql_mysql_db_system" "FoggyKitchenMDS" {
  count               = !var.mds_cross_region_manual_backup_enabled ? 1 : 0
  admin_password      = var.mds_admin_password
  admin_username      = var.mds_admin_username
  availability_domain = var.mds_availability_domain
  compartment_id      = var.mds_compartment_ocid 
  shape_name          = var.heatwave_cluster_enabled ? var.heatwave_shape : var.mds_shape
  subnet_id           = var.subnet_id != "" ? var.subnet_id : var.use_public_subnet ? oci_core_subnet.FoggyKitchenPublicSubnet[0].id : oci_core_subnet.FoggyKitchenPrivateSubnet[0].id

  dynamic "backup_policy" {
    for_each = var.mds_backup_policy_is_enabled && !(var.mds_shape == "MySQL.Free") ? [1] : []
    content {
      is_enabled        = true
      retention_in_days = var.mds_backup_policy_retention_in_days
      window_start_time = var.mds_backup_policy_window_start_time
    }
  }
  dynamic "backup_policy" {
    for_each = var.mds_backup_policy_is_enabled || (var.mds_shape == "MySQL.Free") ? [] : [1]
    content {
      is_enabled = false
    }
  }
  data_storage_size_in_gb = (var.mds_shape == "MySQL.Free") ? 50 : var.mds_data_storage_size_in_gb
  defined_tags            = var.mds_defined_tags
  description             = var.mds_description
  display_name            = var.mds_display_name
  fault_domain            = var.mds_fault_domain
  freeform_tags           = var.mds_freeform_tags
  hostname_label          = var.mds_hostname_label
  is_highly_available     = var.mds_is_highly_available
  maintenance {
    window_start_time = var.mds_maintenance_window_start_time
  }
  port   = var.mds_port
  port_x = var.mds_port_x
}

resource "oci_mysql_mysql_backup" "FoggyKitchenMDSManualBackup" {
    count             = var.mds_manual_backup_enabled && !(var.mds_shape == "MySQL.Free") ? 1 : 0
    db_system_id      = oci_mysql_mysql_db_system.FoggyKitchenMDS[0].id
    backup_type       = var.mds_backup_backup_type
    defined_tags      = var.mds_defined_tags
    description       = var.mds_backup_description
    display_name      = var.mds_backup_display_name
    freeform_tags     = var.mds_freeform_tags
    retention_in_days = var.mds_backup_retention_in_days
}

resource "oci_mysql_mysql_backup" "FoggyKitchenMDSCrossRegionManualBackup" {
    count             = var.mds_cross_region_manual_backup_enabled ? 1 : 0
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