resource "oci_core_vcn" "FoggyKitchenVCN2" {
  provider       = oci.region2
  cidr_block     = var.mds_vcn_cidr_block2
  dns_label      = var.mds_vcn_dns_label
  compartment_id = var.mds_compartment_ocid 
  display_name   = var.mds_vcn_display_name
}

resource "oci_core_internet_gateway" "FoggyKitchenInternetGateway2" {
  provider       = oci.region2
  compartment_id = var.mds_compartment_ocid
  vcn_id         = oci_core_vcn.FoggyKitchenVCN2.id
  display_name   = "FoggyKitchenInternetGateway2"
}

resource "oci_core_nat_gateway" "FoggyKitchenNATGateway2" {
  provider       = oci.region2  
  compartment_id = var.mds_compartment_ocid
  vcn_id         = oci_core_vcn.FoggyKitchenVCN2.id
  display_name   = "FoggyKitchenNATGateway2"
}

resource "oci_core_route_table" "FoggyKitchenPublicRouteTable2" {
  provider       = oci.region2
  compartment_id = var.mds_compartment_ocid
  vcn_id         = oci_core_vcn.FoggyKitchenVCN2.id
  display_name   = "FoggyKitchenPublicRouteTable"
  route_rules {
    network_entity_id = oci_core_internet_gateway.FoggyKitchenInternetGateway2.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}

resource "oci_core_security_list" "FoggyKitchenBastionSecurityList2" {
  provider       = oci.region2
  compartment_id = var.mds_compartment_ocid
  vcn_id         = oci_core_vcn.FoggyKitchenVCN2.id
  display_name   = "FoggyKitchenBastionSecurityList2"

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

resource "oci_core_security_list" "FoggyKitchenMDSSecurityList2" {
  provider       = oci.region2
  compartment_id = var.mds_compartment_ocid
  vcn_id         = oci_core_vcn.FoggyKitchenVCN2.id
  display_name   = "FoggyKitchenMDSSecurityList2"
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

resource "oci_core_route_table" "FoggyKitchenPrivateRouteTable2" {
  provider       = oci.region2
  compartment_id = var.mds_compartment_ocid
  vcn_id         = oci_core_vcn.FoggyKitchenVCN2.id
  display_name   = "FoggyKitchenPrivateRouteTable2"
  route_rules {
    network_entity_id = oci_core_nat_gateway.FoggyKitchenNATGateway2.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
  dynamic "route_rules" {
    for_each = var.mds_channel_enable ? [1] : []
    content {
      network_entity_id = oci_core_drg.FoggyKitchenDRG2[0].id
      destination       = var.mds_vcn_cidr_block
      destination_type  = "CIDR_BLOCK"
    }    
  }
}

resource "oci_core_subnet" "FoggyKitchenPublicSubnet2" {
  provider          = oci.region2
  cidr_block        = var.mds_public_subnet_cidr_block2
  compartment_id    = var.mds_compartment_ocid
  vcn_id            = oci_core_vcn.FoggyKitchenVCN2.id
  security_list_ids = [oci_core_security_list.FoggyKitchenBastionSecurityList2.id]
  display_name      = var.mds_public_subnet_display_name2
  dns_label         = "wpsub2"
}


resource "oci_core_route_table_attachment" "FoggyKitchenPublicSubnetRouteTableAttachment2" {
  provider       = oci.region2  
  subnet_id      = oci_core_subnet.FoggyKitchenPublicSubnet2.id
  route_table_id = oci_core_route_table.FoggyKitchenPublicRouteTable2.id
}

resource "oci_core_subnet" "FoggyKitchenPrivateSubnet2" {
  provider                   = oci.region2  
  cidr_block                 = var.mds_private_subnet_cidr_block2
  compartment_id             = var.mds_compartment_ocid
  vcn_id                     = oci_core_vcn.FoggyKitchenVCN2.id
  security_list_ids          = [oci_core_security_list.FoggyKitchenMDSSecurityList2.id]
  display_name               = var.mds_private_subnet_display_name2
  prohibit_public_ip_on_vnic = true
  dns_label                  = "mdssub2"
}

resource "oci_core_route_table_attachment" "FoggyKitchenPrivateSubnetRouteTableAttachment2" {
  provider       = oci.region2  
  subnet_id      = oci_core_subnet.FoggyKitchenPrivateSubnet2.id
  route_table_id = oci_core_route_table.FoggyKitchenPrivateRouteTable2.id
}