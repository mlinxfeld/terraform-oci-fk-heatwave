variable "tenancy_ocid" {}
#variable "user_ocid" {}
#variable "private_key_path" {}
variable "region" {}
#variable "fingerprint" {}
variable "mds_compartment_ocid" {}
variable "mds_admin_password" {}
variable "mds_availability_domain" {}

variable "mds_heatwave_enabled" {
  default = false
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
  default = 1
}

variable "instance_os" {
  default = "Oracle Linux"
}

variable "linux_os_version" {
  default = "8"
}