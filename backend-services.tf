resource "aws_db_subnet_group" "profile-rds-subgrp" {
  name       = "main"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Name = "Subnet group for RDS"
  }
}

resource "aws_elasticache_subnet_group" "profile-ecache-subgrp" {
  name       = "profile-ecache-subgrp"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
}

resource "aws_db_instance" "profile-rds" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.37"
  instance_class         = "db.t3.micro"
  username               = var.dbuser
  password               = var.dbpass
  parameter_group_name   = "default.mysql8.0"
  multi_az               = "false"
  publicly_accessible    = "false"
  skip_final_snapshot    = "true"
  db_subnet_group_name   = aws_db_subnet_group.profile-rds-subgrp.name
  vpc_security_group_ids = [aws_security_group.profile-backend-sg.id]
}

resource "aws_elasticache_cluster" "profile-cache" {
  cluster_id           = "profile-cache"
  engine               = "memcached"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.5"
  port                 = 11211
  security_group_ids   = [aws_security_group.profile-backend-sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.profile-ecache-subgrp.name
}

resource "aws_mq_broker" "profile-rmq" {

  broker_name        = "profile-rmq"
  engine_type        = "ActiveMQ"
  engine_version     = "5.18.0"
  host_instance_type = "mq.t3.micro"
  security_groups    = [aws_security_group.profile-backend-sg.id]
  subnet_ids         = [module.vpc.private_subnets[0]]

  user {
    username = var.rmquser
    password = var.rmqpass
  }
}
