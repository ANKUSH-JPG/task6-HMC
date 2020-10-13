# Kubernetes Provider
provider "kubernetes" {
   config_context_cluster = "minikube"
}
# AWS Provider
provider "aws" {
  profile = "eks"
  region  = "ap-south-1"
}

# VPC data soruce
data "aws_vpc" "rds_vpc" {
  default = true
}

# Subnet data source
data "aws_subnet_ids" "rds_sub" {
  vpc_id = data.aws_vpc.rds_vpc.id
}