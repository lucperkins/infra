provider "cloudflare" {
  version    = "~> 2.0"
  email      = var.email
  api_key    = var.cloudflare_api_key
  account_id = var.cloudflare_account_id
}

resource "cloudflare_workers_kv_namespace" "main" {
  title = "main"
}

resource "cloudflare_workers_kv" "name" {
  namespace_id = cloudflare_workers_kv_namespace.main.id
  key          = "secret"
  value        = "open-sesame-123"
}
