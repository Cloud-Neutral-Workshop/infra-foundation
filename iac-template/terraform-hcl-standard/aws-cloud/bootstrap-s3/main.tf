resource "aws_s3_bucket" "state" {
  bucket = local.bucket_name
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_tagging" "default" {
  bucket = aws_s3_bucket.state.id

  tag_set = [for k, v in merge({
    Name        = local.bucket_name
    Environment = local.environment
  }, local.tags) : {
    key   = k
    value = v
  }]
}
