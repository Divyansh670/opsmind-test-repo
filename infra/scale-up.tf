resource "aws_db_instance" "main" {
  identifier        = "opsmind-main"
  instance_class    = "db.r5.4xlarge"
  allocated_storage = 1000
  multi_az          = true
}

resource "aws_elasticache_cluster" "cache" {
  cluster_id      = "opsmind-cache"
  node_type       = "cache.r6g.4xlarge"
  num_cache_nodes = 5
}
