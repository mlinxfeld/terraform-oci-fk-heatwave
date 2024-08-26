module "oci-arch-wordpress" {
  source                    = "github.com/oracle-devrel/terraform-oci-arch-wordpress"
  tenancy_ocid              = var.tenancy_ocid
  vcn_id                    = oci_core_vcn.FoggyKitchenVCN.id
  numberOfNodes             = 1
  availability_domain       = var.mds_availability_domain == "" ? lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name") : var.mds_availability_domain
  compartment_ocid          = var.mds_compartment_ocid
  image_id                  = lookup(data.oci_core_images.OSImage.images[0], "id")
  shape                     = var.wordpress_compute_shape
  flex_shape_ocpus          = var.wordpress_compute_flex_shape_ocpus
  flex_shape_memory         = var.wordpress_compute_flex_shape_memory
  label_prefix              = "wpmds"
  ssh_authorized_keys       = tls_private_key.public_private_key_pair.public_key_openssh
  mds_ip                    = module.oci-fk-free-mds.mds_database.mds_ip_address
  wp_subnet_id              = oci_core_subnet.FoggyKitchenPublicSubnet.id
  admin_username            = var.mds_admin_username
  admin_password            = var.mds_admin_password
  wp_schema                 = var.wp_schema
  wp_name                   = var.wp_name
  wp_password               = var.mds_wp_password
  wp_plugins                = tolist(split(",",var.wp_plugins))
  wp_themes                 = tolist(split(",",var.wp_themes))
  wp_site_title             = var.wp_site_title
  wp_site_admin_user        = var.wp_site_admin_user
  wp_site_admin_pass        = var.wp_site_admin_pass
  wp_site_admin_email       = var.wp_site_admin_email
  display_name              = "FoggyKitchenWordpress"
}