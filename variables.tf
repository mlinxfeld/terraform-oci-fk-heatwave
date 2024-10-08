variable "mds_admin_password" {
  default = ""
}
variable "mds_admin_username" {
  default = "mysql"
}
variable "mds_availability_domain" {
  default = ""
}
variable "mds_compartment_ocid" {}
variable "heatwave_cluster_enabled" {
  default = false
}
variable "mds_shape" {
  default = "MySQL.Free" # MySQL.Free, MySQL.2, MySQL.4, MySQL.8, MySQL.16, MySQL.32, MySQL.64, MySQL.128 , MySQL.256
}
variable "heatwave_shape" {
  default = "HeatWave.Free" # HeatWave.Free, HeatWave.32GB, HeatWave.512GB
}
variable "heatwave_cluster_size" {
  default = 1
}
variable "use_existing_vcn" {
  default = false
}
variable "use_public_subnet" {
  default = false
}
variable "subnet_id" {
  default = ""
}
variable "mds_backup_policy_is_enabled" {
  default = false
}
variable "mds_backup_policy_retention_in_days" {
  default = 31
}
variable "mds_backup_policy_window_start_time" {
  default = "MONDAY 23:00"
}
variable "mds_data_storage_size_in_gb" {
  default = 1024 # Must be an integer between 50 and 131,072.
}
variable "mds_defined_tags" {
  default = {}
  
}
variable "mds_description" {
  default = "FoggyKitchen MDS/Heatwave instance"
}
variable "mds_display_name" {
  default = "FoggyKitchen MDS/Heatwave"
  
}
variable "mds_fault_domain" {
  default = ""
}
variable "mds_freeform_tags" {
  default = {}
}
variable "mds_hostname_label" {
  default = "fkmds"
}
variable "mds_is_highly_available" {
  default = false
}
variable "mds_maintenance_window_start_time" {
  default = "MONDAY 23:59"
}

variable "mds_port" {
  default = 3306
}
variable "mds_port_x" {
  default = 33060
}

variable "mds_vcn_cidr_block" {
  default = "10.0.0.0/16"  
}
variable "mds_vcn_dns_label" {
  default = "mdsvcn" 
}

variable "mds_vcn_display_name" {
  default = "FoggyKitchenMDSVCN"
}

variable "mds_subnet_cidr_block" {
  default = "10.0.1.0/24" 
}

variable "mds_subnet_display_name" {
  default = "FoggyKitchenMDSSubnet"
}

variable "mds_manual_backup_enabled" {
  default = false
}

variable "mds_backup_backup_type" {
  default = "FULL" # FULL or INCREMENTAL
}

variable "mds_backup_description" {
  default = "FoggyKitchen MDS Manual Backup"
}

variable "mds_backup_display_name" {
  default = "FoggyKitchenMDSManualBackup" 
}

variable "mds_backup_retention_in_days" {
  default = 31
}

variable "mds_cross_region_manual_backup_enabled" {
  default = false
}

variable "mds_cross_region_backup_region" {
  default = ""
}

variable "mds_cross_region_manual_backup_ocid" {
  default = ""
}

variable "mds_cross_region_backup_description" {
  default = "FoggyKitchen MDS Cross-Region Backup"
}

variable "mds_cross_region_backup_display_name" {
  default = "FoggyKitchenMDSCrossRegionBackup" 
}

variable "mds_defined_source_enabled" {
  default = false
}

variable "mds_defined_source_type" {
  default = "" # BACKUP vs PITR vs IMPORTURL 
}

variable "mds_defined_source_backup_ocid" {
  default = ""
}

variable "mds_defined_source_db_system_ocid" {
  default = ""
}

variable "mds_defined_source_db_system_recovery_point" {
  default = ""
}

variable "mds_defined_source_par_url" {
  default = "" 
}

variable "mds_custom_configuration_enabled" {
  default = false
}
variable "mds_configuration_description" {
  default = "FoggyKitchen MDS Custom Configuration"
}

variable "mds_configuration_display_name" {
  default = "FoggyKitchenMDSCustomConfiguration"
}

variable "mds_config_binlog_expire_logs_seconds" {
  default = "3600" # 60 minutes o binlogs.
}

variable "mds_channel_enabled" {
  default = false
}

variable "mds_channel_display_name" {
  default = "FoggyKitchenMDSChannel"
}

variable "mds_channel_source_mysql_database_hostname" {
  default = ""
}

variable "mds_channel_source_mysql_database_replication_user_name" {
  default = "repl_user"
}

variable "mds_channel_source_mysql_database_source_type" {
  default = "MYSQL"
}

variable "mds_channel_source_mysql_database_ssl_mode" {
  default = "REQUIRED" 
}

variable "mds_channel_source_mysql_database_replication_user_password" {
  default = ""
}

variable "mds_channel_target_target_type" {
  default = "DBSYSTEM"
}

variable "mds_channel_target_db_system_id" {
  default = ""
}

variable "mds_channel_target_channel_name" {
  default = "MySQLMDSChannel"
}

variable "mds_channel_target_delay_in_seconds" {
  default = 60
}

variable "mds_channel_target_tables_without_primary_key_handling" {
  default = "GENERATE_IMPLICIT_PRIMARY_KEY"
}

variable "mds_channel_repl_user_setup_enabled" {
  default = false
}

variable "mds_channel_bastion_user" {
  default = "opc"
}

variable "mds_channel_bastion_hostname" {
  default = ""
}

variable "mds_channel_bastion_private_key" {
  default = ""
}

variable "mds_channel_source_ip_address_range" {
  default = "10.0.2.%"
}

variable "mds_replica_enabled" {
  default = false
}

variable "mds_replica_source_db_system_id" {
  default = ""
}

variable "mds_replica_description" {
  default = "FoggyKitchen MDS Replica"
}

variable "mds_replica_display_name" {
  default = "FoggyKitchenMDSReplica"
}

variable "mds_replica_is_delete_protected" {
  default = false
}

variable "mds_replica_overrides" {
  default = false
}

variable "mds_replica_overrides_configuration_id" {
  default = ""
}

variable "replica_replica_overrides_mysql_version" {
  default = ""  
}

variable "mds_replica_overrides_shape" {
  default = "MySQL.4" # MySQL.2, MySQL.4, MySQL.8, MySQL.16, MySQL.32, MySQL.64, MySQL.128 , MySQL.256
}