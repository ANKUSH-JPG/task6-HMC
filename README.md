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
        
![1](https://user-images.githubusercontent.com/51692515/95902704-c6779e80-0db2-11eb-8088-c1be8cfe042a.jpg)

Step 6: Now Run this Command:
     
       terraform apply
       
![2](https://user-images.githubusercontent.com/51692515/95902708-c7103500-0db2-11eb-9684-53249a5b0b43.jpg)

![3](https://user-images.githubusercontent.com/51692515/95902712-c7a8cb80-0db2-11eb-9302-ab91538d7cb3.jpg)

![4](https://user-images.githubusercontent.com/51692515/95902716-c8416200-0db2-11eb-89cf-b722e2bd13fd.jpg)

![5](https://user-images.githubusercontent.com/51692515/95902689-c24b8100-0db2-11eb-80ca-c6b29348669a.jpg)

Here Successfully Created.
Now On Other Side lets check the pods:

![6](https://user-images.githubusercontent.com/51692515/95902692-c4154480-0db2-11eb-9a73-5e91227140a5.jpg)

Step 7: Create Another Terraform file for Database.

       notepad task.tf
       
       
                 provider "aws" {
                region = "ap-south-1"
              }
              resource "aws_db_instance" "db" {

                engine            = "mysql"
                engine_version    = "5.7.30"
                instance_class    = "db.t2.micro"
                allocated_storage = 10
                name     = "mydb"
                username = "wordpress_user"
                password = "rootroot"
                port     = "3306"
                publicly_accessible = true
                iam_database_authentication_enabled = true
                vpc_security_group_ids = ["sg-041bf4230a162e7d0"]
                tags = {
                   Name = "mysql"
               }
              }
              
On AWS :

![7](https://user-images.githubusercontent.com/51692515/95902696-c4addb00-0db2-11eb-9f7a-582301856b41.png)

# Now Lets Check our Minikube ip:

        minikube ip
        
![8](https://user-images.githubusercontent.com/51692515/95902698-c5467180-0db2-11eb-9b66-fa4471e80471.jpg)
        
 here we get our ip just open this Url.
 
 ![9](https://user-images.githubusercontent.com/51692515/95902700-c5df0800-0db2-11eb-8dfb-a8324429c22e.jpg)
 
![10](https://user-images.githubusercontent.com/51692515/95902701-c5df0800-0db2-11eb-9d7b-a9253cf01f19.jpg)

