terraform {
  backend "s3" {
    bucket         = "svc-plus-iac-state"
    key            = "bootstrap/dev-landingzone/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "svc-plus-iac-state-dynamodb-lock"
  }
}
