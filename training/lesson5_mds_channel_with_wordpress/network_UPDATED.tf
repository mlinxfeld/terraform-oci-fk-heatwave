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
    source   = "0.0.0.0/0"

    source_type = "CIDR_BLOCK"
    tcp_options {
      max = 3306
      min = 3306
    }
  }
  ingress_security_rules {
    protocol = 6
    source   = "0.0.0.0/0"

    source_type = "CIDR_BLOCK"
    tcp_options {
      max = 33060
      min = 33060
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
  dynamic "route_rules" {
    for_each = var.mds_channel_enable ? [1] : []
    content {
      network_entity_id = oci_core_drg.FoggyKitchenDRG1[0].id
      destination       = var.mds_vcn_cidr_block2
      destination_type  = "CIDR_BLOCK"
    }    
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