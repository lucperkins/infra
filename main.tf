provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_kubernetes_versions" "dev" {
  version_prefix = "1.18."
}

resource "digitalocean_kubernetes_cluster" "dev" {
  name         = "k8s-dev"
  region       = var.do_region
  auto_upgrade = true
  version      = digitalocean_kubernetes_versions.dev.latest_version

  node_pool {
    name       = "default"
    size       = var.do_k8s_image_size
    node_count = 1
  }
}
