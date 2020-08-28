provider "digitalocean" {
  version = "1.22.2"

  token = var.do_token

  spaces_access_id = var.do_spaces_access_id
  spaces_secret_key = var.do_spaces_secret_key
}

provider "cloudflare" {
  version    = "~> 2.0"
  email      = var.email
  api_key    = var.cloudflare_api_key
  account_id = var.cloudflare_account_id
}
