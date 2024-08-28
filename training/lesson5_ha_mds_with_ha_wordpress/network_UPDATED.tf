resource "oci_core_vcn" "FoggyKitchenVCN" {
  cidr_block     = var.mds_vcn_cidr_block
  dns_label      = var.mds_vcn_dns_label
  compartment_id = var.mds_compartment_ocid 
  display_name   = var.mds_vcn_display_name
}

resource "oci_core_internet_gateway" "FoggyKitchenInternetGateway" {
  compartment_id = var.mds_compartment_ocid
  vcn_id         = oci_core_vcn.FoggyKitchenVCN.id
  display_name   = "FoggyKitchenInternetGateway"
}

resource "oci_core_nat_gateway" "FoggyKitchenNATGateway" {
  compartment_id = var.mds_compartment_ocid
  vcn_id         = oci_core_vcn.FoggyKitchenVCN.id
  display_name   = "FoggyKitchenNATGateway"
}

resource "oci_core_route_table" "FoggyKitchenPublicRouteTable" {
  compartment_id = var.mds_compartment_ocid
  vcn_id         = oci_core_vcn.FoggyKitchenVCN.id
  display_name   = "FoggyKitchenPublicRouteTable"
  route_rules {
    network_entity_id = oci_core_internet_gateway.FoggyKitchenInternetGateway.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}

resource "oci_core_security_list" "FoggyKitchenBastionSecurityList" {
  compartment_id = var.mds_compartment_ocid
  vcn_id         = oci_core_vcn.FoggyKitchenVCN.id
  display_name   = "FoggyKitchenBastionSecurityList"

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }
  ingress_security_rules {
    protocol = 6
    source   = "0.0.0.0/0"

    source_type = "CIDR_BLOCK"
    tcp_options {
      max = 22
      min = 22
    }
  }
  ingress_security_rules {
    protocol = 6
    source   = "0.0.0.0/0"

    source_type = "CIDR_BLOCK"
    tcp_options {
      max = 80
      min = 80
    }
  }
  ingress_security_rules {
    protocol = 6
    source   = "0.0.0.0/0"

    source_type = "CIDR_BLOCK"
    tcp_options {
      max = 443
      min = 443
    }
  }
}

resource "oci_core_security_list" "FoggyKitchenMDSSecurityList" {
  compartment_id = var.mds_compartment_ocid
  vcn_id         = oci_core_vcn.FoggyKitchenVCN.id
  display_name   = "FoggyKitchenMDSSecurityList"
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  ingress_security_rules {
    protocol = 6
    source   = var.mds_vcn_cidr_block

    source_type = "CIDR_BLOCK"
    tcp_options {
      max = 22
      min = 22
    }
  }

  ingress_security_rules {
    source_type = "CIDR_BLOCK"
    tcp_options {
      max = 3306
      min = 3306
    }
    protocol = 6
    source   = var.mds_vcn_cidr_block
  }
  
  ingress_security_rules {
    tcp_options {
      max = 80
      min = 80
    }
    protocol = "6"
    source   = var.mds_vcn_cidr_block
  }

  ingress_security_rules {
    tcp_options {
      max = 33061
      min = 33060
    }
    protocol = "6"
    source   = var.mds_vcn_cidr_block
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.mds_vcn_cidr_block

    tcp_options {
      min = 2048
      max = 2050
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.mds_vcn_cidr_block

    tcp_options {
      source_port_range {
        min = 2048
        max = 2050
      }
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.mds_vcn_cidr_block

    tcp_options {
      min = 111
      max = 111
    }
  }
}

resource "oci_core_route_table" "FoggyKitchenPrivateRouteTable" {
  compartment_id = var.mds_compartment_ocid
  vcn_id         = oci_core_vcn.FoggyKitchenVCN.id
  display_name   = "FoggyKitchenPrivateRouteTable"
  route_rules {
    network_entity_id = oci_core_nat_gateway.FoggyKitchenNATGateway.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}

resource "oci_core_subnet" "FoggyKitchenPublicSubnet" {
  cidr_block        = var.mds_public_subnet_cidr_block
  compartment_id    = var.mds_compartment_ocid
  vcn_id            = oci_core_vcn.FoggyKitchenVCN.id
  security_list_ids = [oci_core_security_list.FoggyKitchenBastionSecurityList.id]
  display_name      = var.mds_public_subnet_display_name
  dns_label         = "wpsub"
}


resource "oci_core_route_table_attachment" "FoggyKitchenPublicSubnetRouteTableAttachment" {
  subnet_id      = oci_core_subnet.FoggyKitchenPublicSubnet.id
  route_table_id = oci_core_route_table.FoggyKitchenPublicRouteTable.id
}

resource "oci_core_subnet" "FoggyKitchenPrivateSubnet" {
  cidr_block                 = var.mds_private_subnet_cidr_block
  compartment_id             = var.mds_compartment_ocid
  vcn_id                     = oci_core_vcn.FoggyKitchenVCN.id
  security_list_ids          = [oci_core_security_list.FoggyKitchenMDSSecurityList.id]
  display_name               = var.mds_private_subnet_display_name
  prohibit_public_ip_on_vnic = true
  dns_label                  = "mdssub"
}

resource "oci_core_route_table_attachment" "FoggyKitchenPrivateSubnetRouteTableAttachment" {
  subnet_id      = oci_core_subnet.FoggyKitchenPrivateSubnet.id
  route_table_id = oci_core_route_table.FoggyKitchenPrivateRouteTable.id
}