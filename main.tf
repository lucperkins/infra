provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_kubernetes_versions" "dev" {
  version_prefix = "1.18."
}
