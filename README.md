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
  - [Lesson 6: Creating Highly Available MySQL Database Service with Highly Available WordPress](training/lesson6_ha_mds_with_ha_wordpress): In this lesson, we'll delve into the creation of a **Highly Available MySQL Database Service** in Oracle Cloud Infrastructure using a **Terraform module**, along with deploying a **Highly Available WordPress CMS**, focusing on ensuring both database and application availability with redundancy across multiple availability domains for enhanced fault tolerance and resilience.
  - [Lesson 7: Creating MySQL Database Service with Replication Channel and WordPress CMS](training/lesson7_mds_channel_with_wordpress): In this lesson, we'll delve into the creation of a **MySQL Database Service** in Oracle Cloud Infrastructure with a **Replication Channel** using OCI's **MDS Channel feature** and a **Terraform module**, along with deploying **WordPress CMS**, focusing on replicating the database from one region to another to establish a new production environment, leveraging cross-region replication for enhanced disaster recovery and business continuity.
  - [Lesson 8: Creating MySQL Database Service with Replicas](training/lesson8_mds_with_replicas): In this lesson, we'll delve into the creation of a **MySQL Database Service** in Oracle Cloud Infrastructure with **Replicas** using a **Terraform module**, focusing on setting up read replicas to offload read-heavy workloads, improve performance, and enhance data availability and redundancy across different instances.
  
To deploy MDS using this Module with minimal effort use this:

```hcl
module "fk-mds" {
  source                                = "github.com/mlinxfeld/terraform-oci-fk-heatwave"
  mds_admin_password                    = var.mds_admin_password
  mds_availability_domain               = var.mds_availability_domain
  mds_compartment_ocid                  = var.compartment_ocid
  use_existing_vcn                      = false
}
```

Argument | Description
--- | ---
compartment_ocid | Compartment's OCID where MDS will be created.

## Contributing
This project is open source. Please submit your contributions by forking this repository and submitting a pull request! FoggyKitchen appreciates any contributions that are made by the open source community.

## License
Copyright (c) 2024 [FoggyKitchen.com](https://foggykitchen.com/)

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](LICENSE) for more details.
