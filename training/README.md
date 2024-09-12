# FoggyKitchen MySQL HeatWave Database Service with Terraform 

## Course description

This comprehensive course focuses on deploying and managing MySQL HeatWave Database Service (MDS) instances on Oracle Cloud Infrastructure (OCI) using Terraform, an industry-standard infrastructure as code (IaC) tool. Each lesson provides in-depth, hands-on practice with Terraform, enabling participants to automate the creation and management of MySQL instances while leveraging OCI's Free Tier and advanced features. The lessons cover topics such as public access, HeatWave clusters, WordPress integration, backups, replication, and high availability.

By the end of the course, participants will have the skills to deploy, manage, and scale MySQL HeatWave Database Service instances on OCI, ensuring optimal performance, reliability, and availability for a range of applications.

[Lesson 1: Creating Free Tier MySQL Database Service](training/lesson1_free_tier_mds) 
 
In this lesson, we'll delve into the creation of a **Free Tier MySQL Database Service** in Oracle Cloud Infrastructure using a **Terraform module**, focusing on automating the setup of a fully managed MySQL instance, giving you the foundational skills to efficiently manage your database while leveraging the free tier resources.

[Lesson 2: Creating Free Tier MySQL Database Service with public access](training/lesson2_free_tier_mds_with_public_access)

In this lesson, we'll delve into the creation of a **Free Tier MySQL Database Service** in Oracle Cloud Infrastructure using a **Terraform module**, where a **bastion host** is deployed in a public subnet and the **MySQL Database Service** is securely placed in a private subnet, enabling controlled public access while leveraging free tier resources.

[Lesson 3: Creating Free Tier MySQL Database Service with HeatWave Cluster](training/lesson3_free_tier_mds_with_heatwave_cluster)

In this lesson, we'll delve into the creation of a **Free Tier MySQL Database Service** in Oracle Cloud Infrastructure with a **HeatWave Cluster** using a **Terraform module**, focusing on configuring a MySQL instance with in-memory query acceleration to significantly enhance the performance of analytical queries while utilizing free tier resources.

[Lesson 4: Creating Free Tier MySQL Database Service with WordPress CMS](training/lesson4_free_tier_mds_with_wordpress)

In this lesson, we'll delve into the creation of a **Free Tier MySQL Database Service** in Oracle Cloud Infrastructure, combined with the deployment of **WordPress CMS** using a **Terraform module**, focusing on setting up a scalable MySQL instance to power a WordPress website while utilizing free tier resources.

[Lesson 5: Creating MySQL Database Service with manual backups and WordPress CMS](training/lesson5_mds_manual_backup_with_wordpress)

In this lesson, we'll delve into the creation of a **MySQL Database Service** in Oracle Cloud Infrastructure with manual backups using a Terraform module, along with the deployment of **WordPress CMS**. The lesson will focus on configuring a reliable backup strategy to ensure data protection and recovery for your WordPress website. First, we'll create a **local manual backup**, then securely copy this backup to a remote region for **cross-regional backup**. Finally, you'll learn how to provision a new MySQL Database Service instance from the cross-regional backup, ensuring robust disaster recovery and continuity across regions.

[Lesson 6: Creating MySQL Database Service with Replication Channel and WordPress CMS](training/lesson6_mds_channel_with_wordpress) 

In this lesson, we'll delve into the creation of a **MySQL Database Service** in Oracle Cloud Infrastructure with a **Replication Channel** using OCI's MDS Channel feature and a Terraform module, along with deploying WordPress CMS. The focus will be on setting up a cross-regional replication channel that connects the source MySQL Database Service in the first region to the target MDS in the second region. This target MDS was originally created from a cross-regional backup in the previous lesson. By the end of this lesson, you'll learn how to replicate the database across regions, establishing a new production environment and enhancing disaster recovery and business continuity.

[Lesson 7: Creating Highly Available MySQL Database Service with Highly Available WordPress CMS](training/lesson7_ha_mds_with_ha_wordpress): 

In this lesson, we'll delve into the creation of a **Highly Available MySQL Database Service** in Oracle Cloud Infrastructure using a **Terraform module**, along with deploying a **Highly Available WordPress CMS**, focusing on ensuring both database and application availability with redundancy across multiple availability domains for enhanced fault tolerance and resilience.

[Lesson 8: Creating MySQL Database Service with Replicas](training/lesson8_mds_with_replicas) 

In this lesson, we'll delve into the creation of a **MySQL Database Service** in Oracle Cloud Infrastructure with **Replicas** using a **Terraform module**, focusing on setting up read replicas to offload read-heavy workloads, improve performance, and enhance data availability and redundancy across different instances.

## Copyright
Copyright (c) 2024 [FoggyKitchen.com](https://foggykitchen.com/)
  