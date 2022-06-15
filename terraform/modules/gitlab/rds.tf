module "gitlab_rds" {
  source  = "terraform-aws-modules/rds/aws"

  engine            = "mysql"
  engine_version    = "5.7.25"
  instance_class    = "db.t3a.large"
  allocated_storage = 5
}