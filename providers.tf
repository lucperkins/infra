provider "digitalocean" {
  token = var.do_token
}

provider "cloudflare" {
  version    = "~> 2.0"
  email      = var.email
  api_key    = var.cloudflare_api_key
  account_id = var.cloudflare_account_id
}
