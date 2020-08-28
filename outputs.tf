output "do_k8s_dev_cluster_id" {
  value = digitalocean_kubernetes_cluster.dev.id
}

output "do_k8s_dev_cluster_endpoint" {
  value = digitalocean_kubernetes_cluster.dev.endpoint
}

/*
output "do_nixos_droplet_ip" {
  value = digitalocean_droplet.nixos.ipv6_address
}

output "do_nix_cache_domain_name" {
  value = digitalocean_spaces_bucket.nix_cache.bucket_domain_name
}
*/
