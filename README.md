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
  - [Lesson 5: Creating MySQL Database Service with manual backups and WordPress CMS](training/lesson5_mds_manual_backup_with_wordpress): In this lesson, we'll delve into the creation of a **MySQL Database Service** in Oracle Cloud Infrastructure with manual backups using a Terraform module, along with the deployment of **WordPress CMS**. The lesson will focus on configuring a reliable backup strategy to ensure data protection and recovery for your WordPress website. First, we'll create a **local manual backup**, then securely copy this backup to a remote region for **cross-regional backup**. Finally, you'll learn how to provision a new MySQL Database Service instance from the cross-regional backup, ensuring robust disaster recovery and continuity across regions.
  - [Lesson 6: Creating MySQL Database Service with Replication Channel and WordPress CMS](training/lesson6_mds_channel_with_wordpress): In this lesson, we'll delve into the creation of a **MySQL Database Service** in Oracle Cloud Infrastructure with a **Replication Channel** using OCI's MDS Channel feature and a Terraform module, along with deploying WordPress CMS. The focus will be on setting up a cross-regional replication channel that connects the source MySQL Database Service in the first region to the target MDS in the second region. This target MDS was originally created from a cross-regional backup in the previous lesson. By the end of this lesson, you'll learn how to replicate the database across regions, establishing a new production environment and enhancing disaster recovery and business continuity.
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
mds_compartment_ocid | Compartment's OCID where OCI MDS instance will be created.
mds_admin_password |The password for the ADMIN user of the OCI MySQL Database Service (MDS) instance.
mds_admin_username | The username for the ADMIN user of the OCI MySQL Database Service (MDS) instance. By default, this is set to ```mysql```.
mds_availability_domain | The availability domain where the OCI MySQL Database Service (MDS) instance will be deployed.
heatwave_cluster_enabled | A boolean flag indicating whether the HeatWave Cluster is enabled for the OCI MySQL Database Service (MDS) instance, allowing for in-memory query acceleration.
mds_shape | he compute shape of the OCI MySQL Database Service (MDS) instance, determining the resources allocated. Available options include: ```MySQL.Free```, ```MySQL.2```, ```MySQL.4```, ```MySQL.8```, ```MySQL.16```, ```MySQL.32```, ```MySQL.64```, ```MySQL.128```, and ```MySQL.256```.
heatwave_shape | The shape of the HeatWave Cluster for the OCI MySQL Database Service (MDS) instance, specifying the memory allocated for in-memory query acceleration. Available options include: ```HeatWave.Free```, ```HeatWave.32GB```, and ```HeatWave.512GB```.
heatwave_cluster_size | The number of nodes in the **HeatWave Cluster** for the OCI MySQL Database Service (MDS) instance. This value determines the scale and performance of the in-memory query acceleration. By default, the value is set to ```1```.
use_existing_vcn | A boolean flag indicating whether to use an existing Virtual Cloud Network (VCN) for the OCI MySQL Database Service (MDS) instance. If set to true, the existing VCN should be specified and inserted into the module along with the **subnet_id** attribute for the deployment process; otherwise, a new VCN and subnet will be created.
use_public_subnet | A boolean flag used when **use_existing_vcn=false**, indicating whether the module should create a public subnet in addition to the private subnet. The public subnet can be used to deploy a bastion host, which enables access to the private subnet where the OCI MySQL Database Service (MDS) instance will be deployed.
subnet_id | The identifier of the subnet where the OCI MySQL Database Service (MDS) instance will be deployed. If use_existing_vcn=true, this value must be provided to specify the subnet within the existing Virtual Cloud Network (VCN).
mds_backup_policy_is_enabled | A boolean flag indicating whether automated backups are enabled for the OCI MySQL Database Service (MDS) instance. If set to true, backups will be created according to the defined backup policy.
mds_backup_policy_retention_in_days | Specifies the number of days that automated backups for the OCI MySQL Database Service (MDS) instance will be retained. By default, this value is set to 31 days, meaning backups will be kept for 31 days before being automatically deleted.
mds_backup_policy_window_start_time | Specifies the start time for the automated backup window of the OCI MySQL Database Service (MDS) instance. By default, this is set to ```MONDAY 23:00``` (UTC), indicating that backups will start every Monday at 11:00 PM UTC.
mds_data_storage_size_in_gb | Specifies the size of the data storage for the OCI MySQL Database Service (MDS) instance, measured in gigabytes. The value must be an integer between 50 and 131,072 GB.
mds_defined_tags | A map of predefined tags assigned to the OCI MySQL Database Service (MDS) instance. These tags are key-value pairs that can be used to organize and manage resources according to your organization's tagging policies.
mds_description | A brief description of the OCI MySQL Database Service (MDS) instance. This field is used to provide context or additional information about the instance for easier identification and management.
mds_display_name | The user-friendly name for the OCI MySQL Database Service (MDS) instance. This name is used for easy identification of the instance within the Oracle Cloud Infrastructure console and does not have to be unique.
mds_fault_domain | Specifies the fault domain within the availability domain where the OCI MySQL Database Service (MDS) instance will be deployed. Fault domains provide resilience by ensuring that instances are placed in separate physical hardware locations within the same availability domain to mitigate failure risks.
mds_freeform_tags | A collection of simple key-value pairs that can be assigned to the OCI MySQL Database Service (MDS) instance. These tags are user-defined and can be used for flexible resource organization, tracking, and categorization.
mds_hostname_label | The hostname label for the OCI MySQL Database Service (MDS) instance, used to create a unique DNS name for the instance within the VCN. The hostname label must be unique within the VCN and will form part of the FQDN (Fully Qualified Domain Name).
mds_is_highly_available | A boolean flag indicating whether the OCI MySQL Database Service (MDS) instance is configured for high availability. If set to true, the instance will be deployed with redundancy across multiple availability domains or fault domains to ensure resilience and minimize downtime.
mds_maintenance_window_start_time | Specifies the start time for the maintenance window of the OCI MySQL Database Service (MDS) instance. This is the time when scheduled maintenance tasks, such as updates and patches, will begin, typically provided in HH format (UTC).
mds_port | Specifies the port number used for connecting to the OCI MySQL Database Service (MDS) instance. By default, this is set to 3306, which is the standard MySQL port.
mds_port_x | Specifies the X Protocol port number used for connecting to the OCI MySQL Database Service (MDS) instance, enabling support for NoSQL and other protocols. By default, this is set to 33060.
mds_vcn_cidr_block | Specifies the CIDR block for the Virtual Cloud Network (VCN) in which the OCI MySQL Database Service (MDS) instance will be deployed. This is required only if **use_existing_vcn=false**, as the module will create a new VCN. The default value is ```10.0.0.0/16```.
mds_vcn_dns_label | Specifies the DNS label for the Virtual Cloud Network (VCN) in which the OCI MySQL Database Service (MDS) instance will be deployed. This label is used to create a DNS name for the VCN and must be unique within the Oracle Cloud Infrastructure tenancy. The default value is ```mdsvcn```. This is required only if **use_existing_vcn=false**.
mds_vcn_display_name | Specifies the display name for the Virtual Cloud Network (VCN) in which the OCI MySQL Database Service (MDS) instance will be deployed. This is the user-friendly name for easy identification of the VCN in the Oracle Cloud Infrastructure console. This is required only if **use_existing_vcn=false**.
mds_subnet_cidr_block | Specifies the CIDR block for the subnet in which the OCI MySQL Database Service (MDS) instance will be deployed. This defines the IP address range for the subnet and is required only if **use_existing_vcn=false**. The default value is ```10.0.1.0/24```.
mds_subnet_display_name | Specifies the display name for the subnet in which the OCI MySQL Database Service (MDS) instance will be deployed. This is the user-friendly name for easy identification of the subnet in the Oracle Cloud Infrastructure console. This is required only if **use_existing_vcn=false**.
mds_manual_backup_enabled | A boolean flag indicating whether manual backups are enabled for the OCI MySQL Database Service (MDS) instance. If set to true, manual backups can be created and managed by the user. Note that this feature is not available for the ```MySQL.Free``` shape.
mds_backup_backup_type | Specifies the type of backup to be performed for the OCI MySQL Database Service (MDS) instance. The available options are ```FULL``` for a complete backup of the database, or ```INCREMENTAL``` for backing up only the changes since the last backup.
mds_backup_description | A brief description of the backup for the OCI MySQL Database Service (MDS) instance. This field is used to provide context or additional information about the backup, making it easier to identify and manage.
mds_backup_display_name | The user-friendly name for the backup of the OCI MySQL Database Service (MDS) instance. This name helps with easy identification of the backup within the Oracle Cloud Infrastructure console.
mds_backup_retention_in_days | Specifies the number of days that the backup of the OCI MySQL Database Service (MDS) instance will be retained before being automatically deleted. This value determines the lifespan of the backup.
mds_cross_region_manual_backup_enabled | A boolean flag indicating whether manual backups should be copied to another region for cross-regional disaster recovery. This flag is used for independent module invocation in the region where the backup copy should be delivered (copied). If set to true, the module will manage the replication of manual backups to the target region.
mds_cross_region_backup_region | Specifies the source region from which the manual backup of the OCI MySQL Database Service (MDS) instance will be copied for cross-regional disaster recovery. This defines the region where the original backup is created before being copied to a different target region.
mds_cross_region_manual_backup_ocid | Specifies the OCID of the manual backup located in the source region that will be copied to another region for cross-regional disaster recovery. This OCID is necessary to identify the backup in the source region before replication.
mds_cross_region_backup_description | A brief description of the cross-region backup for the OCI MySQL Database Service (MDS) instance. This field is used to provide context or additional information about the backup being replicated to another region, making it easier to identify and manage.
mds_cross_region_backup_display_name | The user-friendly name for the cross-region backup of the OCI MySQL Database Service (MDS) instance. This name helps with easy identification and management of the backup across regions in the Oracle Cloud Infrastructure console.
mds_defined_source_enabled | A boolean flag indicating whether a predefined source configuration is enabled for the OCI MySQL Database Service (MDS) instance. If set to true, the instance will be created based on a predefined source, such as an existing backup or custom configuration.
mds_defined_source_type | Specifies the type of predefined source used for creating the OCI MySQL Database Service (MDS) instance. Available options include: (1) ```BACKUP```: The instance will be created from an existing backup, (2) ```PITR``` The instance will be restored from a Point-in-Time Recovery (PITR), (3) ```IMPORTURL```: The instance will be created by importing data from a specified URL.
mds_defined_source_backup_ocid | Specifies the OCID of the backup used as the source for creating the OCI MySQL Database Service (MDS) instance when the **mds_defined_source_type** is set to ```BACKUP```. This OCID identifies the specific backup from which the new instance will be restored.
mds_defined_source_db_system_ocid | Specifies the OCID of the database system used as the source for creating the OCI MySQL Database Service (MDS) instance. This is required when **mds_defined_source_type** is set to ```PITR``` (Point-in-Time Recovery) and is used to identify the specific database system from which the instance will be restored.
mds_defined_source_db_system_recovery_point | Specifies the exact recovery point in time (in RFC3339 format) for restoring the OCI MySQL Database Service (MDS) instance when using Point-in-Time Recovery (PITR) as the source. This defines the specific moment to which the database will be restored.
mds_defined_source_par_url | Specifies the Pre-Authenticated Request (PAR) URL used as the source for creating the OCI MySQL Database Service (MDS) instance when the **mds_defined_source_type** is set to ```IMPORTURL```. The PAR URL points to the location from which the database data will be imported.
mds_custom_configuration_enabled | A boolean flag indicating whether a custom configuration is enabled for the OCI MySQL Database Service (MDS) instance. If set to true, the instance will be created using a custom configuration that overrides the default settings.
mds_configuration_description | A brief description of the custom configuration applied to the OCI MySQL Database Service (MDS) instance. This description helps provide context for the configuration, making it easier to identify and manage.
mds_configuration_display_name | The user-friendly name for the custom configuration applied to the OCI MySQL Database Service (MDS) instance. This name is used to easily identify and manage the configuration within the Oracle Cloud Infrastructure console.
mds_config_binlog_expire_logs_seconds | A parameter that can be configured when **mds_custom_configuration_enabled=true**. It defines the time, in seconds, after which binary logs will automatically expire and be deleted in the OCI MySQL Database Service (MDS) instance. This helps manage log retention as part of the custom configuration.
mds_channel_enabled | A boolean flag indicating whether replication channels are enabled for the OCI MySQL Database Service (MDS) instance. If set to true, a replication channel will be established, allowing data replication between MDS instances across regions or within the same region.
mds_channel_display_name | The user-friendly name for the replication channel in the OCI MySQL Database Service (MDS) instance. This name is used to easily identify and manage the replication channel within the Oracle Cloud Infrastructure console.
mds_channel_source_mysql_database_hostname | Specifies the hostname or IP address of the source MySQL database for the replication channel in the OCI MySQL Database Service (MDS) instance. This can be a hostname or an IP address that is reachable from the perspective of the target MDS instance, serving as the source for data replication.
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
