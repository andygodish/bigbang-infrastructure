resource "aws_s3_bucket" "bucket_gitlab_main" {
  bucket        = lower("${var.name}-${var.random_append}-dst-reports")
  force_destroy = true

  tags = merge({}, var.tags)
}
