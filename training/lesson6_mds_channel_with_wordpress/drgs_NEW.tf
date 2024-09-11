resource "oci_core_drg" "FoggyKitchenDRG1" {
  count          = var.mds_channel_enabled ? 1 : 0    
 # depends_on     = [oci_identity_policy.FoggyKitchenRequestorPolicy]
  provider       = oci.region1
  display_name   = "FoggyKitchenDRG1"
  compartment_id = var.mds_compartment_ocid
}

resource "oci_core_drg_attachment" "FoggyKitchenDRG1Attachment" {
  count        = var.mds_channel_enabled ? 1 : 0      
#  depends_on = [oci_identity_policy.FoggyKitchenRequestorPolicy]
  provider     = oci.region1
  display_name = "FoggyKitchenDRG1Attachment"
  drg_id       = oci_core_drg.FoggyKitchenDRG1[0].id
  vcn_id       = oci_core_vcn.FoggyKitchenVCN.id
}

resource "oci_core_remote_peering_connection" "FoggyKitchenRPC1" {
  count            = var.mds_channel_enabled ? 1 : 0      
#  depends_on       = [oci_identity_policy.FoggyKitchenRequestorPolicy]
  provider         = oci.region1
  compartment_id   = var.mds_compartment_ocid
  drg_id           = oci_core_drg.FoggyKitchenDRG1[0].id
  display_name     = "FoggyKitchenRPC1"
  peer_id          = oci_core_remote_peering_connection.FoggyKitchenRPC2[0].id
  peer_region_name = var.region2
}

resource "oci_core_drg" "FoggyKitchenDRG2" {
  count          = var.mds_channel_enabled ? 1 : 0    
 # depends_on     = [oci_identity_policy.FoggyKitchenRequestorPolicy]
  provider       = oci.region2
  display_name   = "FoggyKitchenDRG2"
  compartment_id = var.mds_compartment_ocid
}

resource "oci_core_drg_attachment" "FoggyKitchenDRG2Attachment" {
  count        = var.mds_channel_enabled ? 1 : 0      
#  depends_on = [oci_identity_policy.FoggyKitchenRequestorPolicy]
  provider     = oci.region2
  display_name = "FoggyKitchenDRG2Attachment"
  drg_id       = oci_core_drg.FoggyKitchenDRG2[0].id
  vcn_id       = oci_core_vcn.FoggyKitchenVCN2.id
}

resource "oci_core_remote_peering_connection" "FoggyKitchenRPC2" {
  count          = var.mds_channel_enabled ? 1 : 0   
#  depends_on     = [oci_identity_policy.FoggyKitchenAcceptorPolicy]
  provider       = oci.region2
  compartment_id = var.mds_compartment_ocid
  drg_id         = oci_core_drg.FoggyKitchenDRG2[0].id
  display_name   = "FoggyKitchenRPC2"
}