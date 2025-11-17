variable "region" {
  type = string
}

variable "account_id" {
  type = string
}

variable "console_mode" {
  type    = string
  default = "readonly"
}

variable "enable_risp_controls" {
  type    = bool
  default = true
}

variable "enable_root_limited" {
  type    = bool
  default = true
}

variable "enable_mfa_enforce" {
  type    = bool
  default = true
}
