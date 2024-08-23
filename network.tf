resource "oci_core_vcn" "FoggyKitchenVCN" {
  count          = !var.use_existing_vcn ? 1 : 0
  cidr_block     = var.mds_vcn_cidr_block
  dns_label      = var.mds_vcn_dns_label
  compartment_id = var.mds_compartment_ocid 
  display_name   = var.mds_vcn_display_name
}

resource "oci_core_internet_gateway" "FoggyKitchenInternetGateway" {
  count          = !var.use_existing_vcn && var.use_public_subnet ? 1 : 0
  compartment_id = var.mds_compartment_ocid
  vcn_id         = oci_core_vcn.FoggyKitchenVCN[0].id
  display_name   = "FoggyKitchenInternetGateway"
}

resource "oci_core_nat_gateway" "FoggyKitchenNATGateway" {
  count          = !var.use_existing_vcn && !var.use_public_subnet ? 1 : 0
  compartment_id = var.mds_compartment_ocid
  vcn_id         = oci_core_vcn.FoggyKitchenVCN[0].id
  display_name   = "FoggyKitchenNATGateway"
}

resource "oci_core_route_table" "FoggyKitchenPublicRouteTable" {
  count          = !var.use_existing_vcn && var.use_public_subnet ? 1 : 0
  compartment_id = var.mds_compartment_ocid
  vcn_id         = oci_core_vcn.FoggyKitchenVCN[0].id
  display_name   = "FoggyKitchenPublicRouteTable"
  route_rules {
    network_entity_id = oci_core_internet_gateway.FoggyKitchenInternetGateway[0].id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}

resource "oci_core_default_security_list" "FoggyKitchenDefaultSecurityList" {
  count                      = !var.use_existing_vcn ? 1 : 0
  manage_default_resource_id = oci_core_vcn.FoggyKitchenVCN[0].default_security_list_id
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }
}

resource "oci_core_security_list" "FoggyKitchenMDSSecurityList" {
  count          = !var.use_existing_vcn ? 1 : 0
  compartment_id = var.mds_compartment_ocid
  vcn_id         = oci_core_vcn.FoggyKitchenVCN[0].id
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
  count          = !var.use_existing_vcn && !var.use_public_subnet ? 1 : 0
  compartment_id = var.mds_compartment_ocid
  vcn_id         = oci_core_vcn.FoggyKitchenVCN[0].id
  display_name   = "FoggyKitchenPrivateRouteTable"
  route_rules {
    network_entity_id = oci_core_nat_gateway.FoggyKitchenNATGateway[0].id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}

resource "oci_core_subnet" "FoggyKitchenPublicSubnet" {
  count             = !var.use_existing_vcn && var.use_public_subnet ? 1 : 0
  cidr_block        = var.mds_subnet_cidr_block
  compartment_id    = var.mds_compartment_ocid
  vcn_id            = oci_core_vcn.FoggyKitchenVCN[0].id
  security_list_ids = [oci_core_security_list.FoggyKitchenMDSSecurityList[0].id]
  display_name      = var.mds_subnet_display_name
}


resource "oci_core_route_table_attachment" "FoggyKitchenPublicSubnetRouteTableAttachment" {
  count          = !var.use_existing_vcn && var.use_public_subnet ? 1 : 0
  subnet_id      = oci_core_subnet.FoggyKitchenPublicSubnet[0].id
  route_table_id = oci_core_route_table.FoggyKitchenPublicRouteTable[0].id
}

resource "oci_core_subnet" "FoggyKitchenPrivateSubnet" {
  count                      = !var.use_existing_vcn && !var.use_public_subnet ? 1 : 0
  cidr_block                 = var.mds_subnet_cidr_block
  compartment_id             = var.mds_compartment_ocid
  vcn_id                     = oci_core_vcn.FoggyKitchenVCN[0].id
  security_list_ids          = [oci_core_security_list.FoggyKitchenMDSSecurityList[0].id]
  display_name               = var.mds_subnet_display_name
  prohibit_public_ip_on_vnic = true
}

resource "oci_core_route_table_attachment" "FoggyKitchenPrivateSubnetRouteTableAttachment" {
  count          = !var.use_existing_vcn && !var.use_public_subnet ? 1 : 0
  subnet_id      = oci_core_subnet.FoggyKitchenPrivateSubnet[0].id
  route_table_id = oci_core_route_table.FoggyKitchenPrivateRouteTable[0].id
}