# TODO: Move these variables up to root?

# AWS
variable "partition" {
  description = "The AWS partition to limit to. Defaults to: current inferred partition. Could be wildcarded."
  default     = ""
}

variable "account_id" {
  description = "The AWS account ID to limit to. Defaults to: current inferred account id. Could be wildcarded."
  default     = ""
}

variable "region" {
  description = "The deploy target region in AWS. Defaults to: current inferred region"
  default     = ""
}

variable "iam_region" {
  description = "The IAM region restriction for permissions (defaults to 'any region')."
  default     = "*"
}

# Our custom stack / environment
variable "stage" {
  description = "The stage/environment to deploy to. Suggest: `sandbox`, `development`, `staging`, `production`."
  default     = "development"
}

variable "service_name" {
  description = "Name of service / application"
}

# Terraform service name.
# _Note_: Defaults are performed in local variables.
variable "tf_service_name" {
  description = "The unique name of service for Terraform resources. Defaults to: `tf-SERVICE_NAME`."
  default     = ""
}

# Serverless version (to synchronize with).
# _Note_: Defaults are performed in local variables.
variable "sls_service_name" {
  description = "The service name from Serverless configuration. Defaults to: `sls-SERVICE_NAME`."
  default     = ""
}

data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  partition    = "${var.partition != "" ? var.partition : data.aws_partition.current.partition}"
  account_id    = "${var.account_id != "" ? var.account_id : data.aws_caller_identity.current.account_id}"
  region    = "${var.region != "" ? var.region : data.aws_region.current.name}"
  iam_region = "${var.iam_region}"
  stage = "${var.stage}"
  service_name = "${var.service_name}"
  tf_service_name   = "${var.tf_service_name != "" ? var.tf_service_name : "tf-${var.service_name}"}"
  sls_service_name  = "${var.sls_service_name != "" ? var.sls_service_name : "sls-${var.service_name}"}"
}