terraform {
  required_version = ">= 1.0"
  required_providers {
    oci = {
      source  = "oracle/oci"
    }
  }
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

provider "oci" {
  alias            = "region1"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

provider "oci" {
  alias            = "region2"
  tenancy_ocid     = var.tenancy_ocid
#  user_ocid        = var.user_ocid
#  fingerprint      = var.fingerprint
#  private_key_path = var.private_key_path
  region           = var.region2
}
