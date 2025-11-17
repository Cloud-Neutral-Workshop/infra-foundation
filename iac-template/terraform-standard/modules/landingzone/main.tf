locals {
  root_policy       = var.enable_root_limited     ? "deny-root.json"          : null
  mfa_policy        = var.enable_mfa_enforce      ? "deny-no-mfa.json"        : null
  console_policy    = var.console_mode == "readonly" ? "deny-console-write.json" : null
  risp_policy       = var.enable_risp_controls    ? "deny-ri-sp.json"         : null

  policies = compact([
    local.root_policy,
    local.mfa_policy,
    local.console_policy,
    local.risp_policy
  ])
}

#
# Baseline IAM group
#
resource "aws_iam_group" "baseline" {
  name = "LandingZoneBaseline"
}

#
# Create IAM policies
#
resource "aws_iam_policy" "baseline" {
  for_each = toset(local.policies)

  name   = "landingzone-${replace(each.value, ".json", "")}"
  policy = file("${path.module}/policies/${each.value}")
}

#
# Attach policies to baseline group
#
resource "aws_iam_group_policy_attachment" "attach" {
  for_each  = aws_iam_policy.baseline

  group      = aws_iam_group.baseline.name
  policy_arn = each.value.arn
}
