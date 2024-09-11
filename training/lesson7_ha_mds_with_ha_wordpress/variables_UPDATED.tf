variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "private_key_path" {}
variable "region" {}
variable "fingerprint" {}
variable "mds_compartment_ocid" {}
variable "mds_admin_password" {}
variable "mds_availability_domain" {}

variable "mds_manual_backup_enabled" {
  default = true
}

variable "mds_admin_username" {
  default = "mysql"
}

variable "mds_vcn_cidr_block" {
  default = "10.0.0.0/16"  
}
variable "mds_vcn_dns_label" {
  default = "wpmds" 
}

variable "mds_vcn_display_name" {
  default = "FoggyKitchenMDSVCN"
}

variable "mds_private_subnet_cidr_block" {
  default = "10.0.2.0/24" 
}

variable "mds_private_subnet_display_name" {
  default = "FoggyKitchenPrivateSubnet"
}

variable "mds_public_subnet_cidr_block" {
  default = "10.0.1.0/24" 
}

variable "mds_public_subnet_display_name" {
  default = "FoggyKitchenPublicSubnet"
}

variable "bastion_shape" {
  default = "VM.Standard.A1.Flex"
}

variable "bastion_flex_shape_ocpus" {
  default = 1
}

variable "bastion_flex_shape_memory" {
  default = 2
}

variable "wordpress_compute_shape" {
  default = "VM.Standard.A1.Flex"
}

variable "wordpress_compute_flex_shape_ocpus" {
  default = 1
}

variable "wordpress_compute_flex_shape_memory" {
  default = 4
}

variable "instance_os" {
  default = "Oracle Linux"
}

variable "linux_os_version" {
  default = "8"
}

variable "wp_name" {
  description = "wp Database User Name."
  default     = "wp"
}

variable "mds_wp_password" {
  description = "wp Database User Password."
  default     = ""
}

variable "wp_schema" {
  description = "wp MySQL Schema"
  default     = "wp"
}

variable "wp_auto_update" {
  default     = true
}

variable "wp_plugins" {
  description = "A list of WordPress plugins to install."
  default     = "hello-dolly"
}

variable "wp_themes" {
  description = "A list of WordPress themes to install."
  default     = "lodestar, twentysixteen"
}

variable "wp_site_url" {
  description = "WordPress Site URL"
  default     = "foggykitchen.xyz"
}

variable "wp_site_title" {
  description = "WordPress Site Title"
  default     = "FoggyKitchen MDS-Heatwave + WordPress demo"
}

variable "wp_site_admin_user" {
  description = "WordPress Site Admin Username"
  default     = "admin"
}

variable "wp_site_admin_pass" {
  description = "WordPress Site Admin Password"
  default     = ""
}

variable "wp_site_admin_email" {
  description = "WordPress Site Admin Email"
  default     = "admin@example.com"
}

variable "mds_is_highly_available" {
  default = true
}

variable "lb_shape" {
  default = "flexible"
}

variable "flex_lb_min_shape" {
  default = "10"
}

variable "flex_lb_max_shape" {
  default = "100"
}

variable "wp_version" {
  default = "6.6.1"
}