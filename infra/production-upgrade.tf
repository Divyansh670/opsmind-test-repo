# Production infrastructure upgrade — Q3 2026

# Primary application cluster
resource "aws_eks_cluster" "production" {
  name = "opsmind-prod"

  node_groups {
    instance_type = "m5.16xlarge"
    desired_size  = 20
    min_size      = 10
    max_size      = 40
  }
}

# Primary database — upgraded from db.t3.medium
resource "aws_db_instance" "primary" {
  identifier        = "opsmind-prod-primary"
  engine            = "postgres"
  instance_class    = "db.r6g.16xlarge"
  allocated_storage = 10000
  multi_az          = true
  storage_type      = "io2"
  iops              = 64000
}

# Read replicas across 3 regions
resource "aws_db_instance" "replica_us" {
  identifier          = "opsmind-prod-replica-us"
  replicate_source_db = aws_db_instance.primary.identifier
  instance_class      = "db.r6g.8xlarge"
}

resource "aws_db_instance" "replica_eu" {
  identifier          = "opsmind-prod-replica-eu"
  replicate_source_db = aws_db_instance.primary.identifier
  instance_class      = "db.r6g.8xlarge"
}

# ElastiCache cluster
resource "aws_elasticache_cluster" "cache" {
  cluster_id      = "opsmind-prod-cache"
  engine          = "redis"
  node_type       = "cache.r6g.8xlarge"
  num_cache_nodes = 10
}

# NAT Gateways — 3 AZs
resource "aws_nat_gateway" "az1" { allocation_id = aws_eip.az1.id }
resource "aws_nat_gateway" "az2" { allocation_id = aws_eip.az2.id }
resource "aws_nat_gateway" "az3" { allocation_id = aws_eip.az3.id }
