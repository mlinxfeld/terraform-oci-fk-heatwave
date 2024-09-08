
# FoggyKitchen OCI MySQL Heatwave with Terraform 

## LESSON 1 - Creating Free Tier MySQL Database Service

In this lesson, we'll delve into the creation of a **Free Tier MySQL Database Service** in Oracle Cloud Infrastructure using a **Terraform module**, focusing on automating the setup of a fully managed MySQL instance, giving you the foundational skills to efficiently manage your database while leveraging the free tier resources.

![](lesson1_free_tier_mds.png)

## Deploy Using Oracle Resource Manager

1. Click [![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?region=home&zipUrl=https://github.com/mlinxfeld/terraform-oci-fk-heatwave/releases/latest/download/terraform-oci-fk-heatwave-lesson1.zip)

    If you aren't already signed in, when prompted, enter the tenancy and user credentials.

2. Review and accept the terms and conditions.

3. Select the region where you want to deploy the stack.

4. Follow the on-screen prompts and instructions to create the stack.

5. After creating the stack, click **Terraform Actions**, and select **Plan**.

6. Wait for the job to be completed, and review the plan.

    To make any changes, return to the Stack Details page, click **Edit Stack**, and make the required changes. Then, run the **Plan** action again.

7. If no further changes are necessary, return to the Stack Details page, click **Terraform Actions**, and select **Apply**. 

## Deploy Using the Terraform CLI 

### Clone of the repo 

Now, you'll want a local copy of this repo. You can make that with the commands:
Clone the repo from github by executing the command as follows and then go to proper subdirectory:

```
mlinxfeld@Martins-MacBook-Pro github % git clone https://github.com/mlinxfeld/terraform-oci-fk-heatwave.git

mlinxfeld@Martins-MacBook-Pro github % cd terraform-oci-fk-heatwave

mlinxfeld@Martins-MacBook-Pro terraform-oci-fk-heatwave % cd training/lesson1_free_tier_mds/
```

### Prerequisites
Create environment file with terraform.tfvars file starting with example file:

```
mlinxfeld@Martins-MacBook-Pro lesson1_free_tier_mds % cp terraform.tfvars.example terraform.tfvars

mlinxfeld@Martins-MacBook-Pro lesson1_free_tier_mds % vi terraform.tfvars

tenancy_ocid            = "ocid1.tenancy.oc1..<your_tenancy_ocid>"
compartment_ocid        = "ocid1.compartment.oc1..<your_comparment_ocid>"
fingerprint             = "<fingerprint>"
private_key_path        = "<private_key_path>"
region                  = "<region>"
mds_availability_domain = "<ad_name>"
mds_compartment_ocid    = "<compartment_ocid>"
mds_admin_password      = "<admin_password>"
```

### Initialize Terraform

Run the following command to initialize Terraform environment:

```
mlinxfeld@Martins-MacBook-Pro lesson1_free_tier_mds % terraform init
Initializing the backend...
Initializing modules...
Downloading git::https://github.com/mlinxfeld/terraform-oci-fk-heatwave.git for oci-fk-free-mds...
- oci-fk-free-mds in .terraform/modules/oci-fk-free-mds
Initializing provider plugins...
- Finding latest version of oracle/oci...
- Finding latest version of hashicorp/null...
- Finding latest version of hashicorp/template...
- Finding latest version of hashicorp/oci...
- Installing hashicorp/oci v6.9.0...
- Installed hashicorp/oci v6.9.0 (signed by HashiCorp)
- Installing oracle/oci v6.9.0...
- Installed oracle/oci v6.9.0 (signed by a HashiCorp partner, key ID 1533A49284137CEB)
- Installing hashicorp/null v3.2.2...
- Installed hashicorp/null v3.2.2 (signed by HashiCorp)
- Installing hashicorp/template v2.2.0...
- Installed hashicorp/template v2.2.0 (signed by HashiCorp)
Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

### Apply the changes 

Run the following command for applying changes with the proposed plan:

```
mlinxfeld@Martins-MacBook-Pro lesson1_free_tier_mds % terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.oci-fk-free-mds.oci_core_default_security_list.FoggyKitchenDefaultSecurityList[0] will be created
  + resource "oci_core_default_security_list" "FoggyKitchenDefaultSecurityList" {
      + compartment_id             = (known after apply)
      + defined_tags               = (known after apply)
      + display_name               = (known after apply)
      + freeform_tags              = (known after apply)
      + id                         = (known after apply)
      + manage_default_resource_id = (known after apply)
      + state                      = (known after apply)
      + time_created               = (known after apply)

      + egress_security_rules {
          + description      = (known after apply)
          + destination      = "0.0.0.0/0"
          + destination_type = (known after apply)
          + protocol         = "all"
          + stateless        = (known after apply)
        }
    }

  # module.oci-fk-free-mds.oci_core_nat_gateway.FoggyKitchenNATGateway[0] will be created
  + resource "oci_core_nat_gateway" "FoggyKitchenNATGateway" {
      + block_traffic  = (known after apply)
      + compartment_id = "ocid1.compartment.oc1..aaaaaaaaiyy4srmrb32v5rlniicwmpxsytywiucgbcp5ext6e4ahjfuloewa"
      + defined_tags   = (known after apply)
      + display_name   = "FoggyKitchenNATGateway"
      + freeform_tags  = (known after apply)
      + id             = (known after apply)
      + nat_ip         = (known after apply)
      + public_ip_id   = (known after apply)
      + route_table_id = (known after apply)
      + state          = (known after apply)
      + time_created   = (known after apply)
      + vcn_id         = (known after apply)
    }

  # module.oci-fk-free-mds.oci_core_route_table.FoggyKitchenPrivateRouteTable[0] will be created
  + resource "oci_core_route_table" "FoggyKitchenPrivateRouteTable" {
      + compartment_id = "ocid1.compartment.oc1..aaaaaaaaiyy4srmrb32v5rlniicwmpxsytywiucgbcp5ext6e4ahjfuloewa"
      + defined_tags   = (known after apply)
      + display_name   = "FoggyKitchenPrivateRouteTable"
      + freeform_tags  = (known after apply)
      + id             = (known after apply)
      + state          = (known after apply)
      + time_created   = (known after apply)
      + vcn_id         = (known after apply)

      + route_rules {
          + cidr_block        = (known after apply)
          + description       = (known after apply)
          + destination       = "0.0.0.0/0"
          + destination_type  = "CIDR_BLOCK"
          + network_entity_id = (known after apply)
          + route_type        = (known after apply)
        }
    }

  # module.oci-fk-free-mds.oci_core_route_table_attachment.FoggyKitchenPrivateSubnetRouteTableAttachment[0] will be created
  + resource "oci_core_route_table_attachment" "FoggyKitchenPrivateSubnetRouteTableAttachment" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.oci-fk-free-mds.oci_core_security_list.FoggyKitchenMDSSecurityList[0] will be created
  + resource "oci_core_security_list" "FoggyKitchenMDSSecurityList" {
      + compartment_id = "ocid1.compartment.oc1..aaaaaaaaiyy4srmrb32v5rlniicwmpxsytywiucgbcp5ext6e4ahjfuloewa"
      + defined_tags   = (known after apply)
      + display_name   = "FoggyKitchenMDSSecurityList"
      + freeform_tags  = (known after apply)
      + id             = (known after apply)
      + state          = (known after apply)
      + time_created   = (known after apply)
      + vcn_id         = (known after apply)

      + egress_security_rules {
          + description      = (known after apply)
          + destination      = "0.0.0.0/0"
          + destination_type = (known after apply)
          + protocol         = "all"
          + stateless        = (known after apply)
        }

      + ingress_security_rules {
          + description = (known after apply)
          + protocol    = "6"
          + source      = "0.0.0.0/0"
          + source_type = "CIDR_BLOCK"
          + stateless   = false

          + tcp_options {
              + max = 33060
              + min = 33060
            }
        }
      + ingress_security_rules {
          + description = (known after apply)
          + protocol    = "6"
          + source      = "0.0.0.0/0"
          + source_type = "CIDR_BLOCK"
          + stateless   = false

          + tcp_options {
              + max = 3306
              + min = 3306
            }
        }
    }

  # module.oci-fk-free-mds.oci_core_subnet.FoggyKitchenPrivateSubnet[0] will be created
  + resource "oci_core_subnet" "FoggyKitchenPrivateSubnet" {
      + availability_domain        = (known after apply)
      + cidr_block                 = "10.0.1.0/24"
      + compartment_id             = "ocid1.compartment.oc1..aaaaaaaaiyy4srmrb32v5rlniicwmpxsytywiucgbcp5ext6e4ahjfuloewa"
      + defined_tags               = (known after apply)
      + dhcp_options_id            = (known after apply)
      + display_name               = "FoggyKitchenMDSSubnet"
      + dns_label                  = (known after apply)
      + freeform_tags              = (known after apply)
      + id                         = (known after apply)
      + ipv6cidr_block             = (known after apply)
      + ipv6cidr_blocks            = (known after apply)
      + ipv6virtual_router_ip      = (known after apply)
      + prohibit_internet_ingress  = (known after apply)
      + prohibit_public_ip_on_vnic = true
      + route_table_id             = (known after apply)
      + security_list_ids          = (known after apply)
      + state                      = (known after apply)
      + subnet_domain_name         = (known after apply)
      + time_created               = (known after apply)
      + vcn_id                     = (known after apply)
      + virtual_router_ip          = (known after apply)
      + virtual_router_mac         = (known after apply)
    }

  # module.oci-fk-free-mds.oci_core_vcn.FoggyKitchenVCN[0] will be created
  + resource "oci_core_vcn" "FoggyKitchenVCN" {
      + byoipv6cidr_blocks               = (known after apply)
      + cidr_block                       = "10.0.0.0/16"
      + cidr_blocks                      = (known after apply)
      + compartment_id                   = "ocid1.compartment.oc1..aaaaaaaaiyy4srmrb32v5rlniicwmpxsytywiucgbcp5ext6e4ahjfuloewa"
      + default_dhcp_options_id          = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_list_id         = (known after apply)
      + defined_tags                     = (known after apply)
      + display_name                     = "FoggyKitchenMDSVCN"
      + dns_label                        = "mdsvcn"
      + freeform_tags                    = (known after apply)
      + id                               = (known after apply)
      + ipv6cidr_blocks                  = (known after apply)
      + ipv6private_cidr_blocks          = (known after apply)
      + is_ipv6enabled                   = (known after apply)
      + is_oracle_gua_allocation_enabled = (known after apply)
      + state                            = (known after apply)
      + time_created                     = (known after apply)
      + vcn_domain_name                  = (known after apply)

      + byoipv6cidr_details (known after apply)
    }

  # module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0] will be created
  + resource "oci_mysql_mysql_db_system" "FoggyKitchenMDS" {
      + admin_password                 = (sensitive value)
      + admin_username                 = "mysql"
      + availability_domain            = "unja:EU-FRANKFURT-1-AD-3"
      + channels                       = (known after apply)
      + compartment_id                 = "ocid1.compartment.oc1..aaaaaaaaiyy4srmrb32v5rlniicwmpxsytywiucgbcp5ext6e4ahjfuloewa"
      + configuration_id               = (known after apply)
      + crash_recovery                 = (known after apply)
      + current_placement              = (known after apply)
      + data_storage_size_in_gb        = 50
      + database_management            = (known after apply)
      + defined_tags                   = (known after apply)
      + description                    = "FoggyKitchen Free Tier MySQL/Heatwave Database System"
      + display_name                   = "FoggyKitchenFreeTierMDS"
      + endpoints                      = (known after apply)
      + fault_domain                   = (known after apply)
      + freeform_tags                  = (known after apply)
      + heat_wave_cluster              = (known after apply)
      + hostname_label                 = "fkmds"
      + id                             = (known after apply)
      + ip_address                     = (known after apply)
      + is_heat_wave_cluster_attached  = (known after apply)
      + is_highly_available            = false
      + lifecycle_details              = (known after apply)
      + mysql_version                  = (known after apply)
      + point_in_time_recovery_details = (known after apply)
      + port                           = 3306
      + port_x                         = 33060
      + shape_name                     = "MySQL.Free"
      + state                          = (known after apply)
      + subnet_id                      = (known after apply)
      + time_created                   = (known after apply)
      + time_updated                   = (known after apply)

      + backup_policy (known after apply)

      + customer_contacts (known after apply)

      + data_storage (known after apply)

      + deletion_policy (known after apply)

      + maintenance {
          + window_start_time = "MONDAY 23:59"
        }

      + secure_connections (known after apply)

      + source (known after apply)
    }

Plan: 8 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + mds_database = {
      + mds_id         = (known after apply)
      + mds_ip_address = (known after apply)
      + mds_port       = (known after apply)
      + mds_port_x     = (known after apply)
    }

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.oci-fk-free-mds.oci_core_vcn.FoggyKitchenVCN[0]: Creating...
module.oci-fk-free-mds.oci_core_vcn.FoggyKitchenVCN[0]: Creation complete after 1s [id=ocid1.vcn.oc1.eu-frankfurt-1.amaaaaaadngk4giavslf42qx3wjh6ozjcrgb4unnrwhejpllb2fx3mayasfq]
module.oci-fk-free-mds.oci_core_nat_gateway.FoggyKitchenNATGateway[0]: Creating...
module.oci-fk-free-mds.oci_core_default_security_list.FoggyKitchenDefaultSecurityList[0]: Creating...
module.oci-fk-free-mds.oci_core_security_list.FoggyKitchenMDSSecurityList[0]: Creating...
module.oci-fk-free-mds.oci_core_default_security_list.FoggyKitchenDefaultSecurityList[0]: Creation complete after 0s [id=ocid1.securitylist.oc1.eu-frankfurt-1.aaaaaaaalrwioixeq7gvr4kjk5yyal55eyf3uhxinw7nvz37ehw3zlmsajmq]
module.oci-fk-free-mds.oci_core_security_list.FoggyKitchenMDSSecurityList[0]: Creation complete after 0s [id=ocid1.securitylist.oc1.eu-frankfurt-1.aaaaaaaajlznl6pvldu3637ievrwjceyedpesmeckaao6nicnhgfgp4ohsaq]
module.oci-fk-free-mds.oci_core_subnet.FoggyKitchenPrivateSubnet[0]: Creating...
module.oci-fk-free-mds.oci_core_nat_gateway.FoggyKitchenNATGateway[0]: Creation complete after 1s [id=ocid1.natgateway.oc1.eu-frankfurt-1.aaaaaaaamgfy4oy3ez6tzq2kn3hj5lgljxqxzlmrmhchd6jak2qcjwn54p5a]
module.oci-fk-free-mds.oci_core_route_table.FoggyKitchenPrivateRouteTable[0]: Creating...
module.oci-fk-free-mds.oci_core_route_table.FoggyKitchenPrivateRouteTable[0]: Creation complete after 0s [id=ocid1.routetable.oc1.eu-frankfurt-1.aaaaaaaapjfmyqvsknzcmcbmsshon3zqmtxl2kftio6ygomptqal64id3xaq]
module.oci-fk-free-mds.oci_core_subnet.FoggyKitchenPrivateSubnet[0]: Creation complete after 1s [id=ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaar4g4wjz5znzxwcyjsf376ipx2t2xvt57dyojz5k7w5dq2yvjgf3a]
module.oci-fk-free-mds.oci_core_route_table_attachment.FoggyKitchenPrivateSubnetRouteTableAttachment[0]: Creating...
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Creating...
module.oci-fk-free-mds.oci_core_route_table_attachment.FoggyKitchenPrivateSubnetRouteTableAttachment[0]: Creation complete after 1s [id=ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaar4g4wjz5znzxwcyjsf376ipx2t2xvt57dyojz5k7w5dq2yvjgf3a/ocid1.routetable.oc1.eu-frankfurt-1.aaaaaaaapjfmyqvsknzcmcbmsshon3zqmtxl2kftio6ygomptqal64id3xaq]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [10s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [20s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [30s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [40s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [50s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [1m0s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [1m10s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [1m20s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [1m30s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [1m40s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [1m50s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [2m0s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [2m10s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [2m20s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [2m30s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [2m40s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [2m50s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [3m0s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [3m10s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [3m20s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [3m30s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [3m40s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [3m50s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [4m0s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [4m10s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [4m20s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [4m30s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [4m40s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [4m50s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [5m0s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [5m10s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [5m20s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [5m30s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [5m40s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [5m50s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [6m0s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [6m10s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [6m20s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [6m30s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [6m40s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [6m50s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [7m0s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [7m10s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [7m20s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [7m30s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [7m40s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [7m50s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [8m0s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [8m10s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [8m20s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [8m30s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [8m40s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [8m50s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [9m0s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [9m10s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [9m20s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [9m30s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [9m40s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [9m50s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [10m0s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [10m10s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [10m20s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [10m30s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [10m40s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [10m50s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [11m1s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [11m11s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [11m21s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still creating... [11m31s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Creation complete after 11m40s [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1.aaaaaaaansbyq3sfibkcr5wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq]

Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

Outputs:

mds_database = {
  "mds_id" = "ocid1.mysqldbsystem.oc1.eu-frankfurt-1.aaaaaaaansbyq3sfibkcr5wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq"
  "mds_ip_address" = "10.0.1.121"
  "mds_port" = "3306"
  "mds_port_x" = "33060"
}
```

### Destroy the changes 

Run the following command for destroying all resources:

```
mlinxfeld@Martins-MacBook-Pro lesson1_free_tier_mds % terraform destroy
module.oci-fk-free-mds.oci_core_vcn.FoggyKitchenVCN[0]: Refreshing state... [id=ocid1.vcn.oc1.eu-frankfurt-1.amaaaaaadngk4giavslf42qx3wjh6ozjcrgb4unnrwhejpllb2fx3mayasfq]
module.oci-fk-free-mds.oci_core_nat_gateway.FoggyKitchenNATGateway[0]: Refreshing state... [id=ocid1.natgateway.oc1.eu-frankfurt-1.aaaaaaaamgfy4oy3ez6tzq2kn3hj5lgljxqxzlmrmhchd6jak2qcjwn54p5a]
module.oci-fk-free-mds.oci_core_default_security_list.FoggyKitchenDefaultSecurityList[0]: Refreshing state... [id=ocid1.securitylist.oc1.eu-frankfurt-1.aaaaaaaalrwioixeq7gvr4kjk5yyal55eyf3uhxinw7nvz37ehw3zlmsajmq]
module.oci-fk-free-mds.oci_core_security_list.FoggyKitchenMDSSecurityList[0]: Refreshing state... [id=ocid1.securitylist.oc1.eu-frankfurt-1.aaaaaaaajlznl6pvldu3637ievrwjceyedpesmeckaao6nicnhgfgp4ohsaq]
module.oci-fk-free-mds.oci_core_route_table.FoggyKitchenPrivateRouteTable[0]: Refreshing state... [id=ocid1.routetable.oc1.eu-frankfurt-1.aaaaaaaapjfmyqvsknzcmcbmsshon3zqmtxl2kftio6ygomptqal64id3xaq]
module.oci-fk-free-mds.oci_core_subnet.FoggyKitchenPrivateSubnet[0]: Refreshing state... [id=ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaar4g4wjz5znzxwcyjsf376ipx2t2xvt57dyojz5k7w5dq2yvjgf3a]
module.oci-fk-free-mds.oci_core_route_table_attachment.FoggyKitchenPrivateSubnetRouteTableAttachment[0]: Refreshing state... [id=ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaar4g4wjz5znzxwcyjsf376ipx2t2xvt57dyojz5k7w5dq2yvjgf3a/ocid1.routetable.oc1.eu-frankfurt-1.aaaaaaaapjfmyqvsknzcmcbmsshon3zqmtxl2kftio6ygomptqal64id3xaq]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Refreshing state... [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1.aaaaaaaansbyq3sfibkcr5wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # module.oci-fk-free-mds.oci_core_default_security_list.FoggyKitchenDefaultSecurityList[0] will be destroyed
  - resource "oci_core_default_security_list" "FoggyKitchenDefaultSecurityList" {
      - compartment_id             = "ocid1.compartment.oc1..aaaaaaaaiyy4srmrb32v5rlniicwmpxsytywiucgbcp5ext6e4ahjfuloewa" -> null
      - defined_tags               = {} -> null
      - display_name               = "Default Security List for FoggyKitchenMDSVCN" -> null
      - freeform_tags              = {} -> null
      - id                         = "ocid1.securitylist.oc1.eu-frankfurt-1.aaaaaaaalrwioixeq7gvr4kjk5yyal55eyf3uhxinw7nvz37ehw3zlmsajmq" -> null
      - manage_default_resource_id = "ocid1.securitylist.oc1.eu-frankfurt-1.aaaaaaaalrwioixeq7gvr4kjk5yyal55eyf3uhxinw7nvz37ehw3zlmsajmq" -> null
      - state                      = "AVAILABLE" -> null
      - time_created               = "2024-09-08 09:34:23.066 +0000 UTC" -> null

      - egress_security_rules {
          - destination      = "0.0.0.0/0" -> null
          - destination_type = "CIDR_BLOCK" -> null
          - protocol         = "all" -> null
          - stateless        = false -> null
            # (1 unchanged attribute hidden)
        }
    }

  # module.oci-fk-free-mds.oci_core_nat_gateway.FoggyKitchenNATGateway[0] will be destroyed
  - resource "oci_core_nat_gateway" "FoggyKitchenNATGateway" {
      - block_traffic  = false -> null
      - compartment_id = "ocid1.compartment.oc1..aaaaaaaaiyy4srmrb32v5rlniicwmpxsytywiucgbcp5ext6e4ahjfuloewa" -> null
      - defined_tags   = {} -> null
      - display_name   = "FoggyKitchenNATGateway" -> null
      - freeform_tags  = {} -> null
      - id             = "ocid1.natgateway.oc1.eu-frankfurt-1.aaaaaaaamgfy4oy3ez6tzq2kn3hj5lgljxqxzlmrmhchd6jak2qcjwn54p5a" -> null
      - nat_ip         = "141.147.26.200" -> null
      - public_ip_id   = "ocid1.publicip.oc1.eu-frankfurt-1.aaaaaaaa2myq43gsixdrxelhgpary5icsrg6mzjl257x7l2sgs3cr7nlbx5q" -> null
      - state          = "AVAILABLE" -> null
      - time_created   = "2024-09-08 09:34:23.866 +0000 UTC" -> null
      - vcn_id         = "ocid1.vcn.oc1.eu-frankfurt-1.amaaaaaadngk4giavslf42qx3wjh6ozjcrgb4unnrwhejpllb2fx3mayasfq" -> null
    }

  # module.oci-fk-free-mds.oci_core_route_table.FoggyKitchenPrivateRouteTable[0] will be destroyed
  - resource "oci_core_route_table" "FoggyKitchenPrivateRouteTable" {
      - compartment_id = "ocid1.compartment.oc1..aaaaaaaaiyy4srmrb32v5rlniicwmpxsytywiucgbcp5ext6e4ahjfuloewa" -> null
      - defined_tags   = {} -> null
      - display_name   = "FoggyKitchenPrivateRouteTable" -> null
      - freeform_tags  = {} -> null
      - id             = "ocid1.routetable.oc1.eu-frankfurt-1.aaaaaaaapjfmyqvsknzcmcbmsshon3zqmtxl2kftio6ygomptqal64id3xaq" -> null
      - state          = "AVAILABLE" -> null
      - time_created   = "2024-09-08 09:34:24.824 +0000 UTC" -> null
      - vcn_id         = "ocid1.vcn.oc1.eu-frankfurt-1.amaaaaaadngk4giavslf42qx3wjh6ozjcrgb4unnrwhejpllb2fx3mayasfq" -> null

      - route_rules {
          - destination       = "0.0.0.0/0" -> null
          - destination_type  = "CIDR_BLOCK" -> null
          - network_entity_id = "ocid1.natgateway.oc1.eu-frankfurt-1.aaaaaaaamgfy4oy3ez6tzq2kn3hj5lgljxqxzlmrmhchd6jak2qcjwn54p5a" -> null
            # (3 unchanged attributes hidden)
        }
    }

  # module.oci-fk-free-mds.oci_core_route_table_attachment.FoggyKitchenPrivateSubnetRouteTableAttachment[0] will be destroyed
  - resource "oci_core_route_table_attachment" "FoggyKitchenPrivateSubnetRouteTableAttachment" {
      - id             = "ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaar4g4wjz5znzxwcyjsf376ipx2t2xvt57dyojz5k7w5dq2yvjgf3a/ocid1.routetable.oc1.eu-frankfurt-1.aaaaaaaapjfmyqvsknzcmcbmsshon3zqmtxl2kftio6ygomptqal64id3xaq" -> null
      - route_table_id = "ocid1.routetable.oc1.eu-frankfurt-1.aaaaaaaapjfmyqvsknzcmcbmsshon3zqmtxl2kftio6ygomptqal64id3xaq" -> null
      - subnet_id      = "ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaar4g4wjz5znzxwcyjsf376ipx2t2xvt57dyojz5k7w5dq2yvjgf3a" -> null
    }

  # module.oci-fk-free-mds.oci_core_security_list.FoggyKitchenMDSSecurityList[0] will be destroyed
  - resource "oci_core_security_list" "FoggyKitchenMDSSecurityList" {
      - compartment_id = "ocid1.compartment.oc1..aaaaaaaaiyy4srmrb32v5rlniicwmpxsytywiucgbcp5ext6e4ahjfuloewa" -> null
      - defined_tags   = {} -> null
      - display_name   = "FoggyKitchenMDSSecurityList" -> null
      - freeform_tags  = {} -> null
      - id             = "ocid1.securitylist.oc1.eu-frankfurt-1.aaaaaaaajlznl6pvldu3637ievrwjceyedpesmeckaao6nicnhgfgp4ohsaq" -> null
      - state          = "AVAILABLE" -> null
      - time_created   = "2024-09-08 09:34:23.861 +0000 UTC" -> null
      - vcn_id         = "ocid1.vcn.oc1.eu-frankfurt-1.amaaaaaadngk4giavslf42qx3wjh6ozjcrgb4unnrwhejpllb2fx3mayasfq" -> null

      - egress_security_rules {
          - destination      = "0.0.0.0/0" -> null
          - destination_type = "CIDR_BLOCK" -> null
          - protocol         = "all" -> null
          - stateless        = false -> null
            # (1 unchanged attribute hidden)
        }

      - ingress_security_rules {
          - protocol    = "6" -> null
          - source      = "0.0.0.0/0" -> null
          - source_type = "CIDR_BLOCK" -> null
          - stateless   = false -> null
            # (1 unchanged attribute hidden)

          - tcp_options {
              - max = 33060 -> null
              - min = 33060 -> null
            }
        }
      - ingress_security_rules {
          - protocol    = "6" -> null
          - source      = "0.0.0.0/0" -> null
          - source_type = "CIDR_BLOCK" -> null
          - stateless   = false -> null
            # (1 unchanged attribute hidden)

          - tcp_options {
              - max = 3306 -> null
              - min = 3306 -> null
            }
        }
    }

  # module.oci-fk-free-mds.oci_core_subnet.FoggyKitchenPrivateSubnet[0] will be destroyed
  - resource "oci_core_subnet" "FoggyKitchenPrivateSubnet" {
      - cidr_block                 = "10.0.1.0/24" -> null
      - compartment_id             = "ocid1.compartment.oc1..aaaaaaaaiyy4srmrb32v5rlniicwmpxsytywiucgbcp5ext6e4ahjfuloewa" -> null
      - defined_tags               = {} -> null
      - dhcp_options_id            = "ocid1.dhcpoptions.oc1.eu-frankfurt-1.aaaaaaaagp4y6yki6ehiabplmexth65zpc4zxnjkvqes65c3wjixyalsrr7a" -> null
      - display_name               = "FoggyKitchenMDSSubnet" -> null
      - freeform_tags              = {} -> null
      - id                         = "ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaar4g4wjz5znzxwcyjsf376ipx2t2xvt57dyojz5k7w5dq2yvjgf3a" -> null
      - ipv6cidr_blocks            = [] -> null
      - prohibit_internet_ingress  = true -> null
      - prohibit_public_ip_on_vnic = true -> null
      - route_table_id             = "ocid1.routetable.oc1.eu-frankfurt-1.aaaaaaaapjfmyqvsknzcmcbmsshon3zqmtxl2kftio6ygomptqal64id3xaq" -> null
      - security_list_ids          = [
          - "ocid1.securitylist.oc1.eu-frankfurt-1.aaaaaaaajlznl6pvldu3637ievrwjceyedpesmeckaao6nicnhgfgp4ohsaq",
        ] -> null
      - state                      = "AVAILABLE" -> null
      - time_created               = "2024-09-08 09:34:24.2 +0000 UTC" -> null
      - vcn_id                     = "ocid1.vcn.oc1.eu-frankfurt-1.amaaaaaadngk4giavslf42qx3wjh6ozjcrgb4unnrwhejpllb2fx3mayasfq" -> null
      - virtual_router_ip          = "10.0.1.1" -> null
      - virtual_router_mac         = "00:00:17:EB:E5:18" -> null
    }

  # module.oci-fk-free-mds.oci_core_vcn.FoggyKitchenVCN[0] will be destroyed
  - resource "oci_core_vcn" "FoggyKitchenVCN" {
      - byoipv6cidr_blocks       = [] -> null
      - cidr_block               = "10.0.0.0/16" -> null
      - cidr_blocks              = [
          - "10.0.0.0/16",
        ] -> null
      - compartment_id           = "ocid1.compartment.oc1..aaaaaaaaiyy4srmrb32v5rlniicwmpxsytywiucgbcp5ext6e4ahjfuloewa" -> null
      - default_dhcp_options_id  = "ocid1.dhcpoptions.oc1.eu-frankfurt-1.aaaaaaaagp4y6yki6ehiabplmexth65zpc4zxnjkvqes65c3wjixyalsrr7a" -> null
      - default_route_table_id   = "ocid1.routetable.oc1.eu-frankfurt-1.aaaaaaaaxafcjmmybykbfuvipdhjypuskz4y3rcrbpqkcfym4rgzaai7xlsq" -> null
      - default_security_list_id = "ocid1.securitylist.oc1.eu-frankfurt-1.aaaaaaaalrwioixeq7gvr4kjk5yyal55eyf3uhxinw7nvz37ehw3zlmsajmq" -> null
      - defined_tags             = {} -> null
      - display_name             = "FoggyKitchenMDSVCN" -> null
      - dns_label                = "mdsvcn" -> null
      - freeform_tags            = {} -> null
      - id                       = "ocid1.vcn.oc1.eu-frankfurt-1.amaaaaaadngk4giavslf42qx3wjh6ozjcrgb4unnrwhejpllb2fx3mayasfq" -> null
      - ipv6cidr_blocks          = [] -> null
      - ipv6private_cidr_blocks  = [] -> null
      - is_ipv6enabled           = false -> null
      - state                    = "AVAILABLE" -> null
      - time_created             = "2024-09-08 09:34:23.066 +0000 UTC" -> null
      - vcn_domain_name          = "mdsvcn.oraclevcn.com" -> null
    }

  # module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0] will be destroyed
  - resource "oci_mysql_mysql_db_system" "FoggyKitchenMDS" {
      - admin_password                 = (sensitive value) -> null
      - admin_username                 = "mysql" -> null
      - availability_domain            = "unja:EU-FRANKFURT-1-AD-3" -> null
      - channels                       = [] -> null
      - compartment_id                 = "ocid1.compartment.oc1..aaaaaaaaiyy4srmrb32v5rlniicwmpxsytywiucgbcp5ext6e4ahjfuloewa" -> null
      - configuration_id               = "ocid1.mysqlconfiguration.oc1..aaaaaaaa5a33g5cxy33cwd2egvmmyhnx5lsf5frueox3mgrnfqabdqdwio7a" -> null
      - crash_recovery                 = "ENABLED" -> null
      - current_placement              = [
          - {
              - availability_domain = "unja:EU-FRANKFURT-1-AD-3"
              - fault_domain        = "FAULT-DOMAIN-3"
            },
        ] -> null
      - data_storage_size_in_gb        = 50 -> null
      - database_management            = "DISABLED" -> null
      - defined_tags                   = {} -> null
      - description                    = "FoggyKitchen Free Tier MySQL/Heatwave Database System" -> null
      - display_name                   = "FoggyKitchenFreeTierMDS" -> null
      - endpoints                      = [
          - {
              - hostname       = "fkmds"
              - ip_address     = "10.0.1.121"
              - modes          = [
                  - "READ",
                  - "WRITE",
                ]
              - port           = 3306
              - port_x         = 33060
              - resource_id    = "ocid1.mysqldbsystem.oc1.eu-frankfurt-1.aaaaaaaansbyq3sfibkcr5wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq"
              - resource_type  = "DBSYSTEM"
              - status         = "ACTIVE"
                # (1 unchanged attribute hidden)
            },
        ] -> null
      - fault_domain                   = "FAULT-DOMAIN-3" -> null
      - freeform_tags                  = {} -> null
      - heat_wave_cluster              = [] -> null
      - hostname_label                 = "fkmds" -> null
      - id                             = "ocid1.mysqldbsystem.oc1.eu-frankfurt-1.aaaaaaaansbyq3sfibkcr5wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq" -> null
      - ip_address                     = "10.0.1.121" -> null
      - is_heat_wave_cluster_attached  = false -> null
      - is_highly_available            = false -> null
      - mysql_version                  = "9.0.1" -> null
      - point_in_time_recovery_details = [] -> null
      - port                           = 3306 -> null
      - port_x                         = 33060 -> null
      - shape_name                     = "MySQL.Free" -> null
      - state                          = "ACTIVE" -> null
      - subnet_id                      = "ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaar4g4wjz5znzxwcyjsf376ipx2t2xvt57dyojz5k7w5dq2yvjgf3a" -> null
      - time_created                   = "2024-09-08 09:34:26.393 +0000 UTC" -> null
      - time_updated                   = "2024-09-08 09:46:04.379 +0000 UTC" -> null
        # (1 unchanged attribute hidden)

      - backup_policy {
          - defined_tags      = {} -> null
          - freeform_tags     = {} -> null
          - is_enabled        = true -> null
          - retention_in_days = 1 -> null
          - window_start_time = "15:56" -> null

          - pitr_policy {
              - is_enabled = false -> null
            }
        }

      - data_storage {
          - allocated_storage_size_in_gbs  = 50 -> null
          - data_storage_size_in_gb        = 50 -> null
          - data_storage_size_limit_in_gbs = 32768 -> null
          - is_auto_expand_storage_enabled = false -> null
          - max_storage_size_in_gbs        = 0 -> null
        }

      - deletion_policy {
          - automatic_backup_retention = "RETAIN" -> null
          - final_backup               = "SKIP_FINAL_BACKUP" -> null
          - is_delete_protected        = false -> null
        }

      - maintenance {
          - window_start_time = "MONDAY 23:59" -> null
        }

      - secure_connections {
          - certificate_generation_type = "SYSTEM" -> null
            # (1 unchanged attribute hidden)
        }

      - source {
          - source_type    = "NONE" -> null
            # (4 unchanged attributes hidden)
        }
    }

Plan: 0 to add, 0 to change, 8 to destroy.

Changes to Outputs:
  - mds_database = {
      - mds_id         = "ocid1.mysqldbsystem.oc1.eu-frankfurt-1.aaaaaaaansbyq3sfibkcr5wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq"
      - mds_ip_address = "10.0.1.121"
      - mds_port       = "3306"
      - mds_port_x     = "33060"
    } -> null

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

module.oci-fk-free-mds.oci_core_route_table_attachment.FoggyKitchenPrivateSubnetRouteTableAttachment[0]: Destroying... [id=ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaar4g4wjz5znzxwcyjsf376ipx2t2xvt57dyojz5k7w5dq2yvjgf3a/ocid1.routetable.oc1.eu-frankfurt-1.aaaaaaaapjfmyqvsknzcmcbmsshon3zqmtxl2kftio6ygomptqal64id3xaq]
module.oci-fk-free-mds.oci_core_default_security_list.FoggyKitchenDefaultSecurityList[0]: Destroying... [id=ocid1.securitylist.oc1.eu-frankfurt-1.aaaaaaaalrwioixeq7gvr4kjk5yyal55eyf3uhxinw7nvz37ehw3zlmsajmq]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Destroying... [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1.aaaaaaaansbyq3sfibkcr5wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq]
module.oci-fk-free-mds.oci_core_default_security_list.FoggyKitchenDefaultSecurityList[0]: Destruction complete after 1s
module.oci-fk-free-mds.oci_core_route_table_attachment.FoggyKitchenPrivateSubnetRouteTableAttachment[0]: Destruction complete after 1s
module.oci-fk-free-mds.oci_core_route_table.FoggyKitchenPrivateRouteTable[0]: Destroying... [id=ocid1.routetable.oc1.eu-frankfurt-1.aaaaaaaapjfmyqvsknzcmcbmsshon3zqmtxl2kftio6ygomptqal64id3xaq]
module.oci-fk-free-mds.oci_core_route_table.FoggyKitchenPrivateRouteTable[0]: Destruction complete after 1s
module.oci-fk-free-mds.oci_core_nat_gateway.FoggyKitchenNATGateway[0]: Destroying... [id=ocid1.natgateway.oc1.eu-frankfurt-1.aaaaaaaamgfy4oy3ez6tzq2kn3hj5lgljxqxzlmrmhchd6jak2qcjwn54p5a]
module.oci-fk-free-mds.oci_core_nat_gateway.FoggyKitchenNATGateway[0]: Destruction complete after 0s
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still destroying... [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1....wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq, 10s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still destroying... [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1....wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq, 20s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still destroying... [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1....wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq, 30s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still destroying... [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1....wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq, 40s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still destroying... [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1....wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq, 50s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still destroying... [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1....wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq, 1m0s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still destroying... [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1....wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq, 1m10s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still destroying... [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1....wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq, 1m20s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still destroying... [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1....wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq, 1m30s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still destroying... [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1....wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq, 1m40s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still destroying... [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1....wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq, 1m50s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still destroying... [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1....wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq, 2m0s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still destroying... [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1....wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq, 2m10s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still destroying... [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1....wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq, 2m20s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still destroying... [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1....wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq, 2m30s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still destroying... [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1....wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq, 2m40s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Still destroying... [id=ocid1.mysqldbsystem.oc1.eu-frankfurt-1....wkium5hkgi27jneg32lps5r2gbekph2hf2ssvq, 2m50s elapsed]
module.oci-fk-free-mds.oci_mysql_mysql_db_system.FoggyKitchenMDS[0]: Destruction complete after 2m51s
module.oci-fk-free-mds.oci_core_subnet.FoggyKitchenPrivateSubnet[0]: Destroying... [id=ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaar4g4wjz5znzxwcyjsf376ipx2t2xvt57dyojz5k7w5dq2yvjgf3a]
module.oci-fk-free-mds.oci_core_subnet.FoggyKitchenPrivateSubnet[0]: Destruction complete after 1s
module.oci-fk-free-mds.oci_core_security_list.FoggyKitchenMDSSecurityList[0]: Destroying... [id=ocid1.securitylist.oc1.eu-frankfurt-1.aaaaaaaajlznl6pvldu3637ievrwjceyedpesmeckaao6nicnhgfgp4ohsaq]
module.oci-fk-free-mds.oci_core_security_list.FoggyKitchenMDSSecurityList[0]: Destruction complete after 0s
module.oci-fk-free-mds.oci_core_vcn.FoggyKitchenVCN[0]: Destroying... [id=ocid1.vcn.oc1.eu-frankfurt-1.amaaaaaadngk4giavslf42qx3wjh6ozjcrgb4unnrwhejpllb2fx3mayasfq]
module.oci-fk-free-mds.oci_core_vcn.FoggyKitchenVCN[0]: Destruction complete after 1s

Destroy complete! Resources: 8 destroyed.
```
