variable "region" {
  description = "Region to deploy the infrastructure"
  type        = string
}
variable "env" {
  type        = string
  description = "Environment"
  validation {
    condition     = contains(["dev", "prod"], var.env)
    error_message = "El ambiente debe ser dev o prod."
  }
}

variable "acl" {
  type        = string
  description = "Access Control List (ACL) enable you to manage access to buckets and objects"
}

variable "app_name" {
  type        = string
  description = "application name"
}
