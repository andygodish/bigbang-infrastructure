resource "aws_s3_bucket" "bucket_gitlab_main" {
  bucket        = lower("${var.name}-${var.random_append}-gitlab-main")
  force_destroy = true

  tags = merge({}, var.tags)
}

resource "aws_s3_bucket" "bucket_gitlab_artifacts" {
  bucket        = lower("${var.name}-${var.random_append}-gitlab-artifacts")
  force_destroy = true

  tags = merge({}, var.tags)
}

resource "aws_s3_bucket" "bucket_gitlab_registry" {
  bucket        = lower("${var.name}-${var.random_append}-gitlab-registry")
  force_destroy = true

  tags = merge({}, var.tags)
}

resource "aws_s3_bucket" "bucket_gitlab_uploads" {
  bucket        = lower("${var.name}-${var.random_append}-gitlab-uploads")
  force_destroy = true

  tags = merge({}, var.tags)
}
