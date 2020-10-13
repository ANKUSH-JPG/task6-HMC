# Deploy a pods
resource "kubernetes_deployment" "wordpress_rds" {
    depends_on = [
    aws_db_instance.rds_minikube
    ]
  metadata {
    name = "wordpress"
    labels = {
      app = "wordpress"
    }
  }
  spec {
    selector {
      match_labels = {
        app = "wordpress"
      }
    }
    template {
      metadata {
        labels = {
          app = "wordpress"
        }
      }
      spec {
        container {
          image = "wordpress"
          name  = "myapp"
          env {
            name = "WORDPRESS_DB_HOST"
            value = aws_db_instance.rds_minikube.endpoint
            }
          env {
            name = "WORDPRESS_DB_DATABASE"
            value = aws_db_instance.rds_minikube.name 
            }
          env {
            name = "WORDPRESS_DB_USER"
            value = aws_db_instance.rds_minikube.username
            }
          env {
            name = "WORDPRESS_DB_PASSWORD"
            value = aws_db_instance.rds_minikube.password
          }
          port {
        container_port = 80
          }
        }
      }
    }
  }
}

# Expose Service 
resource "kubernetes_service" "wordpress_service" {
    depends_on = [ kubernetes_deployment.wordpress_rds , ]
  metadata {
    name = "wordpress-service"
  }
  spec {
    selector = {
      app = "wordpress"
    }
    port {
      port = 80
      target_port = 80
      node_port =  30001
    }

    type = "NodePort"
  }
}
