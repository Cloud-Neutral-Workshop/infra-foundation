terraform {
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = ">= 1.210.0"
    }
  }
}

provider "alicloud" {
  region = var.region
}

resource "alicloud_oss_bucket" "state" {
  bucket = var.state_bucket
  acl    = var.acl

  versioning {
    status = "Enabled"
  }

  server_side_encryption_rule {
    sse_algorithm = "AES256"
  }
}

output "bucket" {
  value = alicloud_oss_bucket.state.bucket
}
