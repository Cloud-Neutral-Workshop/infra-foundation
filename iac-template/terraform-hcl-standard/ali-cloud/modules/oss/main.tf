resource "alicloud_oss_bucket" "this" {
  bucket = var.name
  acl    = var.acl

  versioning {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }

  server_side_encryption_rule {
    sse_algorithm = var.sse_algorithm
  }
}

output "bucket" {
  value = alicloud_oss_bucket.this.bucket
}
