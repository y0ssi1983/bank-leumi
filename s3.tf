resource "aws_s3_bucket" "bank_leumi" {
  bucket = "bank-leumi-bucket"

  tags = {
    Name        = "My bucket"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bank_leumi.id
  acl    = "private"
}
