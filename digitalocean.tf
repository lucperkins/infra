data "digitalocean_kubernetes_versions" "dev" {
  version_prefix = "1.18."
}

resource "digitalocean_kubernetes_node_pool" "dev" {
  name       = "k8s-dev-pool"
  size       = var.do_k8s_image_size
  cluster_id = digitalocean_kubernetes_cluster.dev.id
  auto_scale = true
  min_nodes  = 1
  max_nodes  = 5
  tags       = ["dev"]
}

resource "digitalocean_kubernetes_cluster" "dev" {
  name    = "k8s-dev"
  region  = var.do_region
  version = data.digitalocean_kubernetes_versions.dev.latest_version
  tags    = ["dev"]

  node_pool {
    name       = "core-pool"
    size       = var.do_k8s_image_size
    node_count = 1
  }
}
