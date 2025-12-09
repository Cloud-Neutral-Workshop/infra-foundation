output "iam_role_arn" {
  value       = aws_iam_role.terraform_deploy_role.arn
  description = "The ARN of the role assumed by Terraform"
}

output "terraform_user_name" {
  value       = aws_iam_user.terraform_user.name
  description = "Terraform IAM User"
}
