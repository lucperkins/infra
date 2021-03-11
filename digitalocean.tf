resource "digitalocean_kubernetes_cluster" "dev" {
  name    = "datadog-dev"
  region  = var.do_k8s_region
  version = "1.20.2-do.0"

  node_pool {
    name       = "worker-pool"
    size       = var.do_k8s_droplet_image_size
    node_count = var.do_k8s_node_pool_size
  }
}


provider "kubernetes" {
  version = "2.0.2"

  host = digitalocean_kubernetes_cluster.dev.ipv4_address

  client_certificate     = digitalocean_kubernetes_cluster.dev.kube_config.0.client_certificate
  client_key             = digitalocean_kubernetes_cluster.dev.kube_config.0.client_key
  cluster_ca_certificate = digitalocean_kubernetes_cluster.dev.kube_config.0.cluster_ca_certificate
}
