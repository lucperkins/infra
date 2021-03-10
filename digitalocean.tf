resource "digitalocean_droplet" "rust" {
  image = "ubuntu-20-04-x64"
  name = "rust-1"
  region = "nyc1"
  size = "s-4vcpu-8gb"
}
