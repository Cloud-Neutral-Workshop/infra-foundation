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

resource "alicloud_ots_instance" "this" {
  instance_name = var.instance_name
  description   = "Terraform state locking"
  accessed_by   = "Any"
}

resource "alicloud_ots_table" "lock" {
  instance_name = alicloud_ots_instance.this.name
  table_name    = var.table_name

  time_to_live = -1
  max_version  = 1

  primary_key {
    name = "LockID"
    type = "STRING"
  }
}

output "lock_table" {
  value = alicloud_ots_table.lock.table_name
}
