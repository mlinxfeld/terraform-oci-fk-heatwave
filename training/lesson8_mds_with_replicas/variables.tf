variable "tenancy_ocid" {}
#variable "user_ocid" {}
#variable "private_key_path" {}
variable "region" {}
#variable "fingerprint" {}
variable "mds_compartment_ocid" {}
variable "mds_admin_password" {}
variable "mds_availability_domain" {}

variable "mds_replica_enabled" {
  default = false
}