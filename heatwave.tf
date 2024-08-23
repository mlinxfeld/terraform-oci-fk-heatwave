resource "oci_mysql_heat_wave_cluster" "FoggyKitchenHeatWave" {
    count        = var.heatwave_cluster_enabled ? 1 : 0
    db_system_id = oci_mysql_mysql_db_system.FoggyKitchenMDS.id
    cluster_size = var.heatwave_cluster_size
    shape_name   = var.heatwave_shape
}