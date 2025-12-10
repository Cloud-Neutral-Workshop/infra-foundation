output "bucket_name" {
  value = aws_s3_bucket.state.bucket
}

output "bucket_arn" {
  value       = aws_s3_bucket.state.arn
  description = "ARN of the Terraform state bucket"
}

output "region" {
  value       = local.region
  description = "AWS region hosting the state bucket"
}
