resource "digitalocean_kubernetes_cluster" "dev" {
  name    = "datadog-dev"
  region  = "sfo3"
  version = "1.20.2-do.0"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = 3
  }
}

resource "kubernetes" "dev" {
  host = digitalocean_kubernetes_cluster.dev.ipv4_address

  client_certificate     = digitalocean_kubernetes_cluster.dev.kube_config.0.client_certificate
  client_key             = digitalocean_kubernetes_cluster.dev.kube_config.0.client_key
  cluster_ca_certificate = digitalocean_kubernetes_cluster.dev.kube_config.0.cluster_ca_certificate
}
