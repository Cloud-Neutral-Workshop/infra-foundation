#
# IAM Role: Terraform Deploy Role
# ----------------------------------------
resource "aws_iam_role" "terraform_deploy_role" {
  name = local.config_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::${local.account.account_id}:user/${local.config_terraform_user}"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = merge(
    {
      Name        = local.config_role_name
      Environment = coalesce(try(local.account.environment, null), local.environment)
    },
    try(local.account.tags, {}),
    local.extra_tags
  )
}

# 可选：当前阶段保持你原来的 Admin full access
# （未来你可以把它缩到最小权限）
resource "aws_iam_role_policy_attachment" "attach_admin" {
  role       = aws_iam_role.terraform_deploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

#
# IAM User for Terraform (AK/SK)
# ----------------------------------------
resource "aws_iam_user" "terraform_user" {
  name = local.config_terraform_user
}

#
# IAM User Policy: 最小权限
# ----------------------------------------
resource "aws_iam_user_policy" "terraform_user_policy" {
  name = "${local.config_terraform_user}-iac-policy"
  user = aws_iam_user.terraform_user.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # 允许 Assume TerraformDeployRole
      {
        Effect = "Allow",
        Action = [
          "sts:AssumeRole"
        ],
        Resource = aws_iam_role.terraform_deploy_role.arn
      },

      # S3: Terraform state bucket
      {
        Effect = "Allow",
        Action = [
          "s3:ListBucket"
        ],
        Resource = "arn:aws:s3:::${local.bootstrap.state.bucket_name}"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        Resource = "arn:aws:s3:::${local.bootstrap.state.bucket_name}/*"
      },

      # DynamoDB: state lock table
      {
        Effect = "Allow",
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:UpdateItem",
          "dynamodb:DescribeTable"
        ],
        Resource = "arn:aws:dynamodb:${local.config_region}:${local.account.account_id}:table/${local.bootstrap.state.dynamodb_table_name}"
      }
    ]
  })
}
