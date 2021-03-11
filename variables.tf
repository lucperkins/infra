# Digital Ocean
variable "do_token" {
  type = string
}

variable "do_k8s_region" {
  type    = string
  default = "sfo3"
}

variable "do_k8s_droplet_image_size" {
  type    = string
  default = "s-2vcpu-4gb"
}

variable "do_k8s_node_pool_size" {
  type    = number
  default = 3
}
