resource "digitalocean_kubernetes_cluster" "dev" {
  name   = "datadog-dev"
  region = "sfo3"
  version = "1.20.2-do.0"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = 3
  }
}