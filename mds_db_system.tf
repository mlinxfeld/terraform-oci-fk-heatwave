resource "oci_mysql_mysql_db_system" "FoggyKitchenMDS" {
  count               = !var.mds_cross_region_manual_backup_enabled && !(var.mds_channel_enabled) && !(var.mds_channel_repl_user_setup_enabled) && !(var.mds_replica_enabled) ? 1 : 0
  admin_password      = var.mds_admin_password
  admin_username      = var.mds_admin_username
  availability_domain = var.mds_availability_domain
  compartment_id      = var.mds_compartment_ocid 
  shape_name          = var.heatwave_cluster_enabled ? var.heatwave_shape : var.mds_shape
  subnet_id           = var.subnet_id != "" ? var.subnet_id : var.use_public_subnet ? oci_core_subnet.FoggyKitchenPublicSubnet[0].id : oci_core_subnet.FoggyKitchenPrivateSubnet[0].id
  configuration_id    = var.mds_custom_configuration_enabled && !(var.mds_shape == "MySQL.Free") ? oci_mysql_mysql_configuration.FoggyKitchenMDSConfiguration[0].id : null

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

  dynamic "source" {
    for_each = var.mds_defined_source_enabled && var.mds_defined_source_type == "BACKUP" ? [1] : []
    content {
      source_type    = var.mds_defined_source_type
      backup_id      = var.mds_defined_source_type == "BACKUP" ? var.mds_defined_source_backup_ocid : null
      db_system_id   = var.mds_defined_source_type == "PITR" ? var.mds_defined_source_db_system_ocid : null
      recovery_point = var.mds_defined_source_type == "PITR" ? var.mds_defined_source_db_system_recovery_point : null
      source_url     = var.mds_defined_source_type == "IMPORTURL" ? var.mds_defined_source_par_url : null
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

