terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0.0"
    }
  }
}
provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      created_by = "yossi mizrahi"
      managed_by = "terraform"
    }
  }
}
