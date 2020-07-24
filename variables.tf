# Digital Ocean
variable "do_token" {
  type = string
}

# CloudFlare
variable "cloudflare_api_key" {
  type = string
}

variable "cloudflare_account_id" {
  type = string
}

variable "email" {
  type    = string
  default = "lucperkins@gmail.com"
}
