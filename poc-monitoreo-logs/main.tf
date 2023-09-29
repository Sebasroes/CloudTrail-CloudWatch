provider "aws" {
  region = var.region
}

module "s3_monitor_logs_bucket" {
  source      = "git::git@github.com:Grupo-ASD/modules_terraform.git//modules/bucket-s3?ref=20230503"
  bucket_name = "${var.app_name}-${var.env}-${var.region}-monitoreo-logs"
  acl         = var.acl
  Environment = var.env
}

module "monitoreo" {
  source       = "./custom_modules/monitoreo"
  s3_bucket_id = module.s3_monitor_logs_bucket.s3_bucket_id
  cluster_name = var.app_name

}
