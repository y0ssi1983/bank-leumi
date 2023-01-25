terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
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
resource "aws_s3_bucket" "lambda-leumi" {
  bucket = "lambda-leumi"
  tags = {
    Name = "Lambda-bucket"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.lambda-leumi.id
  acl    = "private"
}