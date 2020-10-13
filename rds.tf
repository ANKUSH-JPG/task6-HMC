# subnet group for RDS
resource "aws_db_subnet_group" "rds_sub_1" {
  name       = "rds_k8s_subnet"
  subnet_ids = data.aws_subnet_ids.rds_sub.ids

  tags = {
    Name = "AWS-k8s-db"
  }
}

# Security Group for RDS
resource "aws_security_group" "rds_k8s_sg" {
  name        = "allow_rds"
  description = "allow rds for minikube"
  vpc_id      = data.aws_vpc.rds_vpc.id

  ingress {
    description = "MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds_k8s_sg"
  }
}

# DB For minikube
resource "aws_db_instance" "rds_minikube" {
  engine                 = "mysql"
  engine_version         = "5.7"
  storage_type           = "gp2"
  allocated_storage      = 20
  identifier             = "wordpress-db"
  username               = "redhat"
  password               = "12345Six"
  instance_class         = "db.t2.micro"
  db_subnet_group_name   = aws_db_subnet_group.rds_sub_1.id
  vpc_security_group_ids = [aws_security_group.rds_k8s_sg.id]
  publicly_accessible    = true
  name                   = "minikube_db"
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
}
