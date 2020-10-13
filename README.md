# task6-HMC

# TASK:

Deploy the WordPress application on Kubernetes and AWS using terraform including the following steps:
1. Write an Infrastructure as code using Terraform, which automatically deploy the WordPress application
2. On AWS, use RDS service for the relational database for WordPress application.
3. Deploy the WordPress as a container either on top of Minikube or EKS or Fargate service on AWS
4. The WordPress application should be accessible from the public world if deployed on AWS or through workstation if deployed on Minikube.

# STEPS INVOLVED:

Step 1: Install Above All Software.

Step 2: Create New Folder for this Task.( In cli.)
       
          cd desktop
          mkdir Yourfoldernamehere
          cd yourcreatedfoldername
          
Step 3: After This go for creating you First terraform File .tf

          notepad main.tf
          
Step 4: Inside main.tf Create your code.

                  provider "kubernetes" {
                   config_context_cluster = "minikube"
                  }
                  Create resources :
                  resource "kubernetes_deployment" "wordpresspod" {
                   metadata {
                    name = "wordpress"
                  }
                  Create spec & Template:
                  spec {
                    replicas = 2

                    selector {
                     match_labels = {
                      env = "dev"
                      region = "IN"
                      App = "wordpress"
                     }

                    }

                    template {
                     metadata {
                      labels = {
                       env = "dev"
                       region = "IN"
                       App = "wordpress"

                  }
                  }
                  
Create WordPress with Port 80:

              spec {
                  container {
                   image = "wordpress:4.8-apache"
                   name = "wordpressdb"
                  }
                 }
                }
               }
              }
  
            port {
             node_port = 32123
             port = 80
             target_port = 80
            }

            type = "NodePort"
           }
          }
          
Here you have created main.tf file.
Now Start minikube :

        minikube start

Step 5: Run This Command for run Terraform file.
(First: this is for initializing terraform.)

        terraform init
