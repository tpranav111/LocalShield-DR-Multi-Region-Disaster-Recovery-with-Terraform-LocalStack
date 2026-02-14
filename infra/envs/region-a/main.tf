terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = var.aws_region
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    s3  = var.localstack_endpoint
    iam = var.localstack_endpoint
    sts = var.localstack_endpoint
  }
}

locals {
  default_tags = merge(
    var.tags,
    {
      environment = "local"
      region      = var.aws_region
      stack       = "dr-sim"
    }
  )
}

module "storage" {
  source       = "../../modules/storage"
  bucket_name  = var.bucket_name
  region_label = var.aws_region
  tags         = local.default_tags
}
