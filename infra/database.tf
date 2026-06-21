# Production database configuration
resource "aws_db_instance" "production" {
  identifier        = "opsmind-prod-db"
  engine            = "postgres"
  instance_class    = "db.r5.8xlarge"
  allocated_storage = 500
  multi_az          = true
  storage_type      = "io1"
  iops              = 10000
}

resource "aws_db_instance" "replica" {
  identifier          = "opsmind-prod-replica"
  replicate_source_db = aws_db_instance.production.identifier
  instance_class       = "db.r5.8xlarge"
}
