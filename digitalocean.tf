resource "digitalocean_kubernetes_cluster" "dev" {
  name    = "datadog-dev"
  region  = var.do_k8s_region
  version = "1.20.2-do.0"

  node_pool {
    name       = "worker-pool"
    size       = var.do_k8s_droplet_image_size
    node_count = var.do_k8s_node_pool_size
  }
}


provider "kubernetes" {
  version = "2.0.2"

  host = digitalocean_kubernetes_cluster.dev.ipv4_address

  client_certificate     = base64decode(digitalocean_kubernetes_cluster.dev.kube_config.0.client_certificate)
  client_key             = base64decode(digitalocean_kubernetes_cluster.dev.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(digitalocean_kubernetes_cluster.dev.kube_config.0.cluster_ca_certificate)
}

resource "kubernetes_namespace" "vector" {
  metadata {
    name = "vector"
  }
}

resource "kubernetes_deployment" "vector_aggregator" {
  metadata {
    name      = "vector-aggregator"
    namespace = kubernetes_namespace.vector.metadata.0.name
  }
  spec {
    replicas = var.vector_num_aggregators
    selector {
      match_labels = {
        app = "vector-aggregator"
      }
    }
    template {
      metadata {
        labels = {
          app = "vector-aggregator"
        }
      }
      spec {
        container {
          image = "timberio/vector:0.12.0-debian"
          name  = "vector-aggregator"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "vector_aggregator" {
  metadata {
    name      = "vector-aggregator"
    namespace = kubernetes_namespace.vector.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.vector_aggregator.spec.0.template.0.metadata.0.labels.app
    }
    type = "NodePort"
    port {
      node_port   = 30201
      port        = 80
      target_port = 80
    }
  }
}
