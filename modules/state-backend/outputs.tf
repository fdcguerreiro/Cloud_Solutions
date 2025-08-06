output "bucket_name" {
  value = aws_s3_bucket.tf_state.id
}

output "bucket_arn" {
  value = aws_s3_bucket.tf_state.arn
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.tf_lock.name
}

output "dynamodb_arn" {
  value = aws_dynamodb_table.tf_lock.arn
}

output "kms_key_arn" {
  value = aws_kms_key.tf_state.arn
}

