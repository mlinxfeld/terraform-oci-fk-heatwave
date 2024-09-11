# terraform-oci-fk-heatwave

These is Terraform module that deploys [HeatWave MySQL Service](https://www.oracle.com/mysql/) on [Oracle Cloud Infrastructure (OCI)](https://cloud.oracle.com/en_US/cloud-infrastructure).

## About
HeatWave is a powerful in-memory query accelerator integrated with MySQL, designed for fast processing of complex analytical workloads without needing to move data between MySQL and separate analytics databases. This module streamlines the creation of MySQL databases with HeatWave clusters, enabling you to leverage the full potential of HeatWave for real-time analytics and transactional processing directly on your MySQL data.

## Prerequisites
1. Download and install Terraform (v1.0 or later)
2. Download and install the OCI Terraform Provider (v4.4.0 or later)
3. Export OCI credentials. (this refer to the https://github.com/oracle/terraform-provider-oci )


## What's a Module?
A Module is a canonical, reusable, best-practices definition for how to run a single piece of infrastructure, such as a database or server cluster. Each Module is created using Terraform, and includes automated tests, examples, and documentation. It is maintained both by the open source community and companies that provide commercial support.
Instead of figuring out the details of how to run a piece of infrastructure from scratch, you can reuse existing code that has been proven in production. And instead of maintaining all that infrastructure code yourself, you can leverage the work of the Module community to pick up infrastructure improvements through a version number bump.

## How to use this Module
Each Module has the following folder structure:
* [root](): This folder contains a root module.
* [training](): This folder contains self-study training how to use the module:
  - [Lesson 1: Creating Free Tier MySQL Database Service](training/lesson1_free_tier_mds): In this lesson, we'll delve into the creation of a **Free Tier MySQL Database Service** in Oracle Cloud Infrastructure using a **Terraform module**, focusing on automating the setup of a fully managed MySQL instance, giving you the foundational skills to efficiently manage your database while leveraging the free tier resources.
  - [Lesson 2: Creating Free Tier MySQL Database Service with public access](training/lesson2_free_tier_mds_with_public_access): In this lesson, we'll delve into the creation of a **Free Tier MySQL Database Service** in Oracle Cloud Infrastructure using a **Terraform module**, where a **bastion host** is deployed in a public subnet and the **MySQL Database Service** is securely placed in a private subnet, enabling controlled public access while leveraging free tier resources.
  - [Lesson 3: Creating Free Tier MySQL Database Service with HeatWave Cluster](training/lesson3_free_tier_mds_with_heatwave_cluster): In this lesson, we'll delve into the creation of a **Free Tier MySQL Database Service** in Oracle Cloud Infrastructure with a **HeatWave Cluster** using a **Terraform module**, focusing on configuring a MySQL instance with in-memory query acceleration to significantly enhance the performance of analytical queries while utilizing free tier resources.
  - [Lesson 4: Creating Free Tier MySQL Database Service with WordPress CMS](training/lesson4_free_tier_mds_with_wordpress): In this lesson, we'll delve into the creation of a **Free Tier MySQL Database Service** in Oracle Cloud Infrastructure, combined with the deployment of **WordPress CMS** using a **Terraform module**, focusing on setting up a scalable MySQL instance to power a WordPress website while utilizing free tier resources.
  - [Lesson 5: Creating MySQL Database Service with manual backups and WordPress CMS](training/lesson5_mds_manual_backup_with_wordpress): In this lesson, we'll delve into the creation of a **MySQL Database Service** in Oracle Cloud Infrastructure with **manual backups** using a **Terraform module**, along with the deployment of **WordPress CMS**, focusing on configuring a reliable backup strategy to ensure data protection and recovery for your WordPress website, with local backups being securely copied to a remote site for **cross-regional backup**.
  - [Lesson 6: Creating MySQL Database Service with Replication Channel and WordPress CMS](training/lesson6_mds_channel_with_wordpress): In this lesson, we'll delve into the creation of a **MySQL Database Service** in Oracle Cloud Infrastructure with a **Replication Channel** using OCI's **MDS Channel feature** and a **Terraform module**, along with deploying **WordPress CMS**, focusing on replicating the database from one region to another to establish a new production environment, leveraging cross-region replication for enhanced disaster recovery and business continuity.
  - [Lesson 7: Creating Highly Available MySQL Database Service with Highly Available WordPress CMS](training/lesson7_ha_mds_with_ha_wordpress): In this lesson, we'll delve into the creation of a **Highly Available MySQL Database Service** in Oracle Cloud Infrastructure using a **Terraform module**, along with deploying a **Highly Available WordPress CMS**, focusing on ensuring both database and application availability with redundancy across multiple availability domains for enhanced fault tolerance and resilience.
  - [Lesson 8: Creating MySQL Database Service with Replicas](training/lesson8_mds_with_replicas): In this lesson, we'll delve into the creation of a **MySQL Database Service** in Oracle Cloud Infrastructure with **Replicas** using a **Terraform module**, focusing on setting up read replicas to offload read-heavy workloads, improve performance, and enhance data availability and redundancy across different instances.
  
To deploy MDS using this Module with minimal effort use this:

```hcl
module "fk-mds" {
  source                                = "github.com/mlinxfeld/terraform-oci-fk-heatwave"
  mds_admin_password                    = var.admin_password
  mds_availability_domain               = var.availability_domain
  mds_compartment_ocid                  = var.compartment_ocid
  use_existing_vcn                      = false
}
```

Argument | Description
--- | ---
mds_compartment_ocid | Compartment's OCID where MDS will be created.
mds_admin_password |
variable "mds_admin_username | 
mds_availability_domain |
heatwave_cluster_enabled |
mds_shape | MySQL.Free, MySQL.2, MySQL.4, MySQL.8, MySQL.16, MySQL.32, MySQL.64, MySQL.128 , MySQL.256
heatwave_shape | HeatWave.Free, HeatWave.32GB, HeatWave.512GB
heatwave_cluster_size |
use_existing_vcn |
use_public_subnet |
subnet_id |
mds_backup_policy_is_enabled |
mds_backup_policy_retention_in_days |
mds_backup_policy_window_start_time |
mds_data_storage_size_in_gb | Must be an integer between 50 and 131,072.
mds_defined_tags |
mds_description |
mds_display_name |
mds_fault_domain |
mds_freeform_tags |
mds_hostname_label |
mds_is_highly_available |
mds_maintenance_window_start_time |
mds_port | By default 3306
mds_port_x | By default 33060
mds_vcn_cidr_block |
mds_vcn_dns_label |
mds_vcn_display_name |
mds_subnet_cidr_block |
mds_subnet_display_name |
mds_manual_backup_enabled |
mds_backup_backup_type | FULL or INCREMENTAL
mds_backup_description |
mds_backup_display_name |
mds_backup_retention_in_days |
mds_cross_region_manual_backup_enabled |
mds_cross_region_backup_region |
mds_cross_region_manual_backup_ocid |
mds_cross_region_backup_description |
mds_cross_region_backup_display_name |
mds_defined_source_enabled |
mds_defined_source_type | BACKUP vs PITR vs IMPORTURL 
mds_defined_source_backup_ocid |
mds_defined_source_db_system_ocid |
mds_defined_source_db_system_recovery_point |
mds_defined_source_par_url |
mds_custom_configuration_enabled |
mds_configuration_description |
mds_configuration_display_name |
mds_config_binlog_expire_logs_seconds |
mds_channel_enabled |
mds_channel_display_name |
mds_channel_source_mysql_database_hostname |
mds_channel_source_mysql_database_replication_user_name |
mds_channel_source_mysql_database_source_type |
mds_channel_source_mysql_database_ssl_mode |
mds_channel_source_mysql_database_replication_user_password |
mds_channel_target_target_type |
mds_channel_target_db_system_id |
mds_channel_target_channel_name" |
mds_channel_target_delay_in_seconds |
mds_channel_target_tables_without_primary_key_handling
mds_channel_repl_user_setup_enabled |
mds_channel_bastion_user |
mds_channel_bastion_hostname |
mds_channel_bastion_private_key |
mds_channel_source_ip_address_range |
mds_replica_enabled |
mds_replica_source_db_system_id |
mds_replica_description |
mds_replica_display_name |
mds_replica_is_delete_protected |
mds_replica_overrides |
mds_replica_overrides_configuration_id |
mds_replica_overrides_mysql_version
mds_replica_overrides_shape | MySQL.2, MySQL.4, MySQL.8, MySQL.16, MySQL.32, MySQL.64, MySQL.128 , MySQL.256

## Contributing
This project is open source. Please submit your contributions by forking this repository and submitting a pull request! [FoggyKitchen.com](https://foggykitchen.com/) appreciates any contributions that are made by the open source community.

## License
Copyright (c) 2024 [FoggyKitchen.com](https://foggykitchen.com/)

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](LICENSE) for more details.
