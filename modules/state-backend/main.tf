resource "aws_s3_bucket" "tf_state" {
  bucket = var.bucket_name
  force_destroy = true

  tags = {
    Name        = "${var.bucket_name}"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "tf_lock" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = var.dynamodb_table_name
    Environment = var.environment
  }
}

resource "aws_kms_key" "tf_state" {
  description         = "KMS key for encrypting Terraform state"
  enable_key_rotation = true

  tags = {
    Name        = "${var.bucket_name}-key"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_encrypt" {
  bucket = aws_s3_bucket.tf_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.tf_state.arn
    }
  }
}
