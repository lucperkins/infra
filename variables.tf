# Digital Ocean
variable "do_token" {
  type = string
}

variable "do_region" {
  type    = string
  default = "sfo2"
}

variable "do_k8s_image_size" {
  type    = string
  default = "s-1vcpu-2gb"
}

variable "do_droplet_image_size" {
  type    = string
  default = "s-2vcpu-4gb"
}
