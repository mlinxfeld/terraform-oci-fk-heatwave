resource "oci_mysql_channel" "FoggyKitchenMDSChannel" {
  depends_on     = [null_resource.mysqlsh_source_repl_user_setup_with_bastion]
  count          = var.mds_channel_enabled ? 1 : 0  
  display_name   = var.mds_channel_display_name
  
  source {
    hostname    = var.mds_channel_source_mysql_database_hostname
    source_type = var.mds_channel_source_mysql_database_source_type
    username    = var.mds_channel_source_mysql_database_replication_user_name
    password    = var.mds_channel_source_mysql_database_replication_user_password
    ssl_mode    = var.mds_channel_source_mysql_database_ssl_mode

    anonymous_transactions_handling {
      policy = "ERROR_ON_ANONYMOUS"
    }
  }

  target {
    target_type  = var.mds_channel_target_target_type
    db_system_id = var.mds_channel_target_db_system_id
    channel_name = var.mds_channel_target_channel_name
    delay_in_seconds = var.mds_channel_target_delay_in_seconds
    tables_without_primary_key_handling = var.mds_channel_target_tables_without_primary_key_handling
  }
  freeform_tags = var.mds_freeform_tags
  defined_tags  = var.mds_defined_tags
}

data "template_file" "repl_user_setup" {
  count = var.mds_channel_enabled && var.mds_channel_repl_user_setup_enabled ? 1 : 0    
  template = file("${path.module}/scripts/repl_user_setup.sh.template")

  vars = {
    mysql_hostname   = var.mds_channel_source_mysql_database_hostname
    admin_username   = var.mds_admin_username
    admin_password   = var.mds_admin_password
    ip_address_range = var.mds_channel_source_ip_address_range
    repl_username    = var.mds_channel_source_mysql_database_replication_user_name
    repl_password    = var.mds_channel_source_mysql_database_replication_user_password
  }
}

resource "null_resource" "mysqlsh_source_repl_user_setup_with_bastion" {
  count = var.mds_channel_enabled && var.mds_channel_repl_user_setup_enabled ? 1 : 0  

  provisioner "file" {
    content     = data.template_file.repl_user_setup.rendered
    destination = "/home/${var.mds_channel_bastion_user}/repl_user_setup.sh"

    connection {
      type                = "ssh"
      host                = var.mds_channel_bastion_hostname
      agent               = false
      timeout             = "5m"
      user                = var.mds_channel_bastion_user
      private_key         = var.mds_channel_bastion_private_key
    }
  }

}