provider "kubernetes" {
  version = "~> 1.12.0"
  load_config_file       = false
  host    = google_container_cluster.default.endpoint
  token   = data.google_client_config.current.access_token
  client_certificate = base64decode(google_container_cluster.default.master_auth[0].client_certificate,)
  client_key = base64decode(google_container_cluster.default.master_auth[0].client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.default.master_auth[0].cluster_ca_certificate,)
}

resource "google_compute_address" "default" {
  name   = var.network_name
  region = var.region
}

resource "null_resource" "startup" {
    depends_on = [google_container_cluster.default]
        provisioner "local-exec" {
            command = "sh startup.sh"
        }
}