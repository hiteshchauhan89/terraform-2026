resource "aws_s3_bucket" "levelup_s3bucket" {
  bucket = "levelupbucket-141"

  tags = {
    Name = "levelupbucket-141"
  }
}

# Enforce bucket ownership and private access (recommended)
resource "aws_s3_bucket_ownership_controls" "levelup_ownership" {
  bucket = aws_s3_bucket.levelup_s3bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "levelup_block" {
  bucket = aws_s3_bucket.levelup_s3bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
