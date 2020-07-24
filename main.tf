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
  version      = data.digitalocean_kubernetes_versions.dev.latest_version

  node_pool {
    name       = "default-pool"
    size       = "s-2vcpu-2gb"
    node_count = 1

    labels = {
      service  = "default"
      priority = "high"
    }
  }
}


resource "digitalocean_kubernetes_node_pool" "workers" {
  cluster_id = digitalocean_kubernetes_cluster.dev.id

  name       = "worker-pool"
  size       = "c-2"
  auto_scale = true
  min_nodes  = 1
  max_nodes  = 5

  labels = {
    service  = "workers"
    priority = "low"
  }
}

provider "kubernetes" {
  load_config_file = false
  host             = digitalocean_kubernetes_cluster.dev.endpoint
  token            = digitalocean_kubernetes_cluster.dev.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.dev.kube_config[0].cluster_ca_certificate
  )
}
