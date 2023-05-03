terraform {
  required_version = "0.13.7"

  required_providers {
    aws = {
      version = "3.73.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = local.common_tags
  }
}